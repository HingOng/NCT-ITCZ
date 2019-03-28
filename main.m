clear variables
close all
clc
format compact

% The NCT-ITCZ (NCT, nontraditional Coriolis term; ITCZ, intertropical
% convergence zone) model solves two diagnostic equations for meridional-
% vertical mass stream function; one involves NCTs, and the other does not.
% An ITCZ-like forcing and a constant dissipation rate are prescribed.
% The model solves the equation iteratively using the multigrid method.
% Hing Ong, 23 Jan 2019

% version 2
% Fix bugs in "basic_state," "analyses," and "forcing"
% Hing Ong, 06 Mar 2019

% version 3
% Add two new features.
% 1. Control the vertical weighting of the forcing with a parameter, gamma.
% 2. Output norm_u_table and norm_du_table.
% Rearrange the parameter loop. Take the alpha loop to outer.
% Hing Ong, 27 Mar 2019

% INITIALIZE_______________________________________________________________
namelist
max_u_table=zeros(numel(MU),numel(SIGMA));
max_du_table=zeros(numel(MU),numel(SIGMA));
norm_u_table=zeros(numel(MU),numel(SIGMA));
norm_du_table=zeros(numel(MU),numel(SIGMA));

% SETUP____________________________________________________________________
[y,z,rdy,rdz,in_y,in_z] = domain(ny,nz,dy,dz,y_center,z_start);
% rdy is 1/dy, and in_y is the indices of interior
[T,p,rho,Exner,th,rH,N2,beta] = basic_state(z,tropopause,T_surf,Gamma_tropo,Gamma_strato,p_surf,p_ref,R,cp,g,rdz,Omega,a);
for i_alpha = 1:numel(ALPHA)
    alpha = ALPHA(i_alpha)
    [A_NCT,B_NCT,C_NCT,D_NCT,E_NCT] = coefficient_NCT(N2(in_z,in_y),Omega,alpha,beta,y(in_z,in_y),rH(in_z,in_y));
    [A_TCT,B_TCT,C_TCT,D_TCT,E_TCT] = coefficient_TCT(N2(in_z,in_y),alpha,beta,y(in_z,in_y),rH(in_z,in_y));
    for i_mu = 1:numel(MU)
        mu = MU(i_mu)
        for i_sigma = 1:numel(SIGMA)
            sigma = SIGMA(i_sigma)
            [F,Q,prec_mm_day] = forcing(y,z,in_y,in_z,rho(in_z,in_y),T(in_z,in_y)...
                ,max_prec,mu,sigma,tropopause,rdy,dz,g,cp,Lc,rho_water,rH,gamma);
% SOLVE____________________________________________________________________
            [psi_NCT,residual_NCT,i_NCT] = solutions(psi_first,max_iteration,tolerance,A_NCT,B_NCT,C_NCT,D_NCT,E_NCT,F,rdy,rdz,in_y,in_z,y,z);
            [psi_TCT,residual_TCT,i_TCT] = solutions(psi_first,max_iteration,tolerance,A_TCT,B_TCT,C_TCT,D_TCT,E_TCT,F,rdy,rdz,in_y,in_z,y,z);
% ANALYZE__________________________________________________________________
            [v_NCT,w_NCT,u_NCT,th_NCT] = analyses(Omega,psi_NCT,in_y,in_z,rdy,rdz,rho,beta,y,alpha,Q,cp,T,N2,th,g);
            [v_TCT,w_TCT,u_TCT,th_TCT] = analyses(0,psi_TCT,in_y,in_z,rdy,rdz,rho,beta,y,alpha,Q,cp,T,N2,th,g);
% OUTPUT___________________________________________________________________
            max_u_table(i_mu,i_sigma) = max(max(u_NCT));
            max_du_table(i_mu,i_sigma)= max(max(u_TCT-u_NCT));
            norm_u_table(i_mu,i_sigma) = norm(u_NCT);
            norm_du_table(i_mu,i_sigma)= norm(u_TCT-u_NCT);
        end % sigma
    end % mu
end % alpha