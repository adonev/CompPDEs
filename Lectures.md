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

The stability analysis of second-order space-time schemes for advection-diffusion equations, as we discuss in one dimension, is in the very readable and instructive paper ["On the Stability of Godunov-Projection Methods for Incompressible Flow"](https://doi.org/10.1006/jcph.1996.0035) by Michael Minion. This paper is for two dimensions and Navier-Stokes and is therefore more advanced, but do come back to it if too advanced at this point (can be a topic of a final project!).

With all these pieces together, you should go back to [part 1.1 in the homework on advection-diffusion equations](Assignments/AdvDiff.pdf). If you wish to use a MOL method (say with third-order upwind biased flux for advection), you may find the following [IMEX temporal integrators](Lectures/IMEX.pdf) useful. The IMEX RK schemes in these notes are based on the article by [Pareschi and Russo on "Implicit-explicit Runge-Kutta schemes and applications to hyperbolic systems with relaxation"](https://link.springer.com/article/10.1007/s10915-004-4636-4), which derives a (recommended!) scheme that combines (SSP-)RK3 for advection with an L-stable (DIRK-)RK2 scheme for diffusion. Some sample codes will be posted here later on.

### 3. (Oct 6th and 13th) [Boundary Conditions for Advection-Diffusion](Lectures/AdvDiffBCs.pdf) ([annotated](Lectures/AdvDiffBCs_class.pdf))

We will discuss how to implement Dirichlet or Neumann boundary conditions for advection-diffusion in one dimension. This is a rather complicated topic so my lectures will be more pragmatic and in your [second homework](Assignments/AdvDiff.pdf) you will try out some options and see how they work for yourself.

It will be useful to review section 2.12 in the FD textbook of LeVeque (here are my own [lecture notes](https://cims.nyu.edu/~donev/Teaching/NMII/Lectures/FD_Elliptic_1D.pdf) from another class for this chapter), as most of that applies also to diffusion in finite volume methods.

### 4. (Oct 20th) [Limiters](Lectures/Limiters.pdf) ([annotated](Lectures/Limiters_class.pdf))

We will briefly discuss the use of slope and flux limiters in "high-resolution advection" schemes as a way to preserve monotonicity / avoid oscillations in the solution, based on Sections 6.9-6.12 in the FVM book of LeVeque. Another good self-contained reading are the [lecture notes from V. Springel and C.P. Dullemond](Lectures/SlopeLimiters_Notes.pdf).

For a discussion of limiters that are able to preserve local extrema without clipping them, and can thus remain higher-order even near extrema, see this [final project report on the PPM limiter by Wenjun Zhao (Brown)](Lectures/QuadraticLimiters_WenjunZhao.pdf). This is also a great example of a good final project for this class.

Another option for a final project is to try high-resolution advection methods in two dimensions. One source on higher dimensions including so-called "corner transport" is Chapters 19 and 20 in the FVM book of LeVeque. My favorite (in part because of its quality but also because it is derived geometrically rather than algebraically) high-resolution advection method is the [BDS2D algorithm](http://msp.berkeley.edu/camcos/2011/6-1/p02.xhtml) by May, Nonaka, Almgren, and Bell for 2D; see also this paper for a [BDS3D algorithm](http://epubs.siam.org/doi/abs/10.1137/100809520) in 3D.

### 5. (Oct 20th and Oct 27th) [Nonlinear conservation laws](Lectures/ConservationLawsGodunov.pdf) ([annotated](Lectures/ConservationLawsGodunov_class.pdf))

We will (too) briefly discuss how to generalize the first- and second-order methods we developed for advection to more general nonlinear hyperbolic equations. This discussion has to be brief because a complete development requires a considerable amount of PDE theory (e.g., weak entropy solutions), because even for simple equations like the shallow water equations there is very little proven in terms of guarantees on convergence, and because there are too many great but specialized methods developed for specific important equations that appear in practice (e.g., Euler, shallow water). A rather complete (but often hard to digest because of the completeness) source is the FVM book of LeVeque.

The 2nd order scheme I present here is sometimes called the [MUSCL-Hancock scheme](https://en.wikipedia.org/wiki/MUSCL_scheme) and is taken from section 6.6 in the [lecture notes from V. Springel and C.P. Dullemond](https://www.ita.uni-heidelberg.de/~dullemond/lectures/num_fluid_2012/Chapter_6.pdf). Approximate Riemann solvers that are are actually used to implement this type of method in practice are briefly covered in chapter 7 in the [lecture notes from V. Springel and C.P. Dullemond](https://www.ita.uni-heidelberg.de/~dullemond/lectures/num_fluid_2012/Chapter_7.pdf).

For an example of a robust 2nd order high resolution TVD scheme for scalar one dimensional conservation laws, look at the paper ["A geometric approach to high resolution TVD schemes" by Jonathan Goodman and Randy LeVeque](https://doi.org/10.1137/0725019). This paper can form the basis of a final project combining some theory and computation. Another possible final project is to consider solving the shallow water equations in 1D and 2D using a Godunov method.

### 6. (Oct 27th and Nov 3rd) (Pseudo)Spectral Methods for Periodic Evolution Equations

Before coming to class, please review material from Numerical Methods II on Fourier Transforms including FFTs (here are some [notes from Leslie Greengard](Lectures/NMII_Leslie_FFT.pdf), and here is [my own lecture on Fourier series and the FFT](Lectures/Lecture-FFT.handout.pdf)). You will also need background material from Numerical Methods I on orthogonal polynomials (Chebyshev or Legendre), including both interpolation and quadrature.

You should also review ahead of class sections 1 and 2 in [my notes on spectral methods for PDEs](Lectures/Lecture-Spectral.handout.pdf); we will go through sections 3 and 4 in class; section 4 explains how to use FFTs to compute Chebyshev series. See also these [short notes on handling the unmatched mode](Lectures/SolutionPseudoKdV.pdf) for even-sized grids. There are some subtle issues with spectral differentiation, as discused in detail in these [technical notes by Steven G. Johnson](Lectures/SpectralDerivatives_FFT.pdf), as well as with aliasing, as discussed in these [selected pages on aliasing](Lectures/Aliasing.pdf) from the detailed [notes on pseudospectral methods by Denys Dutykh](https://arxiv.org/abs/1606.05432v1). For the approximation theory behind using Fourier series as an approximation to periodic functions, see sections 2,3 and 4 in the paper ["Extension of Chebfun to periodic functions" by Nick Trefethen](https://epubs.siam.org/doi/pdf/10.1137/141001007). 

We will also go over [exponential time integrators](Lectures/ExponentialIntegration.pdf) as a way to solve evolution equations, notably parabolic or mixed parabolic-hyperbolic equations like the incompressible Navier-Stokes equation (next lecture). Exponential integrators are covered briefly in section 11.6 of LeVeque. The original source of ETDRK schemes is the paper ["Exponential time differencing for stiff systems" by Cox and Matthews](https://www.math.fsu.edu/%7Eokhanmoh/media/Cox,%20Matthews,%20JCP,%202002,%20Exponential%20Time%20Differencing%20for%20Stiff%20Systems.pdf). Another more recent article from the group of Nick Trefethen discusses a [4th order exponential integrator method (ETDRK4)](https://people.maths.ox.ac.uk/trefethen/fourth-order.pdf) for time stepping a system of ODEs in time. Here is a [pseudospectral code to solve the KdV equation](https://cims.nyu.edu/%7Edonev/Teaching/PDE/Matlab/KdV.m) (i.e., to solve [u_t+u*u_x+u_xxx=0](https://en.wikipedia.org/wiki/Korteweg%E2%80%93de_Vries_equation)) using ETDRK4, written by A. K. Kassam and L. N. Trefethen with some small changes by me. This code does something smart to avoid roundoff problems (catastrophic cancellation). Here are some [notes on how to carefully handle the unmatched mode](Lectures/SolutionPseudoKdV.pdf) for even number of points and evaluate the rhs of the KdV equation to spectral accuracy (for smooth solutions).

For applications of exponential integrators to more challenging PDEs more broadly (not just periodic and pseudospectral), see the article ["Implementation of parallel adaptive-Krylov exponential solvers for large scale stiff problems" by J. Loffeld and M. Tokman](http://dx.doi.org/10.1137/13094462X).

Spectral accuracy in time can be achieved by using the [Spectral Deferred Correction (SDC) Method](Lectures/SDC.pdf). We will only cover this briefly to give the main idea, and those interested in the topic can use it for a final project. A review article that gives the complicated history of this class of methods is ["Deferred Correction Methods for Ordinary Differential Equations" by Ong & Spiteri](https://link.springer.com/article/10.1007/s10915-020-01235-8). Michael Minion and collaborators have used SDC for PDEs in a series of works. For example, for SDC with a pseudo-spectral discretization of (17) and discussion see this [paper by Layton and Minion](https://msp.org/camcos/2007/2-1/p01.xhtml), or for advection-diffusion see Section 5.4 in this [early paper by Minion](https://projecteuclid.org/journals/communications-in-mathematical-sciences/volume-1/issue-3/Semi-implicit-spectral-deferred-correction-methods-for-ordinary-differential-equations/cms/1250880097.pdf). Many pieces are required to make SDC efficient and effective for PDEs, for example, handling of stiff terms robustly benefits from the LU trick developed in the paper ["Faster SDC convergence on non-equidistant grids by DIRK sweeps" by M. Weiser](https://link.springer.com/article/10.1007/s10543-014-0540-y).

A possible topic for a final project are pseudospectral methods for (nonlinear) wave equations, see for example the article ["A pseudospectral procedure for the solution of nonlinear wave equations with examples from free-surface flows"](https://epubs.siam.org/doi/abs/10.1137/S1064827597321532) by Milewski and Tabak.

### 7. (Independent Reading) Semi-Lagrangian advection methods

We will not have time to cover in this class the important class of semi-Lagrangian methods for advection, but this can be a topic of a final project. A first reading is section 10.6 in the FD book of LeVeque. The main advantage of (semi-)Lagrangian methods over the Eulerian methods we have been focusing on is that they can help increase the stable time step. For further reading, consult one of these sources (all available electronically freely at NYU):

1. The article ["The semi-Lagrangian technique in atmospheric modelling" by Michail Diamantakis](https://www.ecmwf.int/sites/default/files/elibrary/2014/9054-semi-lagrangian-technique-atmospheric-modelling-current-status-and-future-challenges.pdf)
2. Chapter 6 in the book [Numerical Methods for Wave Equations in Geophysical Fluid Dynamics by Dale R. Durran](https://link.springer.com/book/10.1007/978-1-4757-3081-4)
3. The complete book [Semi-Lagrangian Advection Methods and Their Applications in Geoscience by Steven J. Fletcher](https://www.sciencedirect.com/book/9780128172223/semi-lagrangian-advection-methods-and-their-applications-in-geoscience)

### 8. (Nov 3rd) [Pseudospectral methods for incompressible flow in 2D](Lectures/VorticityStream.pdf)

After formulating the vorticity-stream formulation of the incompressible NS equations, we will go through a simple pseudo-spectral method for two-dimensional periodic flow. Note that there is an [associated homework](Assignments/PseudospectralNS.pdf).

Idea for final project: Implement a pseudospectral solver for the NS equations in 3D for periodic domains, and explore anti-aliasing strategies; see for example this [article on computing nearly-singular solutions](https://doi.org/10.1016/j.jcp.2007.04.014). In three dimensions, a manufactured analytical solution can be found in the paper ["Tri-periodic fully three-dimensional analytic solutions for the Navier-Stokes equations" by M. Antuono](https://doi.org/10.1017%2Fjfm.2020.126).

### 9. (Nov 10th and 17th) Spectral methods for elliptic PDEs in bounded domains.

We will briefly discuss (pseudo-spectral) methods for solving elliptic and by extension parabolic PDEs in non-periodic domains in one dimension. The basic idea is to use orthogonal polynomials (Chebyshev or Legendre) but delicate details imposing the PDE (weakly using Galerkin or strongly using collocation) and imposing boundary conditions. I will discuss both weak imposition in Galerkin methods and strong imposition using a spectral equivalent of the "ghost cell" technique described pedagogically in the paper ["Block Operators and Spectral Discretizations" by Aurentz and Trefethen](https://people.maths.ox.ac.uk/trefethen/blocks_final.pdf) based on the method proposed in the paper ["Rectangular spectral collocation" by Driscoll and N. Hale](https://doi.org/10.1093/imanum/dru062).

For software/methods for solving evolution PDEs in bounded (but logically rectangular) 2D and 3D domains using orthogonal polynomial basis see the [Dedalus](https://dedalus-project.org/) package.

Note that FFT-based methods can be used to solve elliptic PDEs in irregular domains by using extention into a rectangular periodic domain. This can also be a topic of a final project. I suggest looking at the paper [The smooth forcing extension method by Qadeer and Griffith](https://doi.org/10.1016/j.jcp.2021.110390) for a simple yet accurate approach.

### 10. Other topics for final project

Other topics suitable for final projects, some of which we will cover in the class but not all, are:
* Finite difference/volume/element methods for incompressible Navier-Stokes (coupled to a scalar equation for an advected quantity, for example). See, for example, the paper ["An accurate and efficient method for the incompressible Navier-Stokes equations using the projection method as a preconditioner"](https://doi.org/10.1016/j.jcp.2009.07.001) by Boyce Griffith.
* Finite element methods for elasticity in two dimensions
* Immersed-boundary methods for fluid-structure interaction
* Boundary integral methods for Laplace/Stokes equations
* Hyperbolic systems of equations such as shallow-water equations in 2D.
But you are welcome to come up with one of your own. 

For any final project topic, you need to discuss it with me **before Thanksgiving break** for approval. What I require to approve a project are:
* A specific problem/PDE you will solve (specifics are required, such as domain, boundary conditions, output desired, etc.) and an explanation why you are interested in this problem, along with any prior history with this topic (e.g., you did a project in NM-II on it, it is part of your research, etc.).
* Some primary source(s) you will use to learn about a computational method to solve your problem.
* Some computing component implementing a method we did not do in homeworks, preferably in higher dimensions. Going beyond just simple Matlab codes is encouraged, unless the project has more of a theoretical / numerical analysis focus. But do not be too ambitious either (this is part of our discussion). It is OK and even encouraged to use existing libraries/tools.

Examples of some libraries/tools that you may consider learning and using:
* [Dedalus](https://dedalus-project.org/) is a library of pseudo-spectral solvers
* [FEniCSx](https://fenicsproject.org/) is an easy-to-use yet powerful framework for finite-element based PDE solvers
* [OpenFOAM](https://www.openfoam.com/) is a commercial but free library/package for finite-volume based PDE solvers
* [EPIC](https://faculty.ucmerced.edu/mtokman/#software) is a library of exponential time integrators.
* [fiNUFFT](https://finufft.readthedocs.io/en/latest/) is a library for non-uniform FFTs if you need that as part of your project.
* [FMM3D](https://fmm3d.readthedocs.io/en/latest/) is a 3D Fast Multipole Method library for Poisson and Helmholtz kernels, which can be useful if you want to do boundary integral methods.
