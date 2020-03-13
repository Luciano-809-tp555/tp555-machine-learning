# Import all the necessary libraries.
import numpy as np

# Generate input/ouput (features/labels) values.
N = 100; # Number of observations.

x = 2 * np.random.rand(N, 1)
y = 4 + 3 * x + np.random.randn(N, 1)

# Solve by applying the least-Squares method.
# We use the inv() function from NumPy’s Linear Algebra module (np.linalg) to compute the inverse of a matrix.
# We use dot() method for matrix multiplication.
X_b = np.c_[np.ones((N, 1)), x] # add x0 = 1 to each instance
a_optimum = np.linalg.inv(X_b.T.dot(X_b)).dot(X_b.T).dot(y)

# Print best solution.
print('a0: ' + str(a_optimum[0][0]))
print('a1: ' + str(a_optimum[1][0]))

a0: 3.8369524631195424
a1: 3.070444775507994

# The equivalent solution using the Scikit-Learn library is given below
# Import the linear regression module form the library.
from sklearn.linear_model import LinearRegression

lin_reg = LinearRegression() # instantiate it.

lin_reg.fit(x, y)

print('a0: ' + str(lin_reg.intercept_[0])) # Value that crosses the y-axis when all fetures are equal to 0.
print('a1: ' + str(lin_reg.coef_[0][0])) # parameters associated with the features.

a0: 3.8369524631195424
a1: 3.070444775507994