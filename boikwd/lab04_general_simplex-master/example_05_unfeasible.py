import logging
from saport.simplex.model import Model
from saport.simplex.solver import ErrorEx5

def run():
    #TODO:
    # fill missing test based on the example_01_solvable.py
    # to make the test a bit more interesting:
    # * make the model unfeasible in a way detectable by the 2-phase simplex
    # 
    model = Model("ex5")

    x1 = model.create_variable("x1")
    x2 = model.create_variable("x2")
    
    model.maximize(x1)
    model.add_constraint(x1 + x2 == 10)
    model.add_constraint(x1 - x2 >= 100)
    
    try:
        solution = model.solve()
    except ErrorEx5:
        logging.info("OK")
    else:
        raise AssertionError("NOT OK!!!")




if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO, format='%(message)s')
    run()
