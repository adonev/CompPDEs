% Source term from inhomogeneous Dirichlet BC on inflow boundary
function diff_source_BC = DiffusionInhom(w,d_mid,h)
  
  global diffusion_ghost_cell;
  % 0=linear extrapolation to ghost cell (inconsistent at boundary),
  % u0 := 2*u_BC-u1;
  % 1=quadratic extrapolation (first order at boundary),
  % u0 := -2*u1 + u2/3 + (8*u_BC)/3
  % 2=cubic extrapolation (second order at boundary)
  % u0 := -3*u1 + u2 - u3/5 + (16*u_BC)/5
  
  switch diffusion_ghost_cell
  case 0 % Linear extrapolation
     diff_source_BC = 2*d_mid(1)/h^2*w;
  case 1 % Quadratic extrapolation
     diff_source_BC = (8/3)*d_mid(1)/h^2*w; 
  otherwise % Cubic extrapolation
     diff_source_BC = (16/5)*d_mid(1)/h^2*w;              
  end
  
end
