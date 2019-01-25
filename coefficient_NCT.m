function [A_NCT,B_NCT,C_NCT,D_NCT,E_NCT] = coefficient_NCT(N2,Omega,alpha,beta,y,rH)
% Setup the circulation equation with NCT.
% N2 is the squared Brunt-Vaisala frequency (s^-2).
% Omega is the rotation rate of Earth (s^-1).
% alpha is the dissipation rate (s^-1).
% beta is df/dy (m^-1 s^-1), where f is the Coriolis parameter.
% y is the distance from the equator (m).
A_NCT = N2 + 4 * Omega ^ 2 + alpha ^ 2;
B_NCT = 2 * Omega * beta * y;
C_NCT = beta ^ 2 * y .^ 2 + alpha ^ 2;
D_NCT = 2 * Omega * beta * y .* rH;
E_NCT = 2 * Omega * beta + (beta ^ 2 * y .^ 2 + alpha ^ 2) .* rH;
end

