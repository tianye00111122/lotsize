import gurobipy as gp
from gurobipy import GRB
import numpy as np
import time


def optimize_shipment_plan(cr, ct, demand_type='convex', max_secs=600, delta_t=0.5, T_total=100, verbose=False):
    """
    Solve the shipment planning problem for given rental and fixed costs.

    Parameters:
        cr (float): Rental cost per unit shipment size s
        ct (float): Fixed cost per shipment
        demand_type: demand type - convex, concave, logistic
        max_secs: time to terminate solver
        delta_t (float): Time step in seconds
        T_total (float): Total physical time in seconds
        verbose (bool): If True, print intermediate output

    Returns:
        dict: {
            's': optimal shipment size,
            'total_cost': total cost,
            'rental_cost': cr * s,
            'fixed_cost': ct * #shipments,
            'holding_cost': ci * delta_t * total inventory,
            't_init': shipment start times in seconds (list),
            'v_init': shipment sizes (list),
            'elapsed': runtime in seconds
        }
    """
    ci = 1  # Inventory holding cost
    k = 1  # v_max = k * s
    T = int(T_total / delta_t)

    # Prepare demand
    time_arr = np.arange(T + 1) * delta_t + 1e-3
    if demand_type == 'convex':
        demand = 0.5 * time_arr
    elif demand_type == 'concave':
        demand = 125 / np.sqrt(time_arr)
    elif demand_type == 'logistic':
        demand = 2685 * (1 / (1 + np.exp((-time_arr + 50) / 15))) ** 2 * np.exp((-time_arr + 50) / 15) * (1 / 15)

    cum_demand = np.cumsum(demand) * delta_t
    Dtot = cum_demand[-1]

    # Build model
    model = gp.Model("shipment_optimization")
    model.setParam("OutputFlag", 1 if verbose else 0)

    s = model.addVar(lb=0, ub=500, name="s")
    v = model.addVars(T, lb=0, name="v")
    inv = model.addVars(T, lb=0, name="inv")
    is_ship = model.addVars(T, vtype=GRB.BINARY, name="is_ship")

    for t in range(T):
        model.addConstr(s >= v[t], name=f"s_ge_v_{t}")
        model.addConstr(v[t] <= k * s * is_ship[t], name=f"cap_{t}")
        cum_ship = gp.quicksum(v[tau] for tau in range(t + 1))
        model.addConstr(cum_ship >= cum_demand[t], name=f"dem_{t}")
        model.addConstr(inv[t] == cum_ship - cum_demand[t], name=f"inv_{t}")

    model.addConstr(gp.quicksum(v[t] for t in range(T)) >= Dtot, name="total_demand")

    model.setObjective(
        cr * s +
        (ci * delta_t) * gp.quicksum(inv[t] for t in range(T)) +
        ct * gp.quicksum(is_ship[t] for t in range(T)),
        GRB.MINIMIZE
    )

    start = time.time()
    model.setParam("TimeLimit", max_secs)  # Limit solve time to max_secs seconds
    model.optimize()
    elapsed = time.time() - start

    if model.Status in [GRB.OPTIMAL, GRB.TIME_LIMIT]:
        best_s = s.X
        v_plan = np.array([v[t].X for t in range(T)])
        ship_ts = np.where(v_plan > 1e-6)[0]
        ship_vs = v_plan[ship_ts]
        inv_total = sum(inv[t].X for t in range(T))
        ship_count = sum(is_ship[t].X for t in range(T))

        status_map = {
            GRB.OPTIMAL: "OPTIMAL",
            GRB.TIME_LIMIT: "TIME_LIMIT",
            GRB.INFEASIBLE: "INFEASIBLE",
        }

        return {
            'solution_status_code': model.Status,
            'solution_status': status_map.get(model.Status, "UNKNOWN"),
            'best_s': round(best_s, 4),
            'demand_type': demand_type,
            'cr': cr,
            'ct': ct,
            'total_cost': round(model.ObjVal, 2),
            'rental_cost': round(cr * best_s, 2),
            'transport_cost': round(ct * ship_count, 2),
            'inventory_cost': round(ci * delta_t * inv_total, 2),
            't_updated': [round(t * delta_t, 2) for t in ([0] + ship_ts.tolist()[1:])],
            'v_updated': [round(v, 2) for v in (ship_vs.tolist() + [0])],
            'elapsed_sec': round(elapsed, 4)
        }
    else:
        return {
            'status': model.Status,
            'error': 'Optimization failed',
            'elapsed': round(elapsed, 4)
        }
