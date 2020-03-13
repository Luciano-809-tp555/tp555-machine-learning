# Number of pairs feature/label.
M = 10000

# Input values (features)
x1 = 10.0*np.random.randn(M, 1)
x2 = 10.0*np.random.randn(M, 1)

# Output values (targets).
y = 2.0*x1 + 2.0*x2 + 10.0*np.random.randn(M, 1)