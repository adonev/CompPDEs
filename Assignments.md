---
title: Assignments for Comp PDEs by Aleks Donev (Fall 2021)
layout: default
---

Please submit solutions via NYU's class management system Brightspace as a self-contained PDF report that is organized with a discussion, figures, and results/answers, along with source codes (plain text please) as attachments. Please do not include codes in the PDF, attach them separately as a zip file or plain text .m or .py files.

### 1. (Due Sept 19th) [Basic methods for advection-diffusion equations](Assignments/BasicAdvDiff.pdf)

The purpose of this assignment is to help me evaluate the background of the students in the class and see what I can assume is familiar and thus tailor the contents better. Please invest some effort into this assignment even if it seems boring (that is a good sign; I will try to challenge most of you), and try to finish it and submit it as soon as you can. You will all come back to (pieces of) this homework later and improve upon your solution until it is "good enough," so the effort spent on it will pay out in the longer term.

Please go through chapter 10 in the Finite Difference (FD) textbook of LeVeque (here are my own [lecture notes](https://cims.nyu.edu/~donev/Teaching/NMII/Lectures/FD_Parabolic.pdf) from another class for this chapter), as most of that applies also to finite volume methods. Chapter 9 is also required reading to get started with diffusion (here are some of my own [lecture notes](https://cims.nyu.edu/~donev/Teaching/NMII/Lectures/FD_Hyperbolic.pdf) on this). It is also crucial to read Appendices A and E in that book, especially sections A.6 and E.3, **before** you work on the homework.

### 2. (Due Oct 17th) [Second order finite volume methods for advection-diffusion equations](Assignments/AdvDiff.pdf)

This homework is a repeat of the first homework, but now with more specific goals. Make sure to follow the suggestions discussed and demo'ed in class. Make sure you use the correct definition of function norm (as opposed to vector norms), as explained in Appendix A.5 in the FD book of LeVeque.

### 3. (Due Nov 21st) [Pseudo-spectral solver for the two-dimensional Navier-Stokes equations](Assignments/PseudospectralNS.pdf)

This is the final homework for this class, and features the [Taylor vortex](https://en.wikipedia.org/wiki/Taylor%E2%80%93Green_vortex). You are encouraged to submit part 1 first for initial comments and then continue to work on part 2. You are also strongly encouraged to pay attention to code design because a well-written code will make it very easy to, for example, add part 2 once part 1 is finished.

### 4. (Due Dec 19th) Final project.

Please discuss with me and approve a final project topic before Thanksgiving. See the lectures tab for ideas.

For any final project topic, you need to discuss it with me **before Thanksgiving break** for approval. What I require to approve a project are:
* A specific problem/PDE you will solve (specifics are required, such as domain, boundary conditions, output desired, etc.) and an explanation why you are interested in this problem, along with any prior history with this topic (e.g., you did a project in NM-II on it, it is part of your research, etc.).
* Some primary source(s) you will use to learn about a computational method to solve your problem.
* Some computing component implementing a method we did not do in homeworks, preferably in higher dimensions. Going beyond just simple Matlab codes is encouraged, unless the project has more of a theoretical / numerical analysis focus. But do not be too ambitious either (this is part of our discussion). It is OK and even encouraged to use existing libraries/tools.
