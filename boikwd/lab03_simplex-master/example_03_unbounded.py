import logging
from saport.simplex.model import Model 
from saport.simplex.solver import UnboundeLinearProgramException


def run():
    model = Model("example_03")

    x1 = model.create_variable("x1")
    x2 = model.create_variable("x2")
    x3 = model.create_variable("x3")

    model.add_constraint(x1 + x2 + x3 >= -250)
    model.add_constraint(x1 + 100*x2 + 1000*x3 >= -459)
    model.add_constraint(260*x1 + 2*x2 + 500*x3 >= -5156)

    model.maximize(80*x1 + 45*x2 + 2*x3)

    try:
        solution = model.solve()  	
    except UnboundeLinearProgramException:
        logging.info("Congratulations! You found an unfesiable solution :)")
    else:
        raise AssertionError("This problem has no solution but your algorithm hasn't figured it out!")



if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO, format='%(message)s')
    run()
