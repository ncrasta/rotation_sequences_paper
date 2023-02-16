  
%%=======================================================================%%
% ANIMATION OF VIVIANIS CURVE USING THE NORMAL PARAMETRIZATION
% Authos: Dr. S. P. Bhat and Naveen
% MATLAB verison: 2014a
% External files needed: mArrow3
% Last modified: December 24, 2014 
% For the explanation refer to the paper "Closed Attitude Trajectories"
% NOTE: PLEASE MAXIMIZE THE FIGURE WHEN IT APPEARS
%%=======================================================================%%

clear all;
close all;
clc;
%**********SET THE PARAMETERS**********************************************
a     = 1/2;
T     = 4*pi;
DELAY = 0.5;
%***********ALLOCATE MEMORY************************************************
t  = linspace(0,T,1000);   % t = [0,4*pi]
Pu = zeros(3,length(t));
Su = zeros(1,length(t));
Nu = zeros(3,length(t));
Ku = zeros(1,length(t));
for i=1:length(t)          % t = [0,4*pi]
    ti      = t(i);
    Pu(:,i) = pu(ti,a);
    Su(1,i) = su(ti,a);
    Nu(:,i) = nu(ti,a);
    Ku(1,i) = ku(ti,a);
end
Y  = [Su' Ku'];
%************************************************************************
fig = figure('DoubleBuffer','On','Color','white'); clf; hold on;
set(fig,'outerposition',[0 0 1440 1200]);
set(0,'units','pixels');
set(gcf, 'color', rgb('Ivory'));  % SET THE BACKGROUND COLOR OF THE FIGURE
set(gca, 'color', rgb('Gray'));   % SET COLOR FOR THE AXIS
set(gcf,'Renderer','opengl');     % SELECT A RENDERING MODE **IMPORTANT***
opengl('software');
set(fig,'units','normalized','outerposition',[0 0 1 1]);
vid=1;
if(vid==1)
    animation = VideoWriter('VivianiFirstParametrization.mp4', 'MPEG-4');
    open(animation);
end
%--------------------------------------------------------------------------
f1            = subplot(3,2,1);
set(f1,'Position',[0.05 0.15 0.5 0.85])
[x,y,z]       = sphere(100);
mhndl_sphere  = surf( 2*a*x, 2*a*y, 2*a*z);
shading interp;
colormap(gray);
alpha(mhndl_sphere,0.75);
set(mhndl_sphere,'FaceLighting','none',...
                 'FaceColor','interp',...
                 'FaceAlpha', 0.35,...
                 'EdgeColor','none',...
                 'BackFaceLighting','lit',...
                 'AmbientStrength',0.3,...
                 'DiffuseStrength',0.8,...
                 'SpecularStrength',0.9,...
                 'SpecularExponent',25);
x_viviani     = Pu(1,:);
y_viviani     = Pu(2,:);
z_viviani     = Pu(3,:);
vhndl_viviani = line(x_viviani(1:end),y_viviani(1:end),z_viviani(1:end));
set(vhndl_viviani,'LineWidth',2.5);
hold on;
plot3(0,0,0,'ok');
plot3(0,0,0,'*k');
plot3(x_viviani(1:end),y_viviani(1:end),z_viviani(1:end),'linewidth',0.25);

hh1a     = plot3(x_viviani(1:1),y_viviani(1:1),z_viviani(1:1),...
                 '*r','linewidth',2.5);
             
hh1b     = plot3(x_viviani(1:1),y_viviani(1:1),z_viviani(1:1),...
                 'or','linewidth',2.5);
             
posnPu   = text('Interpreter','latex','String','$p_{u}(t)$',...
                'Position',[x_viviani(1:1),y_viviani(1:1),z_viviani(1:1)],...
                'FontSize',15,'EraseMode','Xor');
            
cursorPu = mArrow3([0;0;0],[x_viviani(1);y_viviani(1);z_viviani(1)],...
                   'color','black','stemWidth',0.01/2,'facealpha',1.00,...
                   'LineSmoothing','on');         
               
posnNu   = text('Interpreter','latex','String','$n_{u}(t)$',...
                'Position',[x_viviani(1),y_viviani(1),z_viviani(1)]+1.1*[Nu(1:1),Nu(1:1),Nu(1:1)],...
                'FontSize',15,'EraseMode','Xor');
            
              
cursorNu = mArrow3([x_viviani(1);y_viviani(1);z_viviani(1)],...
                   [x_viviani(1);y_viviani(1);z_viviani(1)]+0.4*Nu(:,1),...
                   'color','red','stemWidth',0.01/2,'facealpha',1.00,...
                   'LineSmoothing','on');
view(50,20);
axis equal; axis off;
%--------------------------------------------------------------------------
f2 = subplot(3,2,2);
set(f2,'Position',[0.700 0.75 0.205 0.15]);
hh2 = plot(t(1),Su(1),'-m','linewidth',2.5);
axis([0 t(end) 0 1]);
set(gca,'YTick',0:0.5:1);
box on;
h = xlabel('$$t$$');
set(h,'Interpreter','latex','fontsize',20);
h = ylabel('$$s_{u}(t)$$');
set(h,'Interpreter','latex','fontsize',20);
title('Speed','Interpret','latex','fontsize',20);
H = gca;
set(H,'YTick',0:0.5:1,'XTick',0:t(end)/4:t(end));
set(H,'xticklabel', '0 | p  | 2p  | 3p | 4p', 'fontname', 'symbol',...
      'fontsize',15);
