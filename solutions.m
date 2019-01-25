function [psi,residual,i] = solutions(psi_first,max_iteration,tolerance,A,B,C,D,E,F,rdy,rdz,in_y,in_z,y,z)
% Solve the streamfunction
% Multigrid start
[nz,ny] = size(psi_first);
y_start = min(min(y));
y_end = max(max(y));
z_start = min(min(z));
z_end = max(max(z));
max_multigrid = floor(log2(min(ny-1,nz-1))) - 1;
y_mm = y;
z_mm = z;
psi_new = psi_first;
for m = -max_multigrid : -1
    ny_m = floor((ny-1)*2^m) + 1;
    nz_m = floor((nz-1)*2^m) + 1;
    yy_m = linspace(y_start,y_end,ny_m);
    zz_m = linspace(z_start,z_end,nz_m);
    [y_m,z_m] = meshgrid(yy_m,zz_m);
    rdy_m = (ny_m - 1) / (y_end - y_start);
    rdz_m = (nz_m - 1) / (z_end - z_start);
    in_y_m = 2:ny_m-1;
    in_z_m = 2:nz_m-1;
    A_m = interp2(y(in_z,in_y),z(in_z,in_y),A,y_m(in_z_m,in_y_m),z_m(in_z_m,in_y_m),'cubic');
    B_m = interp2(y(in_z,in_y),z(in_z,in_y),B,y_m(in_z_m,in_y_m),z_m(in_z_m,in_y_m),'cubic');
    C_m = interp2(y(in_z,in_y),z(in_z,in_y),C,y_m(in_z_m,in_y_m),z_m(in_z_m,in_y_m),'cubic');
    D_m = interp2(y(in_z,in_y),z(in_z,in_y),D,y_m(in_z_m,in_y_m),z_m(in_z_m,in_y_m),'cubic');
    E_m = interp2(y(in_z,in_y),z(in_z,in_y),E,y_m(in_z_m,in_y_m),z_m(in_z_m,in_y_m),'cubic');
    F_m = interp2(y(in_z,in_y),z(in_z,in_y),F,y_m(in_z_m,in_y_m),z_m(in_z_m,in_y_m),'cubic');
    psi_old = interp2(y_mm,z_mm,psi_new,y_m,z_m,'cubic');
    for i = 1 : max_iteration
        [psi_new,residual] = relaxation(A_m,B_m,C_m,D_m,E_m,F_m,rdy_m,rdz_m,in_y_m,in_z_m,psi_old);
        if (tolerance*norm(residual)<norm(F_m))
            break
        end
        psi_old = psi_new;
    end
    y_mm = y_m;
    z_mm = z_m;
end
psi_old = interp2(y_mm,z_mm,psi_new,y,z,'cubic');
% Multigrid end
% psi_old = psi_first; % Implement this line if not applying the multigrid
for i = 1 : max_iteration
    [psi_new,residual] = relaxation(A,B,C,D,E,F,rdy,rdz,in_y,in_z,psi_old);
    if (tolerance*norm(residual)<norm(F))
        break
    end
    psi_old = psi_new;
end
psi = psi_new;
if (i == max_iteration)
    disp('Warning: the solution may not converge.')
end
end

function [psi_new,residual] = relaxation(A,B,C,D,E,F,rdy,rdz,in_y,in_z,psi)
% A(d^2/dy^2) + 2B(d^2/dydz) + C(d^2/dz^2) + D(d/dy) + E(d/dz) = F
d2psi_dy2 = A .* (psi(in_z,in_y+1) + psi(in_z,in_y-1)) * rdy ^ 2; % A .* (psi_nor + psi_sou - 2 * psi) / dy ^ 2
d2psi_dydz = B .* (psi(in_z+1,in_y+1) + psi(in_z-1,in_y-1) - psi(in_z+1,in_y-1) - psi(in_z-1,in_y+1)) * 0.5 * rdy * rdz;
d2psi_dz2 = C .* (psi(in_z+1,in_y) + psi(in_z-1,in_y)) * rdz ^ 2; % C .* (psi_up + psi_lo - 2 * psi) / dz ^ 2
dpsi_dy = D .* (psi(in_z,in_y+1) - psi(in_z,in_y-1)) * 0.5 * rdy;
dpsi_dz = E .* (psi(in_z+1,in_y) - psi(in_z-1,in_y)) * 0.5 * rdz;
relax_coef = 2 * (A * rdy ^ 2 + C * rdz ^ 2);
residual = (d2psi_dy2 + d2psi_dydz + d2psi_dz2 + dpsi_dy + dpsi_dz - F) - psi(in_z,in_y) .* relax_coef;
psi_new = psi;
psi_new(in_z,in_y) = (d2psi_dy2 + d2psi_dydz + d2psi_dz2 + dpsi_dy + dpsi_dz - F) ./ relax_coef;
end
