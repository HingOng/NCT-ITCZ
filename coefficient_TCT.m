function [A_TCT,B_TCT,C_TCT,D_TCT,E_TCT] = coefficient_TCT(N2,alpha,beta,y,rH)
% Setup the circulation equation without NCT.
% N2 is the squared Brunt-Vaisala frequency (s^-2).
% alpha is the dissipation rate (s^-1).
% beta is df/dy (m^-1 s^-1), where f is the Coriolis parameter.
% y is the distance from the equator (m).
A_TCT = N2 + alpha ^ 2;
B_TCT = zeros(size(y));
C_TCT = beta ^ 2 * y .^ 2 + alpha ^ 2;
D_TCT = zeros(size(y));
E_TCT = (beta ^ 2 * y .^ 2 + alpha ^ 2) .* rH;
end

