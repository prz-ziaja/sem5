from saport.simplex.model import Model

model = Model("z3")

x = model.create_variable("x")
y = model.create_variable("y")

model.add_constraint(15*x + 2*y <= 60)
model.add_constraint(5*x + 15*y >= 50)
model.add_constraint(20*x + 5*y >= 40)

model.minimize(8*x + 4*y)

solution = model.solve()
print(solution)

