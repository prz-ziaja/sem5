import logging
from saport.simplex.model import Model 

def run():
    #TODO:
    # fill missing test based on the example_01_solvable.py
    # to make the test a bit more interesting:
    # * make the solver use artificial variables!
    model = Model("ex4")

    x1 = model.create_variable("x1")
    x2 = model.create_variable("x2")

    model.add_constraint(2*x1 - x2 <= -1)
    model.add_constraint(x1 + x2 == 3)

    model.maximize(x1 + 3*x2)

    try:
        solution = model.solve()
    except:
        raise AssertionError("Solution not found!")

    logging.info(solution)

    assert (solution.assignment == [0.0, 3.0]), "NOT OK!!!"
    logging.info("OK")


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO, format='%(message)s')
    run()
