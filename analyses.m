function [v,w,u,th_prime] = analyses(Omega,psi,in_y,in_z,rdy,rdz,rho,beta,y,alpha,N2,th,g)
% Compute v, w, u, and th from the psi solution
% Set Omega to zero for results without NCT
v = - (psi(in_z+1,in_y) - psi(in_z-1,in_y)) * 0.5 * rdz ./ rho(in_z,in_y);
w = (psi(in_z,in_y+1) - psi(in_z,in_y-1)) * 0.5 * rdy ./ rho(in_z,in_y);
u = (beta * y(in_z,in_y) .* v - 2 * Omega * w) / alpha;
th_prime = (- N2(in_z,in_y) .* th(in_z,in_y) / g .* w) / alpha;
end

