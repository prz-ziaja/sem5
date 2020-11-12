import numpy as np
class ObjectiveSensitivityAnalyser:
    """
        A class used to analyse sensitivity to changes of the cost factors.


        Attributes
        ----------
        name : str
            unique name of the analysis tool

        Methods
        -------
        analyse(solution: Solution) -> List[(float, float)]
            analyses the solution and returns list of tuples containing acceptable bounds for every objective coefficient, i.e.
            if the results contain tuple (-inf, 5.0) at index 1, it means that objective coefficient at index 1 should have value >= -inf and <= 5.0
            to keep the current solution an optimum

         interpret_results(solution: Solution, results : List(float, float), print_function : Callable = print):
            prints an interpretation of the given analysis results via given print function
    """    
    @classmethod
    def name(self):
        return "Cost Coefficient Sensitivity Analysis"

    def __init__(self):
        self.name = ObjectiveSensitivityAnalyser.name()
    
    def analyse(self, solution):
        obj_coeffs = solution.normal_model.objective.expression.factors(solution.model)
        final_obj_coeffs = solution.tableaux.table[0,:-1]
        obj_coeffs_ranges = []

        basis = solution.tableaux.extract_basis()
        for (i, obj_coeff) in enumerate(obj_coeffs):
            left_side, right_side = None, None
            if i in basis:
                basis_row = self._extract_row_factors_for_basis_var(i, solution.tableaux.table)
                right_delta, left_delta = self._calculate_delta_bounds_for_basis_var(final_obj_coeffs, basis_row, i)
            else:
                right_delta, left_delta = final_obj_coeffs[i], float('-inf')
            
            right_side = obj_coeff + right_delta
            left_side = obj_coeff + left_delta
            obj_coeffs_ranges.append((left_side, right_side))
        
        return obj_coeffs_ranges


    def interpret_results(self, solution, obj_coeffs_ranges, print_function = print):        
        org_coeffs = solution.normal_model.objective.expression.factors(solution.model)

        print_function("* Cost Coefficients Sensitivity Analysis:")
        print_function("-> To keep the current optimum, the cost coefficients should stay in following ranges:")
        col_width = max([max(len(f'{r[0]:.3f}'), len(f'{r[1]:.3f}')) for r in obj_coeffs_ranges])
        for (i, r) in enumerate(obj_coeffs_ranges):
            print_function(f"\t {r[0]:{col_width}.3f} <= c{i} <= {r[1]:{col_width}.3f}, (originally: {org_coeffs[i]:.3f})")

    def _extract_row_factors_for_basis_var(self, basis_col_ind, table):
        # skip first row, because it corresponds to z, skip las column, because it corresponds to RHS
        factors = table[1:, :-1]
        basis_column = factors[:, basis_col_ind]
        row_ind = np.where(basis_column == 1.0)[0][0]
        row = factors[row_ind]
        return row

    def _calculate_delta_bounds_for_basis_var(self, obj_coeff, basis_row, basis_col_ind):
        """
        Algorithm to found bounds for delta:
        1. Add to obj coefficients, basis row multiplied by delta
        2. For each obje_coeff + delta*basis_row_coeff, create an inequality, such as it should be greater or equal than 0 ( i.e. obj_coeff + delta*basis_row_coeff >= 0)
        3. Move obj_coeff to the right side of the inequality ( delta*basis_row_coeff >= -obj_coeff)
        4. Divide left side by the the right side, to find constraint for delta ( i.e. delta*basis_row_coeff >= -obj_coeff ====> delta >= -obj_coeff/basis_row_coeff)
           tip: if both numbers are negative, we reverse sign
        5. Select highest possible bound and lowest possible bound 
        """
        # Starting from the Step 3.
        bounds = -1 * obj_coeff
        left_delta, right_delta = float('-inf'), float('inf')
        delta_inequalities = zip(basis_row, bounds)

        for col_ind, inequality in enumerate(delta_inequalities):
            delta_coeff, delta_bound = inequality
            if delta_coeff == 0 or col_ind == basis_col_ind:
                continue
            delta_constraint = delta_bound / delta_coeff
            # If bound and coeff are lesser than 0, that means, that we should reverse sign in an inequality from >= to =< 
            if delta_bound < 0 and delta_coeff < 0:
                if delta_constraint < right_delta:
                    right_delta = delta_constraint
            else:
                if delta_constraint > left_delta:
                    left_delta = delta_constraint
        return right_delta, left_delta

