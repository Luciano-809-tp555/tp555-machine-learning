import numpy as np

# Define the number of examples.
M = 1000

# Generate a linear-looking dataset.
X = 2 * np.random.rand(M, 1)
y = 4 + 3 * X + np.random.randn(M, 1)

# Add x0 = 1 to each instance.
X_b = np.c_[np.ones((M, 1)), X]

# Number of epochs.
n_epochs = 50
# Constant learning rate.
eta = 0.1

# Random initialization of parameters.
a = np.random.randn(2,1) 
# Stocastic gradient-descent loop.
for epoch in range(n_epochs):
    for i in range(M):
        random_index = np.random.randint(M)
        xi = X_b[random_index:random_index+1]
        yi = y[random_index:random_index+1]
        gradients = -2*xi.T.dot(yi - xi.dot(a))
        a = a - eta * gradients