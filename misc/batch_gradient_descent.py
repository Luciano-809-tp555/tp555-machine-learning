import numpy as np

# Define the number of examples.
M = 1000

# Generate a linear-looking dataset.
X = 2 * np.random.rand(M, 1)
y = 4 + 3 * X + np.random.randn(M, 1)

# add x0 = 1 to each instance.
X_b = np.c_[np.ones((M, 1)), X]

# Constant learning rate.
eta = 0.1
# Number of iterations.
n_iterations = 1000

# random initialization.
a = np.random.randn(2,1)

# Batch Gradient-Descent.
for iteration in range(n_iterations):
    gradients = -2/M * X_b.T.dot(y - X_b.dot(a))
    a = a - eta * gradients