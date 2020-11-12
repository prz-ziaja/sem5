from saport.simplex.model import Model 

model = Model("z1")

x = model.create_variable("x")
y = model.create_variable("y")
z = model.create_variable("z")

model.add_constraint(x + y + z <= 30)
model.add_constraint(x + 2*y + z >= 10)
model.add_constraint(2 * y + z <= 20)

model.maximize(2 * x + y + 3 * z)

solution = model.solve()
print(solution)

