function [F,Q,prec_mm_day] = forcing(y,z,in_y,in_z,rho,T,max_prec,mu,sigma,tropopause,rdy,dz,g,cp,Lc,rho_water,rH,gamma)
% Setup the prescribe forcing field.
% Setup the shape of the meridional heating profile.
Q_y = normpdf(y,mu,sigma);
% Setup the shape of the vertical heating profile.
Q_z = (sin(pi * z / tropopause)) .^ 2;
Q_z(z>tropopause) = 0;
Q_z = Q_z .* exp(gamma * 0.5 * z .* rH);
% Adjust so that the maximum precipitation rate is as prescribed.
Q_0 = Q_y.*Q_z;
max_prec_0 = max(trapz(rho .* Q_0(in_z,in_y))) * dz / Lc / rho_water * 1000 * 86400;
Q = Q_0 * max_prec / max_prec_0;
prec_mm_day = trapz(rho .* Q(in_z,in_y)) * dz / Lc / rho_water * 1000 * 86400;
% Include radiative cooling so that mean Q on every level is zero.
rad = mean(Q,2);
rad = repmat(rad,[1,length(Q_y)]);
Q = Q - rad;
% Calculate the forcing.
dQdy = (Q(in_z,in_y+1) - Q(in_z,in_y-1)) * 0.5 * rdy;
F = rho * g / cp ./ T .* dQdy;
end

