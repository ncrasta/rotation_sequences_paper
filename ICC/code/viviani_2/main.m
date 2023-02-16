%%=======================================================================%%
% ANIMATION OF VIVIANIS CURVE USING SECOND PARAMETRIZATION
% Authos: Dr. S. P. Bhat and Naveen
% MATLAB verison: 2014a
% External files needed: mArrow3
% Last modified: December 24, 2014 
% For the explanation refer to the paper "Closed Attitude Trajectories"
% NOTE: PLEASE MAXIMIZE THE FIGURE WHEN IT APPEARS
%%=======================================================================%%

clc;
close all;
clear all;
a      = 10;
DELAY  = 0.5;
%**************************************************************************
t1  = linspace(0,2*pi,2500);            % t1 = [0,2*pi]
t2  = linspace(2*pi,2*pi+a,500);        % t2 = [2*pi,2*pi+a]
t3  = linspace(2*pi+a,4*pi+a,2500);     % t3 = [2*pi+a,4*pi+a]
t4  = linspace(4*pi+a,4*pi+2*a,500);    % t4 = [4*pi+a,4*pi+2*a]

Pb1 = zeros(3,length(t1));
Pb2 = zeros(3,length(t2));
Pb3 = zeros(3,length(t3));
Pb4 = zeros(3,length(t4));

Sb1 = zeros(1,length(t1));
Sb2 = zeros(1,length(t2));
Sb3 = zeros(1,length(t3));
Sb4 = zeros(1,length(t4));

Nb1 = zeros(3,length(t1));
Nb2 = zeros(3,length(t2));
Nb3 = zeros(3,length(t3));
Nb4 = zeros(3,length(t4));

Kb1 = zeros(1,length(t1));
Kb2 = zeros(1,length(t2));
Kb3 = zeros(1,length(t3));
Kb4 = zeros(1,length(t4));

for i=1:length(t1)          % t1 = [0,2*pi]
    t        = t1(i);
    Pb1(:,i) = pu(g1(t));
    Sb1(1,i) = Dg1(t)*su(g1(t));
    Nb1(:,i) = nu(g1(t));
    Kb1(1,i) = Dg1(t)*ku(g1(t));
end
for i=1:length(t2)          % t2  = [2*pi,2*pi+a]
    t        = t2(i);
    Pb2(:,i) = pu(2*pi);
    Sb2(1,i) = 0;
    Nb2(:,i) = cos(h(t-2*pi,a))*[0;-1/sqrt(2);-1/sqrt(2)] + ...
               sin(h(t-2*pi,a))*[0;-1/sqrt(2);1/sqrt(2)];
    Kb2(1,i) = Dh(t-2*pi,a);
end
for i=1:length(t3)          % t3 = [2*pi+a,4*pi+a]
    t        = t3(i);
    Pb3(:,i) = pu(g2(t-a));
    Sb3(1,i) = -Dg2(t-a)*su(g2(t-a));
    Nb3(:,i) = -nu(g2(t-a));
    Kb3(1,i) = Dg2(t-a)*ku(g2(t-a));
end
for i=1:length(t4)          % t4 = [4*pi+a,4*pi+2*a]
    t        = t4(i);
    Pb4(:,i) = pu(4*pi);
    Sb4(1,i) = 0;
    Nb4(:,i) = cos(h(t-4*pi-a,a))*[0;1/sqrt(2);1/sqrt(2)] + ...
               sin(h(t-4*pi-a,a))*[0;1/sqrt(2);-1/sqrt(2)];
    Kb4(1,i) = Dh(t-4*pi-a,a);
end
t  = [t1 t2 t3 t4];
Pb = [Pb1 Pb2 Pb3 Pb4];
Sb = [Sb1 Sb2 Sb3 Sb4];
Kb = [Kb1 Kb2 Kb3 Kb4];
Nb = [Nb1 Nb2 Nb3 Nb4];
Y  = [Sb' Kb'];
%************************************************************************
fig = figure('DoubleBuffer','On','Color','white'); clf; hold on;
%pause(1);
set(fig,'outerposition',[0 0 1440 1000]);
set(0,'units','pixels');
set(gcf, 'color', rgb('Ivory'));  % SET THE BACKGROUND COLOR OF THE FIGURE
set(gca, 'color', rgb('Gray'));   % SET COLOR FOR THE AXIS
set(gcf,'Renderer','opengl');     % SELECT A RENDERING MODE **IMPORTANT***
opengl('software');
%set(fig,'units','normalized','outerposition',[0 0 1 1]);

