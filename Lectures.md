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

### 5. (Oct 20th ?) [Nonlinear conservation laws](Lectures/ConservationLawsGodunov.pdf) ([annotated](Lectures/ConservationLawsGodunov_class.pdf))

We will (too) briefly discuss how to generalize the first- and second-order methods we developed for advection to more general nonlinear hyperbolic equations. This discussion has to be brief because a complete development requires a considerable amount of PDE theory (e.g., weak entropy solutions), because even for simple equations like the shallow water equations there is very little proven in terms of guarantees on convergence, and because there are too many great but specialized methods developed for specific important equations that appear in practice (e.g., Euler, shallow water). A rather complete (but often hard to digest because of the completeness) source is the FVM book of LeVeque.

The 2nd order scheme I present here is sometimes called the [MUSCL-Hancock scheme](https://en.wikipedia.org/wiki/MUSCL_scheme) and is taken from section 6.6 in the [lecture notes from V. Springel and C.P. Dullemond](https://www.ita.uni-heidelberg.de/~dullemond/lectures/num_fluid_2012/Chapter_6.pdf). Approximate Riemann solvers that are are actually used to implement this type of method in practice are briefly covered in chapter 7 in the [lecture notes from V. Springel and C.P. Dullemond](https://www.ita.uni-heidelberg.de/~dullemond/lectures/num_fluid_2012/Chapter_7.pdf).

