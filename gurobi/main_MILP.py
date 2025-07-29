from solver import optimize_shipment_plan
import os
import csv
from tqdm import tqdm


def save_outcome_to_csv(outcome, filename="solution/gurobi_solutions.csv"):
    os.makedirs(os.path.dirname(filename), exist_ok=True)
    file_exists = os.path.isfile(filename)

    # Define CSV columns based on keys in outcome dictionary
    columns = list(outcome.keys())

    with open(filename, mode='a', newline='', encoding='utf-8') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=columns)

        # Write header only if file doesn't exist
        if not file_exists:
            writer.writeheader()

        writer.writerow(outcome)


# ==== Problem Parameters ====
cr_list = [1, 20, 400, 8000, 160000] # Rental cost per unit shipment size s
ct_list = [1, 10, 100, 1000, 10000]  # Transport cost per shipment
demand_type_list = ['convex', 'logistic', 'concave']

total_runs = len(demand_type_list) * len(cr_list) * len(ct_list)

run_counter = 0
with tqdm(total=total_runs, desc="Optimization Runs") as pbar:
    for demand_type in demand_type_list:
        for cr in cr_list:
            for ct in ct_list:
                run_counter += 1
                pbar.set_postfix({
                    'demand_type': demand_type,
                    'cr': cr,
                    'ct': ct,
                })
                try:
                    outcome = optimize_shipment_plan(cr, ct, demand_type=demand_type, max_secs=600, verbose=False)
                    save_outcome_to_csv(outcome)
                except Exception as e:
                    print(f"Failed for demand_type={demand_type}, cr={cr}, ct={ct} with error: {e}")
                pbar.update(1)
