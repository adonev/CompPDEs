% Estimate advective flux difference div(a(x,t)*u)^{n+1/2} at midpoint in time to second order
% Time step goes from t to t+dt
% This uses Fromm's method including a constant-in time source term
% Here we assume periodic BCs and number the fluxes so that cell i is upwind from face i
% We assume all velocities on all faces are non-negative so upwinding is a simple circshift
function w_t = Fromm(w, a_xt, dt, h, source, n, t, x, x_mid)
  
   global limited;
      
   a = a_xt(x_mid, t+dt/2); % Advection velocities on faces
   cfl = a*dt/h; % Advective CFLs -- different for each face
   
   % For the purpose of extrapolating to faces at midpoint we use chain rule for (a*u)_x
   % and treat u*a_x as a source term
   s = w.*(circshift(a, 1) - a)/h + source;
      
   if(limited) % Try limiters

      %phi = @(theta) (1+theta)/2; % Fromm method rewritten with a "limiter"
      phi = @(theta) max(0, min(min((1+theta)/2,2),2*theta)); % A nonlinear limiter
      my_sign = @(x) sign(sign(x)+10*eps); % Returns either +1 or -1 but never zero
   
      % Limited slopes:
      %theta = (w-circshift(w, 1)) ./ (circshift(w, -1)-w) ; % Division by zero!
      % Make sure we never divide by zero:
      slopes = circshift(w, -1)-w;
      slopes = max(abs(slopes),10*eps) .* my_sign(slopes); % Get away from zero by 1e-15
      theta = (w-circshift(w, 1)) ./ slopes;
      
      fluxes = a.*(w + 0.5*(1-cfl).*phi(theta).*slopes + 0.5*dt*s);
          
   else 
      
      slopes = (circshift(w, -1)-circshift(w, 1))/2; % Centered slopes (Fromm)
      fluxes = a.*(w + 0.5*(1-cfl).*slopes + 0.5*dt*s);
                                 
   end
   w_t = (circshift(fluxes, 1) - fluxes)/h ;

end
