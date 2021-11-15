---
title: Resources for Comp PDEs by Aleks Donev (Fall 2021)
layout: default
---
## Learning Sources

I will teach the class from a number of sources including some books and some articles. Articles will be linked under Lectures where appropriate. Here I list some books of reference.

{% include Resources.html %}

### Final projects

For any final project topic, you need to discuss it with me **before Thanksgiving break** for approval. What I require to approve a project are:
* A specific problem/PDE you will solve (specifics are required, such as domain, boundary conditions, output desired, etc.) and an explanation why you are interested in this problem, along with any prior history with this topic (e.g., you did a project in NM-II on it, it is part of your research, etc.).
* Some primary source(s) you will use to learn about a computational method to solve your problem.
* Some computing component implementing a method we did not do in homeworks, preferably in higher dimensions. Going beyond just simple Matlab codes is encouraged, unless the project has more of a theoretical / numerical analysis focus. But do not be too ambitious either (this is part of our discussion). It is OK and even encouraged to use existing libraries/tools.

Examples of some libraries/tools that you may consider learning and using:
* [Dedalus](https://dedalus-project.org/) is a library of pseudo-spectral solvers
* [FEniCSx](https://fenicsproject.org/) is an easy-to-use yet powerful framework for finite-element based PDE solvers
* [OpenFOAM](https://www.openfoam.com/) is a commercial but free library/package for finite-volume based PDE solvers
* [chebfun](https://www.chebfun.org/) is a library of numerical analysis tools built around Chebyshev polynomials.
* [EPIC](https://faculty.ucmerced.edu/mtokman/#software) is a library of exponential time integrators.
* [fiNUFFT](https://finufft.readthedocs.io/en/latest/) is a library for non-uniform FFTs if you need that as part of your project.
* [FMM3D](https://fmm3d.readthedocs.io/en/latest/) is a 3D Fast Multipole Method library for Poisson and Helmholtz kernels, which can be useful if you want to do boundary integral methods.
