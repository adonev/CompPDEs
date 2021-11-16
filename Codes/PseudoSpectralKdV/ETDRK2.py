# -*- coding: utf-8 -*-
"""
General ETDRK2 method for ODE (stiff part is a diagonal vector)
"""


import numpy as np


def one_step_ETDRK2(A0_func, A1_func, A2_func, nonstiff_func, t, dt, y):
    ''' One step of ETDRK2 method
    A0_func: Linear function exp(A*dt)
    A1_func: Linear function A^{-1} (exp(A*dt) - I)
    A2_func: Linear function A^{-2} (exp(A*dt) - I - A*dt) / dt
    nonstiff_func: Nonlinear function B
    t: Current time
    dt: Current timestep
    y: Current y
    '''
    B_c = nonstiff_func(y)
    y_n_star = A0_func(y) + A1_func(B_c)
    y_n = y_n_star + A2_func((nonstiff_func(y_n_star) - B_c))
    return y_n


def ETDRK2(stiff_A, nonstiff_func, tspan, y0, dt, keep_zero=True):
    ''' ETDRK2 method
    stiff_A: Stiff part of the ODE function, diagonal vector of A
    nonstiff_func: Nonlinear function B
    t_span: The range of time for simulation
    y0: Initial value
    dt: Current timestep
    keep_zero: the flag whether we keep the 0th element in each step or not,
    If True, the 0th element will keep constant for all timesteps
    '''
    At = stiff_A * dt
    A0 = np.exp(At)

    # Compute A1, A2 by complex integral
    n = 64
    r = np.exp(2j*np.pi*(np.arange(1, n+1)-0.5)/n)
    Z = np.reshape(At, [-1, 1]) + np.reshape(r, [1, -1])
    A1 = dt * np.mean((np.exp(Z) - 1) / Z, 1)
    A2 = dt * np.mean((np.exp(Z) - 1 - Z) / np.power(Z, 2), 1)

    def A0_func(y):
        '''Linear function exp(A*dt)
        '''
        return A0 * y

    def A1_func(y):
        '''Linear function A^{-1} (exp(A*dt) - I)
        '''
        return A1 * y

    def A2_func(y):
        '''Linear function A^{-2} (exp(A*dt) - I - A*dt) / dt
        '''
        return A2 * y

    # Initialization
    t0, tM = tspan
    M = int(round((tM - t0) / dt))
    [n, ] = np.shape(y0)
    y = y0
    t = t0
    # Allcoate the space for recording result
    t_lst = np.array(range(M+1)) * dt + t0
    y_lst = np.zeros([M+1, n]) * 1j
    y_lst[0, ] = y0
    for k in range(1, M+1):
        t = t_lst[k]
        y_n = one_step_ETDRK2(A0_func, A1_func, A2_func, nonstiff_func, t, dt, y)
        # Reset the 0th element
        if keep_zero:
            y_n[0] = y[0]
        # Record the result and prepare for next step
        y_lst[k, ] = y_n
        y = y_n
    return [t_lst, y_lst]
