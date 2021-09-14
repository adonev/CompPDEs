---
title: Lectures for Comp PDEs by Aleks Donev (Fall 2021)
layout: default
---

### 1. (Sept 8th) [Introduction and background](Lectures/IntroNumPDEs.pdf)

We will begin class with the foundation for computational fluid dynamics (CFD) by reviewing the basic formulation of [advection-diffusion equations](Lectures/AdvDiffEqs.pdf) ([annotated](Lectures/AdvDiffEqs_class.pdf)).

### 2. (Sept 8th, 15th, 22nd) [Basic Finite Volume Methods](Lectures/BasicFVM.pdf) ([annotated](Lectures/BasicFVM_class.pdf)).

We will discuss finite volume methods for advection-diffusion equations in one dimension, focusing on advection. This will warm us up for higher dimensions and also nonlinear conservation laws.

Please go through chapter 10 in the Finite Difference (FD) textbook of LeVeque (here are my own [lecture notes](https://cims.nyu.edu/~donev/Teaching/NMII/Lectures/FD_Parabolic.pdf) from another class for this chapter), as most of that applies also to finite volume methods. Chapter 9 is also required reading to get started with diffusion (here are some of my own [lecture notes](https://cims.nyu.edu/~donev/Teaching/NMII/Lectures/FD_Hyperbolic.pdf) on this). It is also crucial to read Appendices A and E in that book, especially sections A.6 and E.3. 

This [Maple worksheet](Lectures/ThirdOrderUpwind.pdf) ([as Maple file](Lectures/ThirdOrderUpwind.mw)) shows that the 3rd-order upwind biased spatial discretization of advection is 3rd order only as a FV scheme for non-constant advection, but not when viewed as an FD scheme. Here is a short addendum showing how to add a [source term to the Fromm scheme in 1D](Lectures/AdvectionWithSource.pdf).

Much of this material is in the books of LeVeque, but for a more self-contained reading see these [lecture notes from V. Springel and C.P. Dullemond](SlopeLimiters_Notes.pdf) (you can also access freely their [full set of lectures](http://www.ita.uni-heidelberg.de/%7Edullemond/lectures/num_fluid_2012/)), which also contain material for subsequent lectures. 

The stability analysis of second-order space-time schemes for advection-diffusion equations, as we discuss in one dimension, is in the very readable and instructive paper ["On the Stability of Godunov-Projection Methods for Incompressible Flow"](http://www.sciencedirect.com/science/article/pii/S0021999196900352) by Michael Minion. This paper is for two dimensions and Navier-Stokes and is therefore more advanced, but do come back to it if too advanced at this point (can be a topic of a final project!).

With all these pieces together, you should go back to the homework on [Basic methods for advection-diffusion equations](Assignments/BasicAdvDiff.pdf) and redo parts of it. Some sample codes will be posted here later on.
