% Form the diffusive operator as a *sparse* matrix
function A = DiffusionOp(d_mid, h, n)

   global periodic;
   global diffusion_ghost_cell;

   if(periodic) 
      d_mid_m = circshift(d_mid, 1);
      A = spdiags([d_mid /h^2 , -(d_mid + d_mid_m)/h^2, ...
          circshift(d_mid,1)/h^2],[-1 0 1],n,n);
      % Correct corners for periodic boundary conditions:
      A(1, n) = d_mid_m(1)/h^2;
      A(n,1) = d_mid(n)/h^2;
   else % Neumann BCs on right, Dirichlet on left
      A = spdiags([d_mid(2:n+1) /h^2 , -(d_mid(1:n) + d_mid(2:n+1))/h^2, ...
          d_mid(1:n)/h^2],[-1 0 1],n,n);
      % Correct first and last row for Dirichlet/Neumann BC
      if(diffusion_ghost_cell==0) % Linear extrapolation
         A(1,1) = -(2*d_mid(1)+d_mid(2))/h^2; A(1,2) = d_mid(2)/h^2;
         A(n,n-1) = d_mid(n)/h^2; A(n,n) = -d_mid(n)/h^2; 
      else % Quadratic extrapolation
         A(1,1) = -(3*d_mid(1)+d_mid(2))/h^2; A(1,2) = (d_mid(1)/3+d_mid(2))/h^2;
         A(n,n-1) = d_mid(n)/h^2; A(n,n) = -d_mid(n)/h^2;       
      end   
   end

end
