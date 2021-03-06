% Finite volume spatial discretization to solve:
% u_t+(a(x,t)*u)_x=(d(x)*u_x)x+s(x,t)
% with either periodic BCs or
% with Dirichlet BCs on left and Neumann on right:
% u(0,t)=sin(-pi*t)^exponent;
% u_x(1,t)=0 if d>0
% and initial condition
% u(x,0)=sin(pi*x)^exponent
% If there were only advection the solution would be u(x,t)=sin(pi*(x-t))^exponent

clear
format long; format compact

% Options:
global periodic; periodic=1;
global limited; limited = 0; % Use limiters? (periodic only)
global LW; LW=0; % Use Lax-Wendroff instead of Fromm (periodic only, no limiter)
stability=0; % If 1, test stability limit
discontinuous=0; % If 0, use a smooth initial condition
                 % If 1, use a square wave IC
                 % If 2, use a wave packet
no_advection=0; % If 1, diffusion only test, If 2, use very large time steps
adv_form=0; % If 0, set a=const. 
            % If 1, use ~a*(3/4-1/4*sin(4*pi*x)), else
            % If 2, use a~cos(t)*(3/4-1/4*sin(2*pi*x))
manufactured=0; % Use method of manufactured solutions

% If not periodic, various options for implementing the Dirichlet BC on inflow boundary:
global second_face_BC; second_face_BC = 2; 
   % 0=simple upwind, 1=downwind slope ala LW, ...
   % 2=slope using first cell and BC, 3=slope using first two cells and BC
global last_face_BC; last_face_BC = 2; % 0=simple upwind,...
   % 1=upwinded slopes ala Beam-Warming for last face,...
   % 2=Beam-Warming update for last cell
global diffusion_ghost_cell; diffusion_ghost_cell=0; % Dirichlet BC for diffusion operator
   % 0=linear extrapolation to ghost cell (inconsistent at boundary),
   % 1=quadratic extrapolation (first order at boundary),
   % 2=cubic extrapolation (second order at boundary)

% --------------------------------

L=1; % Domain length
% Time to compare at:
if(periodic)
   T=1.0
elseif(adv_form==0)
   T=1.0
else   
   T=1.0
end
nu=0.25; % Desired advective CFL number (if ~no_advection)

% Choose advection and diffusion coefficients and rhs of PDE
%----------------
if(no_advection)
   a_max=0.0; % Disable advection
else   
   a_max=1.0; % Max advection speed
end
%a_max=0.1; nu=0.01; % Very large diffusive Courant number is a problem
a=a_max;

switch adv_form
case 0
   a_xt = @(x,t) a_max*ones(size(x)); % Constant velocity -- trivial translation
case 1
   a_xt = @(x,t) a*(3/4-1/4*sin(4*pi*x)); % Variable velocity in space only
otherwise
   a_xt = @(x,t) a*cos(t)*(3/4-1/4*sin(2*pi*x)); % Variable velocity in space and time
end

if(stability) % Test stability limit is only advection and not diffusion
   d=0.01
   nu=0.95
elseif(no_advection)
   d=0.01;
else % Choose value of diffusion
   %d=0 % Advection only
   %d=0.0001
   %d=0.001
   d=0.01
   %d=0.1
   %d=1
   %d=10
end

N_boundary_layer = L*a/d

if(adv_form==0) % Constant coefficient simple test
   d_x = @(x) d*ones(size(x));
else % Variable coefficient (HW1 and HW2)
   d_x = @(x) d*(2+cos(2*pi*x));
end
   
% Desired diffusive CFL number mu=dt*d/L^2
if(no_advection==2) % Large time step test for Crank-Nicolson
   mu=0.5*(d*T)/L^2; % Take only 1 step at coarser grid
elseif(no_advection==1) % Moderate time step size
   mu=0.5*(d*T)/L^2/128; % Take 8 steps at finest grid
end