vid=1;
if(vid==1)
    animation = VideoWriter('VivianiSecondParametrization.mp4', 'MPEG-4');
%     animation.FrameRate = 1;
    open(animation);
end
%--------------------------------------------------------------------------
f1            = subplot(3,2,1);
set(f1,'Position',[0.05 0.15 0.5 0.85])
[x,y,z]       = sphere(100);
mhndl_sphere  = surf( 2*0.5*x, 2*0.5*y, 2*0.5*z);
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
x_viviani     = Pb(1,:);
y_viviani     = Pb(2,:);
z_viviani     = Pb(3,:);
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
             
posnPb   = text('Interpreter','latex','String','$p_{b}(t)$',...
                'Position',[x_viviani(1:1),y_viviani(1:1),z_viviani(1:1)],...
                'FontSize',15,'EraseMode','Xor');
            
cursorPb = mArrow3([0;0;0],[x_viviani(1);y_viviani(1);z_viviani(1)],...
                   'color','black','stemWidth',0.01/2,'facealpha',1.00,...
                   'LineSmoothing','on');         
               
posnNb   = text('Interpreter','latex','String','$n_{b}(t)$',...
                'Position',[x_viviani(1),y_viviani(1),z_viviani(1)]+1.1*[Nb(1:1),Nb(1:1),Nb(1:1)],...
                'FontSize',15,'EraseMode','Xor');          
            
cursorNb = mArrow3([x_viviani(1);y_viviani(1);z_viviani(1)],...
                   [x_viviani(1);y_viviani(1);z_viviani(1)]+0.4*Nb(:,1),...
                   'color','red','stemWidth',0.01/2,'facealpha',1.00,...
                   'LineSmoothing','on');

text('Interpreter','latex','String','$\alpha=10$','Position',1.0*[-0.5 0.4 -1.75],'FontSize',30);
view(50,20);
axis equal; axis off;
%--------------------------------------------------------------------------
f2 = subplot(3,2,2);
set(f2,'Position',[0.700 0.75 0.205 0.15]);
hh2 = plot(t(1),Sb(1),'-m','linewidth',2.5);
axis([0 t(end) 0 1]);
set(gca,'YTick',0:0.5:1);
box on;
h = xlabel('$$t$$');
set(h,'Interpreter','latex','fontsize',20);
h = ylabel('$$s_{b}(t)$$');
set(h,'Interpreter','latex','fontsize',20);
title('Speed','Interpret','latex','fontsize',20);
H = gca;
set(H,'YTick',0:0.5:1);
set(H,'XTick',[0 2*pi 2*pi+a 4*pi+a 4*pi+2*a]);
set(H,'xticklabel', '0 | 2p  | 2p+a  | 4p+a | 4p+2a', 'fontname', 'symbol',...
      'fontsize',15);
%set(H,'xticklabel', '0 | p  | 2p  | 3p | 4p', 'fontname', 'symbol',...
%      'fontsize',20);
grid on;
%--------------------------------------------------------------------------
f3 = subplot(3,2,4);
set(f3,'Position',[0.700 0.45 0.205 0.15]);
hh4 = plot(t(1),Kb(1),'-r','linewidth',2.5);
axis([0 t(end) min(Kb)-0.1 max(Kb)+1.5]);
box on;
h   = xlabel('$$t$$');
set(h,'Interpreter','latex','fontsize',20);
h   = ylabel('$$\kappa_{b}(t)$$');
set(h,'Interpreter','latex','fontsize',20);
tit = title('Turn rate','Interpret','latex','fontsize',20);
H   = gca;
%set(H,'XTick',0:t(end)/4:t(end));
set(H,'YTick',-1.5:1.5:1.5,'XTick',0:t(end)/4:t(end));
% set(H, 'yticklabel', '0 | p  | 2p', 'fontname', 'symbol',...
%        'fontsize',20);
set(H,'XTick',[0 2*pi 2*pi+a 4*pi+a 4*pi+2*a]);
set(H,'xticklabel', '0 | 2p  | 2p+a  | 4p+a | 4p+2a', 'fontname', 'symbol',...
      'fontsize',15);
