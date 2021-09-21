% Finite volume spatial discretization to solve:
% u_t+(a(x,t)*u)_x=(d(x)*u_x)x+s(x,t)
% with periodic BCs and initial condition
% u(x,0)=sin(pi*x)^exponent

clear
format long; format compact

% Options:
global limited; limited =0; % Use limiters?
manufactured=0; % Use method of manufactured solutions
global LW; LW=0; % Use Lax-Wendroff instead of Fromm to compare
stability=0; % If 1, test stability limit
discontinuous=0; % If 1, use a square wave IC
const_adv=0; % If 1
no_advection=0; % If 1, diffusion only test

% --------------------------------

L=1; % Domain length
T=1.0; % % Time to compare at:
nu=0.25; % Desired advective CFL number (if ~no_advection)

% Choose advection and diffusion coefficients and rhs of PDE
%----------------
if(no_advection)
   a_max=0.0; % Disable advection
else   
   a_max=1.0; % Max advection speed
end   
a=a_max;
if(~const_adv)
   a_xt = @(x,t) a*(3/4-1/4*sin(4*pi*x)); % Variable velocity
else   
   a_xt = @(x,t) a_max*ones(size(x)); % Constant velocity -- trivial translation
end

if(stability) % Test stability limit is only advection and not diffusion
   d=0.01
   nu=0.95
elseif(no_advection)
   d=0.001;
else % Choose value of diffusion
   d=0 % Advection only
   %d=0.0001
   %d=0.001
   %d=0.01
   %d=0.1      
end

d_x = @(x) d*(2+cos(2*pi*x));
if(no_advection) % Desired diffusive CFL number mu=dt*d/L^2
   mu=0.5*(d*T)/L^2; % Take only 1 step at coarser grid
end

% Source term:
if(manufactured) % For method of manufactured solution for exponent=2, from Maple:

   exponent=2;
   % Manufactured solution:
   SOL = @(x,t) sin(pi*(x-a*t)).^exponent;
   % Required source term:
   s_xt = @(x,t) pi .* a .* (-0.4e1 .* cos(0.4e1 .* pi .* x) + cos(0.2e1 .* pi .* (a .* t + x)) + 0.3e1 .* cos(0.2e1 .* pi .* (a .* t - 0.3e1 .* x)) + 0.2e1 .* sin(0.2e1 .* pi .* (a .* t - x))) / 0.8e1 + 0.4e1 .* d .* pi .^ 2 .* sin(0.2e1 .* pi .* x) .* sin(pi .* (-a .* t + x)) .* cos(pi .* (-a .* t + x)) - 0.2e1 .* d .* (0.2e1 + cos(0.2e1 .* pi .* x)) .* pi .^ 2 .* cos(pi .* (-a .* t + x)) .^ 2 + 0.2e1 .* d .* (0.2e1 + cos(0.2e1 .* pi .* x)) .* sin(pi .* (-a .* t + x)) .^ 2 .* pi .^ 2;
;
   
else % Solve original PDE

   exponent = 2; % Smooth solution
   %exponent = 100; % Not so smooth solution

   % Solution for constant advection speed and no diffusion:
   if(~discontinuous)
      SOL = @(x,t) sin(pi*(x-a*t)).^exponent;
   else   
      SOL = @(x,t) sign(x-a*t-0.4)-sign(x-a*t-0.6); % Test square wave for limiting
   end      
   
   s_xt = @(x,t) 0; % No source term
end

% Initial condition:
IC = @(x) SOL(x,0);
%----------------

if(stability)
   base=8;
   n_refinements = 1;
elseif(no_advection);
   base=6;
   n_refinements=1;   
else
   base=3;
   n_refinements = 5;   
end
colors=['k','r','g','b','m','c'];   

% --------------------------------

error_L1=zeros(n_refinements,1);
error_L2=zeros(n_refinements,1);
error_Linf=zeros(n_refinements,1);
h=zeros(n_refinements,1);

% Obtain finest level solution
n=2^(base+n_refinements+1)
if(no_advection)
   dt = mu*L^2/d;
else   
   dt = nu*(L/n)/a_max;
end   
n_steps=round(T/dt)
dt=T/n_steps

[u_finer, x_finer, h_finer] = AdvDiff(a_xt, d_x, s_xt, L, T, dt, n, IC);

figure(2); clf; 
figure(3); clf;
for i=n_refinements:-1:1

   n=2^(base+i)
   dt = 2*dt; % We have doubled the grid size so double time step
   n_steps=round(T/dt)
   dt = T/n_steps
   [u,x,h(i)] = AdvDiff(a_xt, d_x, s_xt, L, T, dt, n, IC);
   
   if(manufactured) % We know the exact solution here
      u_exact = SOL(x,T); % Because only up to second order 
         % we can just pretend this is finite difference and evaluate at center
   else % Compare to finer grid as no exact solution known
      u_exact = Coarsen(u_finer, 2);
   end
   figure(3);
   if(i==n_refinements) plot(x, u_exact,[colors(i),'-']); hold on; end
   plot(x, u, [colors(i),'o--']); hold on; 
   
   figure(2);
   plot(x, (u-u_exact)/norm(u-u_exact,'inf'), [colors(i),'o-']);
   hold on;

   error_L1(i)=h(i)*norm(u-u_exact,1);
   error_L2(i)=sqrt(h(i))*norm(u-u_exact,2);
   error_Linf(i)=norm(u-u_exact,'inf');
   
   u_finer=u;
   x_finer=x;
end

error_L1
error_L2
error_Linf

figure(1); clf;
loglog(h, error_L1/error_L1(1), 'ro'); hold on;
loglog(h, error_L2/error_L2(1), 'ks'); hold on;
loglog(h, error_Linf/error_Linf(1), 'gd'); hold on;
loglog(h, (h/h(1)).^2, 'r-');
loglog(h, (h/h(1)).^1, 'g-');
legend('L1','L2','Linf','2nd','1st','Location','southeast');
xlabel('Resolution (h)'); ylabel('Error');
title('Error NORM convergence under space-time refinement');

figure(2);
xlabel('x'); ylabel('Rescaled error E(x)');
title('Error FUNCTION convergence under space-time refinement');

figure(3);
xlabel('x'); ylabel('Solution u(x)');
title('Solution convergence under space-time refinement');

