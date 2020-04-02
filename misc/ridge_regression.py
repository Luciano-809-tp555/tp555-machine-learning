# Import all the necessary libraries.
import numpy as np
import matplotlib.pyplot as plt
from sklearn.preprocessing import PolynomialFeatures
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import Ridge
from sklearn.pipeline import Pipeline

# Sets the number of examples.
M = 20

# Create target function and its noisy version.
x = np.sort(3*np.random.rand(M, 1), axis=0)
y_noisy = 1 + 0.5*x + np.random.randn(M, 1)/1.5

# Instantiate a polynomial with the given degree.
poly_features = PolynomialFeatures(degree=model_order, include_bias=include_bias)
# Instantiate a scaler that will standardize the features.
std_scaler = StandardScaler()
# Instantiate a Ridge regressor.
reg = Ridge(alpha=lambdas[i], solver="cholesky")

# Create a pipeline of actions.
model = Pipeline([("poly", poly_features),("scaler", std_scaler),("reg", reg),])

# Train model.
model.fit(x, y_noisy)
# Predict.
y_predicted = model.predict(x)