% Solve the homework problem using a grid of n points
% starting from initial condition IC (function handle)
% Here we allow advection speed to vary in time, a_xt==a(x,t)
% But for diffusion we only allow variation in space, d_xt==d(x)
function [w,x,h] = AdvDiff(a_xt, d_x, s_xt, L, T, dt, n, IC, DBC)

   global periodic;

   h=L/n;
   
   x = h*([0:n-1]+0.5)';
   if(periodic) % First face is at x=h, no last face
      x_mid = x+h/2;
   else % First face is at x=h/2 and there is a last face
      x_mid = h*([0:n])';
   end   
   
   a_mid = a_xt(x_mid,0);
   nu = max(a_mid)*dt/h % Initial advective CFL
   
   d_mid = d_x(x_mid); % Diffusion coefficient evalued at faces
   mu = max(d_mid)*dt/h^2 % Diffusive CFL number

   A = DiffusionOp(d_mid, h, n);

   % Time stepping:
   %-----------------------
   w0=IC(x); % Initial condition
   w=w0;
   for step=1:round(T/dt)
      w = TimeStep(w, A, a_xt, d_x, s_xt, DBC, dt, h, n, (step-1)*dt, x, x_mid); 
         % Matlab allows you to have w be both input and output
         % But in other programming languages it may be different
   end

end