grid on;
%--------------------------------------------------------------------------
f3 = subplot(3,2,4);
set(f3,'Position',[0.700 0.45 0.205 0.15]);
hh4 = plot(t(1),Ku(1),'-r','linewidth',2.5);
axis([0 t(end) min(Ku)-0.1 max(Ku)+0.1]);
set(f3,'YTick',-1:0.5:1);
box on;
h   = xlabel('$$t$$');
set(h,'Interpreter','latex','fontsize',20);
h   = ylabel('$$\kappa_{u}(t)$$');
set(h,'Interpreter','latex','fontsize',20);
title('Turn rate','Interpret','latex','fontsize',20);
H   = gca;
set(H,'XTick',0:t(end)/4:t(end));
set(H,'YTick',-1:1:1,'XTick',0:t(end)/4:t(end));
set(H,'xticklabel', '0 | p  | 2p  | 3p | 4p', 'fontname', 'symbol',...
      'fontsize',15);
grid on;
%--------------------------------------------------------------------------
f4  = subplot(3,2,6);
set(f4,'Position',[0.700 0.15 0.205 0.15]);
p1X = 1; p1Y = Y(1,1);
p2X = 2; p2Y = Y(1,2);
p1  = bar(p1X,p1Y,0.5);
hold on;
p2  = bar(p2X,p2Y,0.5);
set(p1,'FaceColor','magenta','EdgeColor',[0 0 0],'LineWidth',1);
set(p2,'FaceColor','red','EdgeColor',[0 0 0],'LineWidth',1);
axis([0 2.5 -0.5 2*pi]);
grid on;
% Get figure size
%pos    = get(gcf, 'Position');
%width  = pos(3);
%height = pos(4);
%--------------------------------------------------------------------------
f4  = subplot(3,2,6);
set(f4,'Position',[0.700 0.15 0.205 0.15]);
p1X = 1; p1Y = Y(1,1);
p2X = 2; p2Y = Y(1,2);

p1 = bar(p1X,p1Y,0.5);
hold on;
p2 = bar(p2X,p2Y,0.5);
set(p1,'FaceColor','magenta','EdgeColor',[0 0 0],'LineWidth',1);
set(p2,'FaceColor','red','EdgeColor',[0 0 0],'LineWidth',1);
axis([0 2.5 -1.1 1.1]);
grid on;
% Get figure size
pos    = get(gcf, 'Position');
width  = pos(3);
height = pos(4);

for i = 1:1:length(t)
    % Update graphics data. This is more efficient than recreating plots.
                       
    set(hh1a,'XData',x_viviani(i),...
             'YData',y_viviani(i),...
             'ZData',z_viviani(i));
         
    set(hh1b,'XData',x_viviani(i),...
             'YData',y_viviani(i),...
             'ZData',z_viviani(i));

    set(hh2,'XData',t(1:i),'YData',Su(1:i));
 
    set(hh4,'XData',t(1:i),'YData',Ku(1:i));
 
    set(p1,'XData',1,'YData',Y(i,1));
    set(p2,'XData',2,'YData',Y(i,2));
    
    H = gca;
    set(H,'YTick',-1:1:1,'XTick',0:t(end)/4:t(end));
    set(H,'XTick',0:1:2,'XTick',[1  2]);
    set(gca,'Xtick',1:2,'XTickLabel',{'Speed', 'Turn rate'},'fontsize',20)
    
    subplot(f1);
    set(cursorNu,'Visible','off');
    set(cursorPu,'Visible','off');
    
    set(vhndl_viviani,'XData',x_viviani(1:i),...
                      'YData',y_viviani(1:i),...
                      'ZData',z_viviani(1:i));
  
    cursorPu = mArrow3([0;0;0],[x_viviani(i);y_viviani(i);z_viviani(i)],...
                       'color','black','stemWidth',0.01/2,...
                       'facealpha',1.00,'LineSmoothing','on');
    
    cursorNu = mArrow3([x_viviani(i);y_viviani(i);z_viviani(i)],...
                   [x_viviani(i);y_viviani(i);z_viviani(i)]+0.4*Nu(:,i),...
                   'color','red','stemWidth',0.01/2,'facealpha',1.00,...
                   'LineSmoothing','on');
                   
    set(posnPu,'Position',[x_viviani(i)+0.05,...
                           y_viviani(i)+0.05,...
                           z_viviani(i)+0.05]);
                       
    set(posnNu,'Position',[x_viviani(i)+0.45*Nu(1,i),...
                           y_viviani(i)+0.45*Nu(2,i),...
                           z_viviani(i)+0.45*Nu(3,i)]);

    set(cursorNu,'Visible','on');
    set(cursorPu,'Visible','on');

    drawnow;
    if(vid==1)
        drawnow;
        currFrame = getframe(fig);
        writeVideo(animation, currFrame);
    else
        pause(DELAY);
        drawnow;
    end
end
if(vid==1)
    close(animation);
end
