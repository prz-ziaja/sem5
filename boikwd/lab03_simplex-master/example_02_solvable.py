import logging
from saport.simplex.model import Model 

def run():
    #TODO:
    # fill missing test based on the example_01_solvable.py
    # to make the test a bit more interesting:
    # * minimize the objective (so the solver would have to normalize it)
    # * make some "=>" constraints
    # * the model still has to be solvable by the basix simplex withour artificial variables
    # 
    # TIP: you may use other solvers (e.g. https://online-optimizer.appspot.com)
    #      to find the correct solution
    model = Model("example_02_solvable")

    x1 = model.create_variable("x1")
    x2 = model.create_variable("x2")
    x3 = model.create_variable("x3")

    model.add_constraint(2*x1 + 85*x2 + x3 >= -26)
    model.add_constraint(6*x1 + x2 + 46*x3 <= 156)
    model.add_constraint(2*x1 + 65*x2 + 26*x3 * 2 <= 561)

    model.maximize(3 * x1 + 8 * x2 + 6 * x3)

    try:
        solution = model.solve()
    except:
        raise AssertionError("PROBLEM")

    logging.info(solution)
    assert (list(map(lambda x: round(x, 2), solution.assignment)) == [24.69, 7.87, 0.0, 744.42, 0.0, 0.0]), "Your algorithm found an incorrect solution!"

    logging.info("Congratulations! This solution seems to be alright :)")


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO, format='%(message)s')
    run()
