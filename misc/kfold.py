# Import all the necessary libraries.
import numpy as np
import sklearn as skl
from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score

# Instantiate the k-Fold object.
kfold = KFold(n_splits=10, shuffle=True, random_state=100)

mean_vec = []; std_vec = []
for d in range(1, 13):
    polynomial_regression = skl.pipeline.Pipeline([
		("poly_features", skl.preprocessing.PolynomialFeatures(degree=d, include_bias=True)),
        ("std_scaler", skl.preprocessing.StandardScaler()),
        ("lin_reg", skl.linear_model.LinearRegression()),
    ])

    lin_scores = cross_val_score(polynomial_regression, x, y_noisy, scoring='neg_mean_squared_error', cv=kfold)
        
    scores = np.sqrt(-lin_scores)
    mean_vec.append(scores.mean())
    std_vec.append(scores.std())