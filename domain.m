function [y,z,rdy,rdz,in_y,in_z] = domain(ny,nz,dy,dz,y_center,z_start)
% Setup the domain.
% ny and nz are the numbers of scalar grids in y and z.
% dy and dz are the grid spacings in y and z (m).
% y_center and z_start are the position (m).
y_start = y_center - (ny - 1) * 0.5 * dy;
y_end = y_center + (ny - 1) * 0.5 * dy;
z_end = z_start + (nz - 1) * dz;
yy = linspace(y_start,y_end,ny);
zz = linspace(z_start,z_end,nz);
[y,z] = meshgrid(yy,zz);
rdy = 1 / dy;
rdz = 1 / dz;
in_y = 2:ny-1;
in_z = 2:nz-1;
end

