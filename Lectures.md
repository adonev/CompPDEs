---
title: Lectures for Scientific Computing at NYU
layout: default
---

### 1 and 2. (Sept 3rd and 10th) [Numerical Computing](Lectures/Lecture-IEEE.pdf) ([annotated](Lectures/Lecture-IEEE.annotated.pdf))

In the main textbook, this is covered in chapters 5 and 6. I suggest
instead reading part I (chapters 1-4) in the [textbook by O'Leary](https://epubs.siam.org/doi/book/10.1137/9780898717723). 

For more information consult chapter 1 in the book by Driscoll or chapter I in [notes by Jonathan Goodman](http://www.cs.nyu.edu/courses/spring09/G22.2112-001/book/SourcesOfError.chapter.pdf)

Here are some MATLAB scripts used as examples in the lecture notes: [Fibbonaci](Matlab/fibb.m), [integral](Matlab/Integral.m),  [vectorization](Matlab/vect.m), harmonic sum [double precision](Matlab/harmonic.m) and [single precision](Matlab/harmonicSP.m). 
Also an example solution to the example homework problem on finite difference first derivative  in [double precision](Matlab/FirstDeriv.m) and [single precision](Matlab/FirstDerivSP.m).

Here is a printout of the the Maple script studying [propagated error in HW1 problem 2](Assignments/Stability-pi.pdf).

### 3 and 4. (Sept 17th and 24th) [Solving Linear Systems](Lectures/Lecture-LinearSystems.pdf) ([annotated](Lectures/Lecture-LinearSystems.annotated.pdf))

Please go through Section 1 (Review of Linear Algebra) **on your own** ahead of class.

For dense square and overdetermined
systems see chapter 7 in the main textbook, while for sparse matrices see 12.2
in the textbook. For a more in-depth overview of sparse solvers see
chapters 27 (direct) or 28 (iterative) in the [textbook by O'Leary](https://epubs.siam.org/doi/book/10.1137/9780898717723).

For a more mathematical review of linear algebra consult 
[part 1 of notes by Jonathan Goodman](http://www.cs.nyu.edu/courses/spring09/G22.2112-001/book/LinearAlgebra1.chapter.pdf), 
and for a more in-depth discussion on performance consult [part 2 of notes by Jonathan Goodman](http://www.cs.nyu.edu/courses/spring09/G22.2112-001/book/LinearAlgebra2.chapter.pdf)

Here is the MATLAB code [MyLU.m](Matlab/MyLU.m).

### 5. (Oct 1st) [Eigen and singular values](Lectures/Lecture-Eigenvalues.pdf) ([annotated](Lectures/Lecture-Eigenvalues.annotated.pdf))

Look at 12.1 in the textbook for eigenvalues; Google's original Page
Rank algorithm is covered in 12.1.5 and you may find it interesting.
Also see section 5.5 for eigenvalues and 5.6 for SVD in the [textbook by O'Leary](https://epubs.siam.org/doi/book/10.1137/9780898717723).
Here are is the MATLAB code for [Compression.m](Matlab/Compression.m)

### 6. (Oct 8th) [Solving Nonlinear Equations](Lectures/Lecture-NonLinear.pdf) ([annotated](Lectures/Lecture-NonLinear.annotated.pdf))

The main textbook treats only equations in a single variable as a warmup in Chapter 4. Systems of nonlinear equations are not covered in the textbook but this is very important; see instead chapter 24 in the [textbook by O'Leary](https://epubs.siam.org/doi/book/10.1137/9780898717723), and in particular the discussion of continuation methods.

Here is the MATLAB script [FZero.m](Matlab/FZero.m).

### 7. (Oct 15th) [Optimization](Lectures/Lecture-Optimization.pdf) ([annotated](Lectures/Lecture-Optimization.annotated.pdf))

Based on various sources, including these [notes by Jonathan Goodman](http://www.cs.nyu.edu/courses/spring09/G22.2112-001/book/NonlinearEquations.chapter.pdf). Optimization is discussed in good detail in chapters 9 (unconstrained) and 10 (constrained, advanced) in the [textbook by O'Leary](https://epubs.siam.org/doi/book/10.1137/9780898717723).

Here is the MATLAB script [Rosenbrock.m](Matlab/Rosenbrock.m).

### 8. (Oct 22nd) [Interpolation (Function Approximation)](Lectures/Lecture-Interp.pdf) ([annotated](Lectures/Lecture-Interp.annotated.pdf))

See chapter 8 of textbook and also these [notes by Jonathan Goodman](http://www.cs.nyu.edu/courses/spring09/G22.2112-001/book/ApproximatingFunctions.chapter.pdf).

Here are some MATLAB scripts used as examples in the lecture notes: [Runge1D.m](Matlab/Runge1D.m), [Hills2D.m](Matlab/Hills2D.m), [HillsIrreg2D.m](Matlab/HillsIrreg2D.m).

### 9. (Oct 29th) [Fast Fourier Transform](Lectures/Lecture-FFT.pdf) ([annotated](Lectures/Lecture-FFT.annotated.pdf))

We will discuss Fourier Transforms, including the FFT algorithm, and briefly introduce wavelets. This is not covered in the textbooks, and is more advanced material not included in the final exam, and is optional in the homework. Nevertheless I believe it to be one of the most improtant tools in Numerical Analysis.

### 10. (Nov 5th) [Integration (Quadrature)](Lectures/Lecture-Integration.pdf) ([annotated](Lectures/Lecture-Integration.annotated.pdf))

Look at Chapter 10 in the textbook (we will not cover Gaussian quadrature in detail, but see section 10.3 in textbook). 

You can generate the Gauss-Lobato quadrature points and weights using the MATLAB code [GLNodeWt.m](Matlab/GLNodeWt.m).

### 11. (Nov 12th) [Monte Carlo Methods](Lectures/Lecture-MC.pdf) ([annotated](Lectures/Lecture-MC.annotated.pdf))

See chapter 16 in the [textbook by O'Leary](https://epubs.siam.org/doi/book/10.1137/9780898717723). My lecture notes are mostly based on these [lecture notes by Jonathan Goodman](http://www.cs.nyu.edu/courses/spring09/G22.2112-001/book/MonteCarlo.chapter.pdf). Further technical details on variance reduction are in these (advanced) [notes by Goodman](http://www.math.nyu.edu/faculty/goodman/teaching/MonteCarlo07/notes/VarianceReduction.pdf). 

### 12. (Nov 19 and Dec 3rd) [Ordinary Differential Equations (ODEs)](Lectures/Lecture-ODE.pdf) ([annotated](Lectures/Lecture-ODE.annotated.pdf))

See chapter 11 in the textbook or look at these lecture [notes by Jonathan Goodman](http://www.cs.nyu.edu/courses/spring09/G22.2112-001/book/DifferentialEquations.chapter.pdf). See also chapter 20 in the [textbook by O'Leary](https://epubs.siam.org/doi/book/10.1137/9780898717723). A concise summary and two proofs of convergence of Euler's method not given in my lecture slides is in these [notes by David Bindel](http://www.cs.nyu.edu/courses/spring09/G22.2112-001/book/notes-de.pdf).

No class Nov 26th (Thanksgiving)

### 13 (Dec 3rd and 10th) [Partial Differential Equations (PDEs)](Lectures/Lecture-PDE.pdf) ([annotated](Lectures/Lecture-PDE.annotated.pdf))

Based on various sources, just a brief sketch. See chapter 14 in the textbook, along with chapter 13 for boundary value problems in one dimension.

### 14 (Dec 17th) Final Project Presentations
