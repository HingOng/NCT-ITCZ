close all
y_in = y(in_z,in_y)*0.001;
z_in = z(in_z,in_y)*0.001;
y_lim = [-3200,3200];
y_tick = -3200:800:3200;
z_lim = [0.5,24];
z_tick = 0:8:24;
cmap = colormap;

% psi
figure('Color','w','Colormap',cmap(1:12,:))
hold on
contourf(y*0.001,z*0.001,(psi_TCT - psi_NCT)*2*pi*a*1e-10,-0.03:0.003:0.006,'LineStyle','None')
colorbar('Ticks',-0.03:0.015:0);
contour(y*0.001,z*0.001,psi_NCT*2*pi*a*1e-10,1:1:6,'LineColor','k','LineStyle','-','LineWidth',1.5);
contour(y*0.001,z*0.001,psi_NCT*2*pi*a*1e-10,-1:-1:-6,'LineColor','k','LineStyle','--','LineWidth',1.5);
set(gca,'Box','on','LineWidth',1,'XLim',y_lim,'XTick',y_tick,...
    'YLim',z_lim,'Ytick',z_tick,'TickDir','out','CLim',[-0.03,0.006])
xlabel('Y (km)')
ylabel('Z (km)')
title({'{\Psi} (interval: 10^1^0 kg s^-^1) and {\Delta}{\Psi} (units: 10^1^0 kg s^-^1)';''})

% v and w
figure('Color','w','Colormap',cmap(9:20,:))
hold on
contourf(y_in,z_in,w_NCT*1e3,-1.6:0.8:8,'LineStyle','None')
colorbar('Ticks',0:4:8);
contour(y_in,z_in,v_NCT,0.15:0.15:0.6,'LineColor','k','LineStyle','-','LineWidth',1.5);
contour(y_in,z_in,v_NCT,-0.15:-0.15:-0.6,'LineColor','k','LineStyle','--','LineWidth',1.5);
set(gca,'Box','on','LineWidth',1,'XLim',y_lim,'XTick',y_tick,...
    'YLim',z_lim,'Ytick',z_tick,'TickDir','out','CLim',[-1.6,8])
xlabel('Y (km)')
ylabel('Z (km)')
title({'v (interval: 0.15 m s^-^1) and w (units: 10^-^3 m s^-^1)';''})

% u
figure('Color','w','Colormap',cmap(9:20,:))
hold on
contourf(y_in,z_in,(u_TCT - u_NCT),-0.44:0.22:2.2,'LineStyle','None')
colorbar('Ticks',0:1.1:2.2);
contour(y_in,z_in,u_NCT,4:4:20,'LineColor','k','LineStyle','-','LineWidth',1.5);
contour(y_in,z_in,u_NCT,-4:-4:-20,'LineColor','k','LineStyle','--','LineWidth',1.5);
set(gca,'Box','on','LineWidth',1,'XLim',y_lim,'XTick',y_tick,...
    'YLim',z_lim,'Ytick',z_tick,'TickDir','out','CLim',[-0.44,2.2])
xlabel('Y (km)')
ylabel('Z (km)')
title({'u (interval: 4 m s^-^1) and {\Delta}u (units: m s^-^1)';''})

% w and th
figure('Color','w','Colormap',cmap(1:18,:))
hold on
contourf(y_in,z_in,(th_TCT - th_NCT),-0.14:0.014:0.112,'LineStyle','None')
colorbar('Ticks',-0.14:0.07:0.07);
contour(y_in,z_in,(w_TCT - w_NCT)*1e6,2:2:8,'LineColor','k','LineStyle','-','LineWidth',1.5);
contour(y_in,z_in,(w_TCT - w_NCT)*1e6,-2:-2:-8,'LineColor','k','LineStyle','--','LineWidth',1.5);
set(gca,'Box','on','LineWidth',1,'XLim',y_lim,'XTick',y_tick,...
    'YLim',z_lim,'Ytick',z_tick,'TickDir','out','CLim',[-0.14,0.112])
xlabel('Y (km)')
ylabel('Z (km)')
title({'{\Delta}w (interval: 2 {\times} 10^-^6 m s^-^1) and {\Delta}{\theta}'' (units: K)';''})

function [cmap] = colormap
cmap=[20,100,210;
     30,110,235;
     40,130,240;
     60,150,245;
     80,165,245;
     120,185,250;
     150,210,250;
     180,240,250;
     225,255,255;
     255,255,255;
     255,255,255;
     255,250,170;
     255,232,120;
     255,192,60;
     255,160,0;
     255,96,0;
     255,50,0;
     225,20,0;
     192,0,0;
     165,0,0;]/255;
end
