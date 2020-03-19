import numpy as np

# Define the number of examples.
M = 1000

# Generate target function.
x1 = np.random.randn(M, 1)
x2 = np.random.randn(M, 1)
y = x1 + x2 + np.random.randn(M, 1)

# Concatenate both column vectors, x1 and x2.
X = np.c_[x1, x2]

# Constant learning rate.
eta = 0.1
# Number of iterations.
n_iterations = 1000

# Random initialization.
a = np.random.randn(2,1)

# Batch gradient-descent loop.
for iteration in range(n_iterations):
    gradients = -2/M * X_b.T.dot(y - X_b.dot(a))
    a = a - eta * gradients