% constants
g = 9.81; % gracity, m s^-2
R = 287; % gas constant, J K^-1 kg^-1
cp = 3.5 * R; % specific heat capacity at constant pressure, J K^-1 kg^-1
p_ref = 1e5; % reference pressure for potential temperature, Pa
Omega = 7.292e-5; % rotation rate of Earth, s^-1
a = 6.38e6; % radius of Earth, m
Lc = 2.5e6; % specific latent heat of water condensation, J kg^-1
rho_water = 1e3; % density of liquid water, kg m^-3
% domain parameters
% For better performance, ny and nz should be 2^n+1.
ny = 129; % number of grid points in y
nz = 65; % number of grid points in z
dy = 1e5; % grid spacing in y, m
dz = 500; % grid spacing in z, m
y_center = 0; % position of the domain, m
z_start = 0; % position of the domain, m
% basic state parameters
tropopause = 1.6e4; % height at the tropopause, m
T_surf = 300; % temperature at the surface, K
Gamma_tropo = -6.5e-3; % dT/dz in the troposphere, K m^-1
Gamma_strato = 2.6e-3; % dT/dz in the stratosphere, K m^-1
p_surf = 101325; % pressure at the surface, Pa
% forcing parameters
% max_prec = 9 mm day^-1, mu = 6e5 m, and sigma = 2.5e5 m yield a Gaussian
% distribution that fit the distribution of the mean precipitation in May
% between 180W and 120W
max_prec = 9; % maximum precipitation rate, mm day^-1
MU = 6e5; %0:1e5:16e5; %6e5; % distance of the heating maximum from the equator, m
SIGMA = 2.5e5; %1e5:2.5e4:4e5; %2.5e5; % 1/4 width of the Gaussian heating distribution, m
% dissipation parameter
% alpha = 7.292e-7 follows Held and Hou (1980).
ALPHA = 7.292e-7; % s^-1
% first guess of psi, which specifies Dirichlet boundary conditions
psi_first = zeros(nz,ny);
% tolerance of residual in the solution of psi
tolerance = 32768;
max_iteration = 32768;
% If (tolerance*norm(residual)<norm(F)), break the iteration.
% If the solution do not converge after the max_iteration,
%   a warning message will emerge on the command window.