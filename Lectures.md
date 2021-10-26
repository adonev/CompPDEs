---
title: Lectures for Comp PDEs by Aleks Donev (Fall 2021)
layout: default
---

### 1. (Sept 8th) [Introduction and background](Lectures/IntroNumPDEs.pdf)

We will begin class with the foundation for computational fluid dynamics (CFD) by reviewing the basic formulation of [advection-diffusion equations](Lectures/AdvDiffEqs.pdf) ([annotated](Lectures/AdvDiffEqs_class.pdf)).

### 2. (Sept 8th, 15th, 22nd, 29th) [Basic Finite Volume Methods](Lectures/BasicFVM.pdf) ([annotated](Lectures/BasicFVM_class.pdf))

We will discuss finite volume methods for advection-diffusion equations in one dimension, focusing on advection. This will warm us up for higher dimensions and also nonlinear conservation laws.

Please go through chapter 10 in the Finite Difference (FD) textbook of LeVeque (here are my own [lecture notes](https://cims.nyu.edu/~donev/Teaching/NMII/Lectures/FD_Parabolic.pdf) from another class for this chapter), as most of that applies also to finite volume methods. Chapter 9 is also required reading to get started with diffusion (here are some of my own [lecture notes](https://cims.nyu.edu/~donev/Teaching/NMII/Lectures/FD_Hyperbolic.pdf) on this). It is also crucial to read Appendices A and E in that book, especially sections A.6 and E.3. 

This [Maple worksheet](Lectures/ThirdOrderUpwind.pdf) ([as Maple file](Lectures/ThirdOrderUpwind.mw)) shows that the 3rd-order upwind biased spatial discretization of advection is 3rd order only as a FV scheme for non-constant advection, but not when viewed as an FD scheme.

Much of this material is in the books of LeVeque, but for a more self-contained reading see these [lecture notes from V. Springel and C.P. Dullemond](Lectures/SlopeLimiters_Notes.pdf) (you can also access freely their [full set of lectures](http://www.ita.uni-heidelberg.de/%7Edullemond/lectures/num_fluid_2012/)), which also contain material for subsequent lectures. 

The stability analysis of second-order space-time schemes for advection-diffusion equations, as we discuss in one dimension, is in the very readable and instructive paper ["On the Stability of Godunov-Projection Methods for Incompressible Flow"](http://www.sciencedirect.com/science/article/pii/S0021999196900352) by Michael Minion. This paper is for two dimensions and Navier-Stokes and is therefore more advanced, but do come back to it if too advanced at this point (can be a topic of a final project!).

With all these pieces together, you should go back to [part 1.1 in the homework on advection-diffusion equations](Assignments/AdvDiff.pdf). If you wish to use a MOL method (say with third-order upwind biased flux for advection), you may find the following [IMEX temporal integrators](Lectures/IMEX.pdf) useful. The IMEX RK schemes in these notes are based on the article by [Pareschi and Russo on "Implicit-explicit Runge-Kutta schemes and applications to hyperbolic systems with relaxation"](https://link.springer.com/article/10.1007/s10915-004-4636-4), which derives a (recommended!) scheme that combines (SSP-)RK3 for advection with an L-stable (DIRK-)RK2 scheme for diffusion. Some sample codes will be posted here later on.

### 3. (Oct 6th and 13th) [Boundary Conditions for Advection-Diffusion](Lectures/AdvDiffBCs.pdf) ([annotated](Lectures/AdvDiffBCs_class.pdf))

We will discuss how to implement Dirichlet or Neumann boundary conditions for advection-diffusion in one dimension. This is a rather complicated topic so my lectures will be more pragmatic and in your [second homework](Assignments/AdvDiff.pdf) you will try out some options and see how they work for yourself.

It will be useful to review section 2.12 in the FD textbook of LeVeque (here are my own [lecture notes](https://cims.nyu.edu/~donev/Teaching/NMII/Lectures/FD_Elliptic_1D.pdf) from another class for this chapter), as most of that applies also to diffusion in finite volume methods.

### 4. (Oct 20th) [Limiters](Lectures/Limiters.pdf) ([annotated](Lectures/Limiters_class.pdf))

We will briefly discuss the use of slope and flux limiters in "high-resolution advection" schemes as a way to preserve monotonicity / avoid oscillations in the solution, based on Sections 6.9-6.12 in the FVM book of LeVeque. Another good self-contained reading are the [lecture notes from V. Springel and C.P. Dullemond](Lectures/SlopeLimiters_Notes.pdf).

For a discussion of limiters that are able to preserve local extrema without clipping them, and can thus remain higher-order even near extrema, see this [final project report on the PPM limiter by Wenjun Zhao (Brown)](Lectures/QuadraticLimiters_WenjunZhao.pdf). This is also a great example of a good final project for this class.

### 5. (Oct 20th and Oct 27th) [Nonlinear conservation laws](Lectures/ConservationLawsGodunov.pdf) ([annotated](Lectures/ConservationLawsGodunov_class.pdf))

We will (too) briefly discuss how to generalize the first- and second-order methods we developed for advection to more general nonlinear hyperbolic equations. This discussion has to be brief because a complete development requires a considerable amount of PDE theory (e.g., weak entropy solutions), because even for simple equations like the shallow water equations there is very little proven in terms of guarantees on convergence, and because there are too many great but specialized methods developed for specific important equations that appear in practice (e.g., Euler, shallow water). A rather complete (but often hard to digest because of the completeness) source is the FVM book of LeVeque.

The 2nd order scheme I present here is sometimes called the [MUSCL-Hancock scheme](https://en.wikipedia.org/wiki/MUSCL_scheme) and is taken from section 6.6 in the [lecture notes from V. Springel and C.P. Dullemond](https://www.ita.uni-heidelberg.de/~dullemond/lectures/num_fluid_2012/Chapter_6.pdf). Approximate Riemann solvers that are are actually used to implement this type of method in practice are briefly covered in chapter 7 in the [lecture notes from V. Springel and C.P. Dullemond](https://www.ita.uni-heidelberg.de/~dullemond/lectures/num_fluid_2012/Chapter_7.pdf).

For an example of a robust 2nd order high resolution TVD scheme for scalar one dimensional conservation laws, look at the paper ["A geometric approach to high resolution TVD schemes" by Jonathan Goodman and Randy LeVeque](https://doi.org/10.1137/0725019). This paper can form the basis of a final project combining some theory and computation.

### 6. (Oct 27th) (Pseudo)Spectral Methods for Periodic Evolution Equations

Before coming to class, please review material from Numerical Methods II on Fourier Transforms including FFTs (here are some [notes from Leslie Greengard](Lectures/NMII_Leslie_FFT.pdf), and here is my own [lecture on the FFT](https://cims.nyu.edu/~donev/Teaching/NMII/Lectures/Lecture-FFT.handout.pdf)). You will also need background material from Numerical Methods I on orhogonal polynomials (Chebyshev or Legendre), including both interpolation and quadrature.

You should also review ahead of class sections 1 and 2 in [my notes on spectral methods for PDEs](https://cims.nyu.edu/~donev/Teaching/NMII/Lectures/Lecture-Spectral.handout.pdf); we will go through sections 3 and 4 in class; section 4 explains how to use FFTs to compute Chebyshev series.

We will also go over [exponential time integrators](https://cims.nyu.edu/~donev/Teaching/NMII/Lectures/ExponentialIntegration.pdf) as a way to solve evolution equations, notably parabolic or mixed parabolic-hyperbolic equations like the incompressible Navier-Stokes equation (next lecture). Exponential integrators are covered briefly in section 11.6 of LeVeque. The original source of ETDRK schemes is the paper ["Exponential time differencing for stiff systems" by Cox and Matthews](https://www.math.fsu.edu/%7Eokhanmoh/media/Cox,%20Matthews,%20JCP,%202002,%20Exponential%20Time%20Differencing%20for%20Stiff%20Systems.pdf). Another more recent article from the group of Nick Trefethen discusses a [4th order exponential integrator method (ETDRK4)](https://people.maths.ox.ac.uk/trefethen/fourth-order.pdf) for time stepping a system of ODEs in time. Here is a [pseudospectral code to solve the KdV equation](https://cims.nyu.edu/%7Edonev/Teaching/PDE/Matlab/KdV.m) (i.e., to solve [u_t+u*u_x+u_xxx=0](https://en.wikipedia.org/wiki/Korteweg%E2%80%93de_Vries_equation)) using ETDRK4, written by A. K. Kassam and L. N. Trefethen with some small changes by me. This code does something smart to avoid roundoff problems (catastrophic cancellation). 

Spectral accuracy in time can be achieved by using the [Spectral Deferred Correction (SDC) Method](BROKEN). We will only cover this briefly to give the main idea, and those interested in the topic can use it for a final project. A review article that gives the complicated history of this class of methods is ["Deferred Correction Methods for Ordinary Differential Equations" by Ong & Spiteri](https://link.springer.com/article/10.1007/s10915-020-01235-8). Michael Minion and collaborators have used SDC for PDEs in a series of works, for example, see equation (17) and discussion in this [paper by Layton and Minion](https://msp.org/camcos/2007/2-1/p01.xhtml). Many pieces are required to make SDC efficient and effective for PDEs, for example, handling of stiff terms robustly needs the LU trick developed in the paper ["Faster SDC convergence on non-equidistant grids by DIRK sweeps" by M. Weiser](https://link.springer.com/article/10.1007/s10543-014-0540-y).

### 7. (Independent Reading) Semi-Lagrangian advection methods

We will not have time to cover in this class the important class of semi-Lagrangian methods for advection, but this can be a topic of a final project. A first reading is section 10.6 in the FD book of LeVeque. The main advantage of (semi-)Lagrangian methods over the Eulerian methods we have been focusing on is that they can help increase the stable time step. For further reading, consult one of these sources (all available electronically freely at NYU):

1. The article ["The semi-Lagrangian technique in atmospheric modelling" by Michail Diamantakis](https://www.ecmwf.int/sites/default/files/elibrary/2014/9054-semi-lagrangian-technique-atmospheric-modelling-current-status-and-future-challenges.pdf)
2. Chapter 6 in the book [Numerical Methods for Wave Equations in Geophysical Fluid Dynamics by Dale R. Durran](https://link.springer.com/book/10.1007/978-1-4757-3081-4)
3. The complete book [Semi-Lagrangian Advection Methods and Their Applications in Geoscience by Steven J. Fletcher](https://www.sciencedirect.com/book/9780128172223/semi-lagrangian-advection-methods-and-their-applications-in-geoscience)

