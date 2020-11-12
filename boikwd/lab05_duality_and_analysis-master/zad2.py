from saport.simplex.model import Model 
from saport.simplex.analyser import Analyser

def run():
    primal = Model("z2")
    l = primal.create_variable("l")
    s = primal.create_variable("s")
    k = primal.create_variable("k")

    primal.add_constraint(8*l+6*s+k<=960)
    primal.add_constraint(8*l+4*s+3*k<=800)
    primal.add_constraint(4*l+3*s+k<=320)
    primal.maximize(60*l+30*s+20*k)
    
    dual = primal.dual()
    primal_solution = primal.solve()

    analyser = Analyser()
    analysis_results = analyser.analyse(primal_solution)
    analyser.interpret_results(primal_solution, analysis_results)

if __name__ == '__main__':
    run()

