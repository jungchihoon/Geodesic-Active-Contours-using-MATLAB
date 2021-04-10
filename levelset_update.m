function phi_out = levelset_update(phi_in, g, c, timestep)
phi_out = phi_in;

%
% ToDo
%--------------------------------------------------------------------------
[phi_x,phi_y] = gradient(phi_in);
norm_gra = sqrt(phi_x.^2+phi_y.^2+1e-10); % the norm of the gradient plus a small possitive number 
X = phi_x./norm_gra;                                       
Y = phi_y./norm_gra;
[xx,None] = gradient(X);                              
[None,yy] = gradient(Y); 

dPhi = sqrt(phi_x.^2+phi_y.^2); % mag(grad(phi))
                     
kappa = xx + yy; % curvature
%--------------------------------------------------------------------------

smoothness = g.*kappa.*dPhi;
expand = c*g.*dPhi;

phi_out = phi_out + timestep*(expand + smoothness);