%set(H,'xticklabel', '0 | p  | 2p  | 3p | 4p', 'fontname', 'symbol',...
%      'fontsize',20);
grid on;
%--------------------------------------------------------------------------
f4  = subplot(3,2,6);
set(f4,'Position',[0.700 0.15 0.205 0.15]);
p1X = 1; p1Y = Y(1,1);
p2X = 2; p2Y = Y(1,2);
%axis([0 2.5 min([min(Sb) min(Kb)]) max([max(Sb) max(Kb)])]);
p1 = bar(p1X,p1Y,0.5);
hold on;
p2 = bar(p2X,p2Y,0.5);
set(p1,'FaceColor','magenta','EdgeColor',[0 0 0],'LineWidth',1);
set(p2,'FaceColor','red','EdgeColor',[0 0 0],'LineWidth',1);
axis([0 2.5 -2 2]);
%H   = gca;
%set(H,'XTick',0:t(end)/4:t(end));
%set(H,'YTick',min(Kb):1:max(Kb),'XTick',0:t(end)/4:t(end));
% set(H, 'yticklabel', '0 | p  | 2p', 'fontname', 'symbol',...
%        'fontsize',20);
grid on;
% Get figure size
pos    = get(gcf, 'Position');
width  = pos(3);
height = pos(4);

for i=2:10:length(t)
    set(hh1a,'XData',x_viviani(i),...
             'YData',y_viviani(i),...
             'ZData',z_viviani(i));
         
    set(hh1b,'XData',x_viviani(i),...
             'YData',y_viviani(i),...
             'ZData',z_viviani(i));

    set(hh2,'XData',t(1:i),'YData',Sb(1:i));
 
    set(hh4,'XData',t(1:i),'YData',Kb(1:i));
 
    set(p1,'XData',1,'YData',Y(i,1));
    set(p2,'XData',2,'YData',Y(i,2));
%    set(cursor1,'XData',[1,2],'YData',Y(i,:));
    H = gca;
    %set(H,'XTick',0:t(end)/4:t(end));
    set(H,'YTick',-2:2:2);
    %set(H,'XTick',0:1:2,'XTick',[1  2]);
%    set(H, 'xticklabel', ' |Speed | Turn rate', 'fontname', 'symbol');
    set(gca,'Xtick',1:2,'XTickLabel',{'Speed', '   Turn rate'},'fontsize',20)
    %set(hh2(1), 'XData', [0, x(id, 1)], 'YData', [0, y(id, 1)])
    %set(hh2(2), 'XData', x(id, :), 'YData', y(id, :))
    %set(ht, 'String', sprintf('Time: %0.2f sec', T(id)))
    subplot(f1);
    set(cursorNb,'Visible','off');
    set(cursorPb,'Visible','off');
    
    set(vhndl_viviani,'XData',x_viviani(1:i),...
                      'YData',y_viviani(1:i),...
                      'ZData',z_viviani(1:i));
  
    cursorPb = mArrow3([0;0;0],[x_viviani(i);y_viviani(i);z_viviani(i)],...
                       'color','black','stemWidth',0.01/2,...
                       'facealpha',1.00,'LineSmoothing','on');
    
    cursorNb = mArrow3([x_viviani(i);y_viviani(i);z_viviani(i)],...
                   [x_viviani(i);y_viviani(i);z_viviani(i)]+0.4*Nb(:,i),...
                   'color','red','stemWidth',0.01/2,'facealpha',1.00,...
                   'LineSmoothing','on');
                   
    set(posnPb,'Position',[x_viviani(i)+0.05,...
                           y_viviani(i)+0.05,...
                           z_viviani(i)+0.05]);
                       
    set(posnNb,'Position',[x_viviani(i)+0.45*Nb(1,i),...
                           y_viviani(i)+0.45*Nb(2,i),...
                           z_viviani(i)+0.45*Nb(3,i)]);

    set(cursorNb,'Visible','on');
    set(cursorPb,'Visible','on');    
%----------------------------------------------------------------------
    camlight headlight;
    camlight left;
    camlight right;
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
%     close(fig);
end
