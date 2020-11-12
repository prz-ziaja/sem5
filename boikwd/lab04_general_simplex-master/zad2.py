from saport.simplex.model import Model

model = Model("z2")

a = model.create_variable("a")
b = model.create_variable("b")
c = model.create_variable("c")
d = model.create_variable("d")

model.add_constraint(0.8*a + 2.4*b + 0.9*c + 0.4*d >= 1200)
model.add_constraint(0.6*a + 0.6*b + 0.3*c + 0.3*d >= 600)

model.minimize(9.6*a + 14.4*b + 10.8*c + 7.2*d)

solution = model.solve()
print(solution)

