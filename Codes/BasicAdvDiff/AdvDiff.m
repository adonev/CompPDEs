% Solve the homework problem using a grid of n points
% starting from initial condition IC (function handle)
% Here we allow advection speed to vary in time, a_xt==a(x,t)
% But for diffusion we only allow variation in space, d_xt==d(x)
function [w,x,h] = AdvDiff(a_xt, d_x, s_xt, L, T, dt, n, IC)
   h=L/n;
    
   x = h*[1/2:(n-1/2)]';
   x_mid = x+h/2;
   
   a_mid = a_xt(x_mid,0);
   nu = max(a_mid)*dt/h % Initial advective CFL
   
   d_mid = d_x(x_mid); % Diffusion coefficient evalued at faces
   mu=max(d_mid)*dt/h^2 % Diffusive CFL number

   % Form the diffusive operator as a *sparse* matrix
   %-----------------------
   d_mid_m = circshift(d_mid, 1);
   A = spdiags([d_mid /h^2 , -(d_mid + d_mid_m)/h^2, circshift(d_mid,1)/h^2],[-1 0 1],n,n);
   % Correct corners for periodic boundary conditions:
   A(1, n) = d_mid_m(1)/h^2;
   A(n,1) = d_mid(n)/h^2;

   % Time stepping:
   %-----------------------
   w0=IC(x); % Initial condition
   w=w0;
   for step=1:round(T/dt)
      w = TimeStep(w, A, a_xt, s_xt, dt, h, n, (step-1)*dt, x, x_mid); 
         % Matlab allows you to have w be both input and output
         % But in other programming languages it may be different
   end

end
