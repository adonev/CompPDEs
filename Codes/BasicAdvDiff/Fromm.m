% Estimate advective flux difference div(a(x,t)*u)^{n+1/2} at midpoint in time to second order
% Time step goes from t to t+dt
% This uses Fromm's method including a constant-in time source term
% We assume all velocities on all faces are non-negative
function w_t = Fromm(w, a_xt, DBC, dt, h, source, n, t, x, x_mid)
  
   global limited; % Use MC limiter
   global LW; % Use Lax-Wendroff instead of Fromm
   global periodic; % Periodic BCs or not
   global second_face_BC; % How to compute fluxes on second face
   global last_face_BC; % How to compute update of last cell
      
   a = a_xt(x_mid, t+dt/2); % Advection velocities on faces at midpoint in time
   cfl = a*dt/h; % Advective CFLs -- different for each face
   
if(periodic)
   % Here we assume periodic BCs and number the fluxes so that cell i is upwind from face i
      
   % For the purpose of extrapolating to faces at midpoint we use chain rule for (a*u)_x
   % and treat u*a_x as a source term
   s = w.*(circshift(a, 1) - a)/h + source;

   if(limited) % Try limiters

      %phi = @(theta) (1+theta)/2; % Fromm method rewritten with a "limiter"
      phi = @(theta) max(0, min(min((1+theta)/2,2),2*theta)); % The MC nonlinear limiter
      my_sign = @(x) sign(sign(x)+10*eps); % Returns either +1 or -1 but never zero
   
      % Limited slopes:
      %theta = (w-circshift(w, 1)) ./ (circshift(w, -1)-w) ; % Division by zero!
      % Make sure we never divide by zero:
      slopes = circshift(w, -1)-w;
      slopes = max(abs(slopes),10*eps) .* my_sign(slopes); % Get away from zero by 1e-15
      theta = (w-circshift(w, 1)) ./ slopes;
      
      fluxes = a.*(w + 0.5*(1-cfl).*phi(theta).*slopes + 0.5*dt*s);
          
   elseif(LW)
      
      slopes = circshift(w, -1)-w; % Downwinded slopes (Lax-Wendroff)
      % We also center the source terms in the spirit of LW:
      fluxes = a.*(w + 0.5*(1-cfl).*slopes + 0.25*dt*(s+circshift(s,-1)));            
   
   else
      
      slopes = (circshift(w, -1)-circshift(w, 1))/2; % Centered slopes (Fromm)
      fluxes = a.*(w + 0.5*(1-cfl).*slopes + 0.5*dt*s);
                                 
   end
   w_t = (circshift(fluxes, 1) - fluxes)/h ;

else

   % Here we number faces so that the first face is #1
   % This means cell i is now downwind from face i

   fluxes = zeros(n+1,1);

   % For the purpose of extrapolating to faces at midpoint we use chain rule for (a*u)_x
   % and treat u*a_x as a source term
   s = -w.*(a(2:n+1) - a(1:n))/h + source;

   % Interior (Fromm's method = linear reconstruction with centered slopes)  
   %----------------
   slopes = (w(3:n)-w(1:n-2))/2; % Centered slopes (Fromm)
   fluxes(3:n) = a(3:n).*(w(2:n-1)  + 0.5*(1-cfl(3:n)).*slopes + 0.5*dt*s(2:n-1));

   % Left boundary (inflow):
   %----------------      
   w0_beg=DBC(t); % Dirichlet BC at the beginning of the time step
   w0_mid=DBC(t+dt/2); % Dirichlet BC at left at midpoint

   % The inflow face is easy:
   fluxes(1) =   a(1)*w0_mid; % Make sure the BC is read at the *midpoint* in time

   % For the second face:
   switch second_face_BC % How to implement BC for second face to second order
   case 0 % Simple upwind flux
      slope = 0; % Don't include slope correction
   case 1 % Switch to LW for the second face   
      % This is second order but with boundary layer in error
      slope = (w(2)-w(1));
   case 2 % estimate the slope by a one-sided difference to the boundary (works great)
      % Think of this is as a linear reconstruction that enforces the BC at x=0
      % It is not obvious how to get this using a ghost cell construction + Fromm
      % Remember the BC here is evaluated is at *beginning* of time step
      slope = 2*(w(1)-w0_beg);
   otherwise % If we had used linear extrapolation for the ghost cell, we would get:
      slope = (0.5*(w(1)+w(2))-w0_beg);
   end   
   fluxes(2) =   a(2)*(w(1) + 0.50*(1-cfl(2))*slope     + 0.5*dt*s(1));

   % Right boundary (outflow):
   %----------------
   switch last_face_BC % How to implement BC for second face to second order
   case 0 % Simple upwind flux
      slope = 0;      
   otherwise % Use upwinded slopes ala Beam warming on the last face
      slope = (w(n)-w(n-1));   
   end
   fluxes(n+1) = a(n+1)*(w(n) + 0.50*(1-cfl(n+1))*slope + 0.5*dt*s(n));
   
   if(last_face_BC==2) % Switch to beam-warming update for last cell
      % Without this, we seem to get a boundary layer in the error at outflow
      
      slope = (w(n-1)-w(n-2));
      % Beam-Warming flux at penultimate face -- we don't change the actual flux though
      fluxes_n = a(n)*(w(n-1)      + 0.50*(1-cfl(n))*slope     + 0.5*dt*s(n-1));      %

      % You can think of this as setting fluxes(n+1) to whatever it needs to be
      % to make the last cell update be the same as if we used Beam Warming everywhere
      w_t_n = -(fluxes(n+1)-fluxes_n)/h; % Beam Warming update we want to get
      fluxes(n+1) = -w_t_n*h + fluxes(n);

   end

   % Flux difference
   %----------------
   w_t = -(fluxes(2:n+1)-fluxes(1:n))/h;
   
end

end
