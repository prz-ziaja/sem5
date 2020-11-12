from saport.simplex.model import Model

model = Model("z4")

x = [model.create_variable(f'x{i}') for i in range(14)]

model.add_constraint(x[2] + 2*x[3] + x[5] + 2*x[6] + 3*x[7] + x[9] + 2*x[10] + 3*x[11] + 4*x[12] + 5*x[13] >= 150)
model.add_constraint(x[0] + x[1] + x[2] + x[3] >= 150)
model.add_constraint(x[1] + x[4] + x[5] + x[6] + x[7] + 2*x[8] + 2*x[9] >= 200)

model.minimize(95*x[0] + 20*x[1] + 60*x[2] + 25*x[3] + 125*x[4] + 90*x[5] + 55*x[6] + 20*x[7] + 50*x[8] + 15*x[9] +130*x[10] + 95*x[11] + 60*x[12] + 25*x[13] )

solution = model.solve()
print(solution)

