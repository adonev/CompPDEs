% Advance the solution by using Crank-Nicolson with a source term
% The diffusion operator is passed in here as a sparse matrix diff_op
% This allows us to only construct it once and reuse it each time step, and also use it compute the source term
function w_f = CrankNicolson(w_i, diff_op, source, dt)

    spi=speye(size(diff_op));

    % Use the theta method to integrate. This allows us to switch between BE and CN easily 
    theta=0.5;
    
    LHS = (spi - theta*dt*diff_op);
    RHS = (spi + (1-theta)*dt*diff_op);

    w_f = LHS\(RHS*w_i +dt*source);

end
