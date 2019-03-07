function [T,p,rho,Exner,th,rH,N2,beta] = basic_state(z,tropopause,T_surf,...
          Gamma_tropo,Gamma_strato,p_surf,p_ref,R,cp,g,rdz,Omega,a)
% Setup the basic state
kappa = R / cp;
% basic state temperature
T = T_base(z,tropopause,T_surf,Gamma_tropo,Gamma_strato);
% basic state pressure
p = p_base(z,T,p_surf,g,R);
% basic state density, Exner function, potential temperature
rho = p / R ./ T;
Exner = (p / p_ref) .^ kappa;
th = T ./ Exner;
% basic state inverse density scale height (extrapolation on the boundaries)
rho_up = [rho(2:end,:) ; 2 * rho(end,:) - rho(end-1,:)];
rho_lo = [2 * rho(1,:) - rho(2,:) ; rho(1:end-1,:)];
rH = - (rho_up - rho_lo) * 0.5 * rdz ./ rho;
% basic state squared Brunt-Vaisala frequency (extrapolation on the boundaries)
th_up = [th(2:end,:) ; 2 * th(end,:) - th(end-1,:)];
th_lo = [2 * th(1,:) - th(2,:) ; th(1:end-1,:)];
N2 = (th_up - th_lo) * 0.5 * rdz * g ./ th;
% beta
beta = 2 * Omega / a;
end

function T = T_base(z,tropopause,T_surf,Gamma_tropo,Gamma_strato)
% Setup the basic state temperature.
% z is the matrix of height (m).
% tropopause is the height at the tropopause (m).
% T_surf is the temperature at the surface (K).
% Gamma_tropo and Gamma_strato are the dT/dz in the
% troposphere and the stratosphere
T = T_surf + Gamma_tropo * z;
T_tropopause = T_surf + Gamma_tropo * tropopause;
T(z>tropopause) = T_tropopause + Gamma_strato * (z(z>tropopause) - tropopause);
end

function p = p_base(z,T,p_surf,g,R)
% Setup the basic state pressure
% z is the matrix of height (m).
% T is the temperature field (K).
% p_surf is the pressure at the surface (Pa).
% g is the gravity (m s^-2).
% R is the gas constant (J K^-1 kg^-1).
T_mean = T;
for k = 1 : length(z(:,1))
    T_mean(k,:) = mean(T(1:k,:));
end
p = p_surf * exp(- g / R * z ./ T_mean);
end