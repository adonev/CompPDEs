# -*- coding: utf-8 -*-
"""
General SBDF2 method for ODE (stiff part is a diagonal matrix)
"""


import numpy as np


def one_step_SBDF2(inv_stiff_func, nonstiff_func, t, dt, y_c, y_o):
    ''' One step of SBDF2 method
    inv_stiff_func: Linear function (I - 2*dt*A/3)^{-1}
    nonstiff_func: Nonlinear function B
    t: Current time
    dt: Current timestep
    y_c: Current y (y_n)
    y_o: Value of y one step before (y_{n-1})
    '''
    y_n = inv_stiff_func(4*y_c/3 - y_o/3 +
                         2*dt*(2*nonstiff_func(y_c) - nonstiff_func(y_o))/3)
    return y_n


def SBDF2(stiff_A, nonstiff_func, tspan, y0, dt, keep_zero=True):
    ''' SBDF2 method
    stiff_A: Stiff part of the ODE function, diagonal vector of A
    nonstiff_func: Nonlinear function B
    t_span: The range of time for simulation
    y0: Initial value
    dt: Timestep
    keep_zero: the flag whether we keep the 0th element in each step or not,
    If True, the 0th element will keep constant for all timesteps
    '''
    def stiff_func(y):
        '''
        Stiff part of the ODE function
        '''
        return stiff_A * y

    inv_stiff_A = 1 / (1 - 2*dt*stiff_A/3)

    def inv_stiff_func(y):
        '''
        Linear function (I - 2*dt*A/3)^{-1}
        '''
        return inv_stiff_A * y

    # Initialization
    t0, tM = tspan
    M = int(round((tM - t0) / dt))
    [n, ] = np.shape(y0)
    y_o = y0
    t = t0
    # Allcoate the space for recording result
    t_lst = np.array(range(M+1)) * dt + t0
    y_lst = np.zeros([M+1, n]) * 1j
    y_lst[0, ] = y0

    # Compute y1 with RK2 method
    y1_star = y0 + dt * (stiff_func(y0) + nonstiff_func(y0))
    y_c = y1_star
    if keep_zero:
        y_c[0] = y0[0]
    y_lst[1, ] = y_c
    for k in range(2, M+1):
        t = t_lst[k]
        y_n = one_step_SBDF2(inv_stiff_func, nonstiff_func, t, dt, y_c, y_o)
        # Reset the 0th element
        if keep_zero:
            y_n[0] = y_c[0]
        # Record the result and prepare for next step
        y_lst[k, ] = y_n
        y_o = y_c
        y_c = y_n
    return [t_lst, y_lst]
