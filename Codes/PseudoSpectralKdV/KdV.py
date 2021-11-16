# -*- coding: utf-8 -*-
"""
The KdV PDE class defined for ODE solver based on FFT
"""


import numpy as np


class KdV_PDE:

    def __init__(self, initial_value, L=60, N=256):
        '''Initialization of the KdV_PDE class
        initial_value: The initial value (t=0) for KdV PDE
        (defined as a Python function)
        L: The length of space interval (x in [-L/2, L/2])
        N: The number of Fourier modes used for FFT & ODE solver
        '''
        self.initial_value = initial_value
        self.L = L
        self.N = N

    def FFT_modify(self, Phi_hat):
        ''' The function used to deal with the unmatching mode,
        split the unmatched mode into two modes and
        scale accroding to the number of nodes we use
        Phi_hat: The unmatched Fourier sequence
        '''
        if np.mod(self.N, 2) == 0:
            k = int(self.N / 2)
            Phi_hat_m = np.zeros([self.N+1, ]) * 1j
            Phi_hat_m[0:k] = Phi_hat[0:k]
            # Split the mode
            Phi_hat_m[k] = Phi_hat[k] / 2
            Phi_hat_m[k+1] = Phi_hat[k] / 2
            Phi_hat_m[(k+2)::] = Phi_hat[(k+1)::]
            # Scale the modes (due to the implement of Python FFT)
            Phi_hat_m = (2*k+1) / self.N * Phi_hat_m
        else:
            Phi_hat_m = Phi_hat
        return Phi_hat_m

    def initial_FFT(self):
        '''
        Compute the initial value for the FFT ODE of the KdV PDE
        Return the frequencies and the freq with wavenumber 0 seperately
        '''
        X = np.fft.fftfreq(self.N, 1/2) * self.L / 2
        Phi_hat = np.fft.fft(self.initial_value(X))
        phi_0 = Phi_hat[0]
        Phi_hat_m = self.FFT_modify(Phi_hat)
        return (Phi_hat_m, phi_0)

    def stiff_A(self):
        ''' Generate the stiff part of the KdV PDE and return it as a vector
        '''
        k = int(self.N/2) * 2 + 1
        iK3 = np.power(np.fft.fftfreq(k, 1/k) * 2*np.pi/self.L, 3) * 1j
        return iK3

    def smooth_func(self, y):
        ''' Generate the smooth (non-stiff) part of the KdV PDE,
        return it as a Python function
        y: the input of the non-stiff function
        '''
        anti_aliasing = True
        k = int(self.N/2) * 2 + 1
        iK = np.fft.fftfreq(k, 1/k) * 1j * 2*np.pi/self.L
        if anti_aliasing is True:  # With anti-aliasing
            M = 2 * k
            # Oversample
            Phi_hat_pad = np.concatenate((y[0:int((k+1)/2)],
                                          np.zeros([M - k]),
                                          y[int((k+1)/2)::]))
            Phi_pad = np.fft.ifft(Phi_hat_pad)
            # Compute the iFFt
            W_hat_pad = np.fft.fft(np.power(Phi_pad, 2)) * M / k
            # Truncate the fft coef
            W_hat = np.concatenate((W_hat_pad[0:int((k+1)/2)],
                                    W_hat_pad[M-k+int((k+1)/2)::]))
            Kappa_hat = - 3 * iK * W_hat
        else:  # Without anti-aliasing
            Kappa_hat = (- 3 * iK * np.fft.fft(np.power(np.fft.ifft(y), 2)))
        return Kappa_hat


class KdV_PDE_Soliton(KdV_PDE):

    def __init__(self, L=60, N=256, c=1):
        '''Initialization of the KdV_PDE class
        with single solition wave as initial value
        L: The length of space interval (x in [-L/2, L/2])
        N: The number of Fourier modes used for FFT & ODE solver
        c: The speed of soliton wave
        '''
        super(KdV_PDE_Soliton, self).__init__(L, N)
        self.L = L
        self.N = N
        self.c = c
        # The period of the soliton wave
        self.T = L / c

        def soliton_wave(X):
            ''' The soliton wave function'''
            return c / (2 * np.power(np.cosh(np.sqrt(c) * X / 2), 2))
        self.initial_value = soliton_wave
