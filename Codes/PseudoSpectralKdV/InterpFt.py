# -*- coding: utf-8 -*-
"""
The function file to conduct interpolation with FFT
"""


import numpy as np
import matplotlib.pyplot as plt


def interpft(F, N, input_type='function'):
    ''' Conduct interpolation with FFT
    F: The value of function on equi-spaced points
    N: The number of points want to interpolate on
    input_type: 'function' or 'fft',
    indicate the input is the original function value or the Fourier coef
    '''
    n = len(F)
    if input_type == 'fft':
        F_hat = F
    else:
        # Conduct the fft
        F_hat = np.fft.fft(F)
    # Zero pad the fft coef
    F_hat_pad = np.concatenate((F_hat[0:int((n+1)/2)],
                                np.zeros([N - int(n)]),
                                F_hat[int((n+1)/2)::]))
    # Conduct inverse fft and normalize
    F_pad = np.real(np.fft.ifft(F_hat_pad) * N / n)
    return F_pad
