% Takes one step for advection-diffusion-source equation
% u_t + (a(x,t)*u)_x = (d(x)*u_x)_x + s(x,t)
function w_f = TimeStep(w_i, diff_op, a_xt, s_xt, dt, h, n, t, x, x_mid)
  
  source = s_xt(x,t+0.5*dt); % Cell-centered source term evaluated at midpoint in time
    
  diff_source = diff_op*w_i; % Treat (d*u_x)_x as a source when computing advective fluxes
  
  adv_source = Fromm(w_i, a_xt, dt, h, diff_source + source, n, t, x, x_mid);
  
  w_f = CrankNicolson(w_i, diff_op, adv_source + source, dt);

end
