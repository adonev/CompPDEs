---
title: Assignments for Scientific Computing at NYU
layout: default
---

Please read the [instructions for submitting homeworks](Homeworks.html) and follow them when preparing and submitting the homework assignments.

### 1. (Due Sept 20th) [Numerical Computing](Assignments/Homework-IEEE.pdf)

Take a look at the [sample solution](Assignments/SolutionSample.pdf) to the example homework problem on finite difference first derivative in [double precision](Matlab/FirstDeriv.m) and [single precision](Matlab/FirstDerivSP.m), and follow this as an example of what a stellar solution would look like.

### 2. (Due Oct 4th) [Linear Systems](Assignments/Homework-LinearSystems.pdf)

Problem 1 and 3 can be solved based on material covered in the third lecture (LU factorization), and problem 2 after the fourth lecture (overdetermined linear systems).

Here is [code](Matlab/matinv.m) to compute the matrix inverse (taken from  [matrixlab](http://www.matrixlab-examples.com/matrix-inversion.html)). Try this code instead of the built-in function inv and compare.

### 3. (Due Oct 18th) [Eigen and Singular Values](Assignments/Homework-Eigenvalues.pdf)

Problem 1 is a continuation of problem 1 from the second homework. Problem 2 is hopefully fun and playfull and there are no precise answers. It is meant to get you to play with some "real world" data and see how PCA can reveal things in data but not always in an obvious way.

### 4. (Due Nov 1st) [Nonlinear Equations and Optimization](Assignments/Homework-Optimization.pdf)

If you wish to go further, learn about the standard strategy to adjust the regularization parameter in the [Levenberg-Marquardt algorithm](https://en.wikipedia.org/wiki/Levenberg%E2%80%93Marquardt_algorithm) and implement this and see if it converges more robustly.

### 5. (Due Nov 22nd) [Function approximation](Assignments/Homework-Approx.pdf)

Based on lecture notes on interpolation and Fourier transforms, but also relates to previous homeworks on fitting. If you want to learn more about Chebyshev interpolation, see section 8.5 of the textbook, and feel free to use the [chebfun package](https://www.chebfun.org) for the homework if you wish.

### 6. (Due Dec 6th) [Monte Carlo](Assignments/Homework-MC.pdf)

Final assignment in this course, and final topic that may be included in the take-home final.
