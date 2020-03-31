def stepDecay(alpha_int, t):
    drop = 0.5
    epochs_drop = 4.0
    alpha = alpha_int * math.pow(drop,  math.floor((1+t)/epochs_drop))
    return alpha