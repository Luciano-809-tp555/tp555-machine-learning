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

# learning schedule hyperparameter.
k = 0.01
# Initial learning rate.
eta_int = 0.1
# Learning schedule function.
def learning_schedule(eta_int, k, t):
    return eta_int*np.exp(-k*t)

# Random initialization of parameters.
a = np.random.randn(2,1) 
# Stocastic gradient-descent loop.
for epoch in range(n_epochs):
    for i in range(M):
        random_index = np.random.randint(M)
        xi = X_b[random_index:random_index+1]
        yi = y[random_index:random_index+1]
        gradients = -2*xi.T.dot(yi - xi.dot(a))
        eta = learning_schedule(eta_int, k, epoch*M + i)
        a = a - eta * gradients