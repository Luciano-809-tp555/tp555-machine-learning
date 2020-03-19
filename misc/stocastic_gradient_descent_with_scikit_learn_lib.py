import numpy as np

# Usamos a classe SGDRegressor do módulo Linear da biblioteca sklearn.
from sklearn.linear_model import SGDRegressor

# Número de exemplos
M = 1000

# Criamos os features e labels.
x1 = np.random.randn(M, 1)
x2 = np.random.randn(M, 1)
y = 2*x1 + 4*x2 + np.random.randn(M, 1)

# Concatena os vetores coluna x1 e x2.
X = np.c_[x1, x2]

# Instancia a classe SGDRegressor.
sgd_reg = SGDRegressor(max_iter=50, fit_intercept=False)
# Treina o modelo.
sgd_reg.fit(X, y.ravel())

print('a1: %1.4f' % (sgd_reg.coef_[0]))
print('a2: %1.4f' % (sgd_reg.coef_[1]))

a1: 1.9844
a2: 3.9802