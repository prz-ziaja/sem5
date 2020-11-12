from saport.simplex.model import Model 
from saport.simplex.analyser import Analyser

def run():
    primal = Model("z1")

    ss = primal.create_variable("SS")
    s = primal.create_variable("S")
    o = primal.create_variable("O")

    primal.add_constraint(2*ss+2*s+5*o<=40)
    primal.add_constraint(ss+3*s+2*o<=30)
    primal.add_constraint(3*ss+s+3*o<=30)
    primal.maximize(32*ss+24*s+48*o)

    dual = primal.dual()
    primal_solution = primal.solve()

    analyser = Analyser()
    analysis_results = analyser.analyse(primal_solution)
    analyser.interpret_results(primal_solution, analysis_results)

if __name__ == '__main__':
    run()

