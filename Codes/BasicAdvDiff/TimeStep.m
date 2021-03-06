% Takes one step for advection-diffusion-source equation
% u_t + (a(x,t)*u)_x = (d(x)*u_x)_x + s(x,t)
function w_f = TimeStep(w_i, diff_op, a_xt, d_x, s_xt, DBC, dt, h, n, t, x, x_mid)

  global periodic;
  
  d_mid = d_x(x_mid); % Diffusion coefficient evalued at faces
  
  source = s_xt(x,t+0.5*dt); % Cell-centered source term evaluated at midpoint in time
    
  diff_source = diff_op*w_i; % Treat (d*u_x)_x as a source when computing advective fluxes  
  
  if(not(periodic)) % Add inhomogeneous BC term for left Dirichlet boundary
      w0_beg=DBC(t); % Dirichlet BC at the beginning of the time step
      diff_source(1) = diff_source(1) + DiffusionInhom(w0_beg,d_mid,h);
  end
  
  adv_source = Fromm(w_i, a_xt, DBC, dt, h, diff_source + source, n, t, x, x_mid);
  if(not(periodic)) % Add inhomogeneous BC term for left dirichlet boundary
      w0_mid=DBC(t+dt/2); % Dirichlet BC at left at midpoint
      adv_source(1) = adv_source(1) + DiffusionInhom(w0_mid,d_mid,h); 
  end
  
  w_f = CrankNicolson(w_i, diff_op, adv_source + source, dt);

end