% Source term:
if(manufactured) % For method of manufactured solution for exponent=2, from Maple:

   exponent=2;
   % Manufactured solution and required source term
   switch adv_form
   case 0 % Simpler case: Const a and d and satisfies BCs   
      SOL = @(x,t) sin(pi*x).^exponent;
   
      s_xt = @(x,t) 0.2e1 .* a .* sin(pi .* x) .* pi .* cos(pi .* x) - 0.2e1 .* d .* pi .^ 2 .* cos(pi .* x) .^ 2 + 0.2e1 .* d .* sin(pi .* x) .^ 2 .* pi .^ 2;
   
   case 1 % HW1: For a*(3/4-1/4*sin(4*pi*x)) and does not satisfy Neumann BC
      SOL = @(x,t) sin(pi*(x-a*t)).^exponent;   
   
      s_xt = @(x,t) pi .* a .* (-0.4e1 .* cos(0.4e1 .* pi .* x) + cos(0.2e1 .* pi .* (a .* t + x)) + 0.3e1 .* cos(0.2e1 .* pi .* (a .* t - 0.3e1 .* x)) + 0.2e1 .* sin(0.2e1 .* pi .* (a .* t - x))) / 0.8e1 + 0.4e1 .* d .* pi .^ 2 .* sin(0.2e1 .* pi .* x) .* sin(pi .* (-a .* t + x)) .* cos(pi .* (-a .* t + x)) - 0.2e1 .* d .* (0.2e1 + cos(0.2e1 .* pi .* x)) .* pi .^ 2 .* cos(pi .* (-a .* t + x)) .^ 2 + 0.2e1 .* d .* (0.2e1 + cos(0.2e1 .* pi .* x)) .* sin(pi .* (-a .* t + x)) .^ 2 .* pi .^ 2;

   otherwise % HW2: For a*cos(t)*(3/4-1/4*sin(2*pi*x)) and satisfies Neumann BCs
      SOL = @(x,t) sin(pi*x).^exponent;   

      s_xt = @(x,t) -cos(t) .* sin(pi .* x) .* (0.4e1 .* sin(pi .* x) .* cos(pi .* x) .^ 2 - sin(pi .* x) - 0.3e1 .* cos(pi .* x)) .* a .* pi / 0.2e1 + 0.4e1 .* d .* pi .^ 2 .* sin(0.2e1 .* pi .* x) .* sin(pi .* x) .* cos(pi .* x) - 0.2e1 .* d .* (0.2e1 + cos(0.2e1 .* pi .* x)) .* pi .^ 2 .* cos(pi .* x) .^ 2 + 0.2e1 .* d .* (0.2e1 + cos(0.2e1 .* pi .* x)) .* sin(pi .* x) .^ 2 .* pi .^ 2;      

   end
   
else % Solve original PDE

   %exponent = 2; % Smooth solution
   %exponent = 100; % Not so smooth solution
   exponent = 20; % A bit smoother but not very smooth

   % Solution for constant advection speed and no diffusion:
   switch discontinuous
   case 0
      SOL = @(x,t) sin(pi*(x-a*t)).^exponent;
   case 1  % Test square wave for limiting
      SOL = @(x,t) -sign(x-mod(a*t-0.4,L))+sign(x-mod(a*t-0.6,L)); 
   case 2  % Test wave packet for limiting   
      SOL = @(x,t) sin(pi*(x-a*t)).^10 .* sin(20*pi*(x-a*t));
   end      
   
   s_xt = @(x,t) 0; % No source term
end
DBC = @(t) SOL(0,t); % Dirichlet BC on the inflow (left) boundary

% Initial condition:
IC = @(x) SOL(x,0);
%----------------

if(stability)
   base=8;
   n_refinements = 1;
elseif(no_advection==2);
   base=6;
   n_refinements=1;
elseif(~periodic) % Boundary errors require some care to see
   if(manufactured) % Resolve and under-resolve boundary layer
      base=3;
      n_refinements = 6; 
   else % Focus on more refined grids
      base=4;
      n_refinements = 5;    
   end  
else
   base=3;
   n_refinements = 6;
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

[u_finer, x_finer, h_finer] = AdvDiff(a_xt, d_x, s_xt, L, T, dt, n, IC, DBC);

figure(2); clf; 
figure(3); clf;
for i=n_refinements:-1:1

   n=2^(base+i)
   dt = 2*dt; % We have doubled the grid size so double time step
   n_steps=round(T/dt)
   dt = T/n_steps
   [u,x,h(i)] = AdvDiff(a_xt, d_x, s_xt, L, T, dt, n, IC, DBC);
   
   if(manufactured) % We know the exact solution here
      u_exact = SOL(x,T); % Because only up to second order 
         % we can just pretend this is finite difference and evaluate at center
   elseif((adv_form==0) & (d==0))
      u_exact = SOL(x,T); % Solution just translates due to advection   
   else % Compare to finer grid as no exact solution known
      u_exact = Coarsen(u_finer, 2);
   end
   figure(3);
   if(i==n_refinements) plot(x, u_exact,[colors(i),'s-']); hold on; end
   plot(x, u, [colors(i),'o--']); hold on; 
   
   figure(2);
   plot(x, (u-u_exact)/h(i)^2, [colors(i),'o-']);
   hold on;

   error_L1(i)=DiscreteNorm(u-u_exact,h(i),1);
   error_L2(i)=DiscreteNorm(u-u_exact,h(i),2);
   error_Linf(i)=DiscreteNorm(u-u_exact,h(i),inf);;
   
   u_finer=u;
   x_finer=x;
end

error_L1
error_L2
error_Linf

figure(1); clf;
loglog(h, error_L1/error_L1(end), 'ro'); hold on;
loglog(h, error_L2/error_L2(end), 'ks'); hold on;
loglog(h, error_Linf/error_Linf(end), 'gd'); hold on;
loglog(h, (h/h(end)).^2, 'r-');
loglog(h, (h/h(end)).^1, 'g-');
legend('L1','L2','Linf','2nd','1st','Location','southeast');
xlabel('Resolution (h)'); ylabel('Error');
title('Error NORM convergence under space-time refinement');

figure(2);
xlabel('x'); ylabel('Rescaled error E(x)');
title('Error FUNCTION convergence under space-time refinement');

figure(3);
xlabel('x'); ylabel('Solution u(x)');
title('Solution convergence under space-time refinement');

