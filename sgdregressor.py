import numpy as np

# Usamos a classe SGDRegressor do módulo Linear da biblioteca sklearn.
from sklearn.linear_model import SGDRegressor

# Número de exemplos
M = 1000

# Criamos os features e labels.
X = 2 * np.random.rand(M, 1)
y = 4 + 3 * X + np.random.randn(M, 1)

# Instancia a classe SGDRegressor.
sgd_reg = SGDRegressor(max_iter=50, penalty=None, eta0=0.1)
# Treina o modelo.
sgd_reg.fit(X, y.ravel())

print('a0: ', str(sgd_reg.intercept_[0]))
print('a1: ', str(sgd_reg.coef_[0]))



a0:  3.9737315337671637
a1:  3.0153048497350508