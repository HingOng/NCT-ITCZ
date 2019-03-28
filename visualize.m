close all
y_in = y(in_z,in_y)*0.001;
z_in = z(in_z,in_y)*0.001;
y_lim = [-3200,3200];
y_tick = -3200:800:3200;
z_lim = [0.5,24];
z_tick = 0:8:24;
cmap = colormap;

% psi
figure('Color','w','Colormap',cmap(1:14,:))
hold on
contourf(y*0.001,z*0.001,(psi_TCT - psi_NCT)*2*pi*a*1e-10,-0.07:0.007:0.028,'LineStyle','None')
colorbar('Ticks',-0.07:0.035:0);
contour(y*0.001,z*0.001,(psi_TCT - psi_NCT)*2*pi*a*1e-10,0:0.007:0.028,'LineColor','k','LineStyle','-','LineWidth',0.5)
contour(y*0.001,z*0.001,(psi_TCT - psi_NCT)*2*pi*a*1e-10,-0.07:0.007:0,'LineColor','k','LineStyle','--','LineWidth',0.5)
contour(y*0.001,z*0.001,psi_NCT*2*pi*a*1e-10,2:2:12,'LineColor','k','LineStyle','-','LineWidth',1.5);
contour(y*0.001,z*0.001,psi_NCT*2*pi*a*1e-10,-2:-2:-12,'LineColor','k','LineStyle','--','LineWidth',1.5);
set(gca,'Box','on','LineWidth',1,'XLim',y_lim,'XTick',y_tick,...
    'YLim',z_lim,'Ytick',z_tick,'TickDir','out','CLim',[-0.07,0.028])
xlabel('Y (km)')
ylabel('Z (km)')
title({'{\Psi} (interval: 2 {\times} 10^1^0 kg s^-^1) and {\Delta}{\Psi} (units: 10^1^0 kg s^-^1)';''})

% v and w
figure('Color','w','Colormap',cmap(9:20,:))
hold on
contourf(y_in,z_in,w_NCT*1e3,-3.2:1.6:16,'LineStyle','None')
colorbar('Ticks',0:8:16);
contour(y_in,z_in,w_NCT*1e3,0:1.6:16,'LineColor','k','LineStyle','-','LineWidth',0.5)
contour(y_in,z_in,w_NCT*1e3,-3.2:1.6:0,'LineColor','k','LineStyle','--','LineWidth',0.5)
contour(y_in,z_in,v_NCT,0.3:0.3:1.5,'LineColor','k','LineStyle','-','LineWidth',1.5);
contour(y_in,z_in,v_NCT,-0.3:-0.3:-1.5,'LineColor','k','LineStyle','--','LineWidth',1.5);
set(gca,'Box','on','LineWidth',1,'XLim',y_lim,'XTick',y_tick,...
    'YLim',z_lim,'Ytick',z_tick,'TickDir','out','CLim',[-3.2,16])
xlabel('Y (km)')
ylabel('Z (km)')
title({'v (interval: 0.3 m s^-^1) and w (units: 10^-^3 m s^-^1)';''})

% u
figure('Color','w','Colormap',cmap(9:20,:))
hold on
contourf(y_in,z_in,(u_TCT - u_NCT),-0.6:0.3:3,'LineStyle','None')
colorbar('Ticks',0:1.5:3);
contour(y_in,z_in,(u_TCT - u_NCT),0:0.3:3,'LineColor','k','LineStyle','-','LineWidth',0.5)
contour(y_in,z_in,(u_TCT - u_NCT),'LineColor','k','LineStyle','--','LineWidth',0.5)
contour(y_in,z_in,u_NCT,5:5:25,'LineColor','k','LineStyle','-','LineWidth',1.5);
contour(y_in,z_in,u_NCT,-5:-5:-25,'LineColor','k','LineStyle','--','LineWidth',1.5);
set(gca,'Box','on','LineWidth',1,'XLim',y_lim,'XTick',y_tick,...
    'YLim',z_lim,'Ytick',z_tick,'TickDir','out','CLim',[-0.6,3])
xlabel('Y (km)')
ylabel('Z (km)')
title({'u (interval: 5 m s^-^1) and {\Delta}u (units: m s^-^1)';''})

% w and th
figure('Color','w','Colormap',cmap(3:20,:))
hold on
contourf(y_in,z_in,(th_TCT - th_NCT),-0.144:0.018:0.18,'LineStyle','None')
colorbar('Ticks',-0.09:0.09:0.18);
contour(y_in,z_in,(th_TCT - th_NCT),0:0.018:0.18,'LineColor','k','LineStyle','-','LineWidth',0.5)
contour(y_in,z_in,(th_TCT - th_NCT),-0.144:0.018:0,'LineColor','k','LineStyle','--','LineWidth',0.5)
contour(y_in,z_in,(w_TCT - w_NCT)*1e6,5:5:25,'LineColor','k','LineStyle','-','LineWidth',1.5);
contour(y_in,z_in,(w_TCT - w_NCT)*1e6,-5:-5:-25,'LineColor','k','LineStyle','--','LineWidth',1.5);
set(gca,'Box','on','LineWidth',1,'XLim',y_lim,'XTick',y_tick,...
    'YLim',z_lim,'Ytick',z_tick,'TickDir','out','CLim',[-0.144,0.18])
xlabel('Y (km)')
ylabel('Z (km)')
title({'{\Delta}w (interval: 5 {\times} 10^-^6 m s^-^1) and {\Delta}{\theta}'' (units: K)';''})

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
