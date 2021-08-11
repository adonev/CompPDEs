---
title: Lectures for Comp PDEs by Aleks Donev (Fall 2021)
layout: default
---

### 1. (Sept 8th) [Introduction and background](Lectures/IntroNumPDEs.pdf)

We will begin class with the foundation for computational fluid dynamics (CFD) by reviewing the basic formulation of [advection-diffusion equations](Lectures/AdvDiffEqs.pdf).

### 2. (Sept 8th, 15th, 22nd) [Basic Finite Volume Methods](Lectures/BasicFVM.pdf)

We will discuss finite volume methods for advection-diffusion equations in one dimension, focusing on advection. This will warm us up for higher dimensions and also nonlinear conservation laws.

Please go through chapter 10 in the Finite Difference (FD) textbook of LeVeque, as most of that applies also to finite volume methods. This [Maple worksheet](Lectures/ThirdOrderUpwind.pdf) ([as Maple file](Lectures/ThirdOrderUpwind.mw)) shows that the 3rd-order upwind biased spatial discretization of advection is 3rd order only as a FV scheme for non-constant advection, but not when viewed as an FD scheme.

Much of this material is in the books of LeVeque, but for a more self-contained reading see these [lecture notes from V. Springel and C.P. Dullemond](SlopeLimiters_Notes.pdf) (you can also access freely their [full set of lectures](http://www.ita.uni-heidelberg.de/%7Edullemond/lectures/num_fluid_2012/)), which also contain material for subsequent lectures. 

The stability analysis of second-order space-time schemes for advection-diffusion equations, as we discuss in one dimension, is in the very readable and instructive paper ["On the Stability of Godunov-Projection Methods for Incompressible Flow"](http://www.sciencedirect.com/science/article/pii/S0021999196900352) by Michael Minion. This paper is for two dimensions and Navier-Stokes and is therefore more advanced, but do come back to it if too advanced at this point (can be a topic of a final project!).

With all these pieces together, you should go back to the homework on [Basic methods for advection-diffusion equations](Assignments/BasicAdvDiff.pdf) and redo parts of it. Some sample codes will be posted here later on.
