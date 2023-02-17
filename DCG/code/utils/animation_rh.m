% Program to generate animation for the demonstration of rolling and
% sliding cone 
% Matlab version 8.0.0.783 (R2012b)
% Date : January 03, 2014
% Authors: N Crasta and SP Bhat
% For the explanation refer to the paper "Closed Sequences of Rotations"

%% ****** PART 2) - ANIMATION ****
%************************************
addpath("utils", "data", "output")

function [] = animation_rh(output_filename)
  if nargin < 1 || isempty(output_filename)
      output_filename = 'RH_TheoremCombined.mp4';
  end
  % Origin
  O = [0;0;0];

  %% Load the data from files
  load data/FixedConeData.mat
  load data/PolarFixedConeData.mat
  load data/MovingConeData.mat
  load data/PolarMovingConeData.mat

  fig = figure(1);  % create a new figure window
  set(gcf, 'color', rgb('Ivory'));  % SET THE BACKGROUND COLOR OF THE FIGURE
  set(gca, 'color', rgb('Gray'));           % SET COLOR FOR THE AXIS
  set(gcf,'Renderer','opengl');    % SELECT A RENDERING MODE **IMPORTANT***
  %opengl('software');%
  set(fig,'units','normalized','outerposition',[0 0 1 1]);
  set(fig,'Position',[0  0   1   1]);  % SET THE POSITION OF THE FIGURE
  xlabel('x','FontSize',20);
  ylabel('y','FontSize',20);
  zlabel('z','FontSize',20);
  set(gca,'FontSize',20);
  axis vis3d equal;
  vid = 1;
  if(vid == 1)
    animation = VideoWriter('output/RH_TheoremCombined.mp4', 'MPEG-4');
    open(animation);
  end
  Index_Patch = [1,2,3;1,2,4;1,3,4];    % FACES OF THE CONE TO FILL
  flag =0 ; vert_index = 1;
  for kk = 2:2:n_vert*n_time-1
      figure(1); clf(1);
      plot3(0,0,0,'o','LineWidth',2,'MarkerEdgeColor','k','MarkerSize',5,'LineSmoothing','on');
      hold on;
      cycle_axis1 = 1:1:n_vert;
      flag =flag +1;
          for si = 1:n_vert
                   if ((si-1)*n_time+ 1 < kk) &&  (kk < (si*n_time) + 2)
                              ind_seg = si;
                   else
                              vert_index = vert_index+ 1;
                   end
          end
       for nn = 1:size(Index_Patch,1)
          face = Index_Patch(nn,:);
          % MOVING CONE (MC) - X
          MCx1 = MovingCone_Posn(:,face(2)-1,kk);
          MCx2 = MovingCone_Posn(:,face(3)-1,kk);
          MCx   = [0.00 MCx1(1);0.00 MCx2(1)]; 
          MCy   = [0.00 MCx1(2);0.00 MCx2(2)]; 
          MCz   = [0.00 MCx1(3);0.00 MCx2(3)];
          %  FIXED POLAR CONE (FPC) - Z
          FPCz1= PolarFixedCone_Posn(:,face(2)-1,kk);
          FPCz2= PolarFixedCone_Posn(:,face(3)-1,kk);
          FPCx = [0.001 FPCz1(1);0.001 FPCz2(1)];
          FPCy = [0.001 FPCz1(2);0.001 FPCz2(2)];
          FPCz = [0.001 FPCz1(3);0.001 FPCz2(3)];
          % MOVING POLAR CONE (MPC) - Y
          MPCy1= PolarMovingCone_Posn(:,face(2)-1,kk);
          MPCy2= PolarMovingCone_Posn(:,face(3)-1,kk);
          MPCx = [0.00  MPCy1(1);0.00  MPCy2(1)]; 
          MPCy = [0.00  MPCy1(2);0.00  MPCy2(2)]; 
          MPCz = [0.00 MPCy1(3);0.00 MPCy2(3)];
          % FIXED POLAR CONE (Z)
          FixedPolarCone = surf(FPCx, FPCy, FPCz);
          %[0.5, 0.4, 0.3]
          set(FixedPolarCone,'FaceAlpha',1.0,'EdgeColor','none',...
              'FaceLighting','phong','FaceColor',rgb('SandyBrown'),...
              'AmbientStrength',0.8,'DiffuseStrength',.8,...
              'SpecularStrength',0.9,'SpecularExponent',25,...
              'BackFaceLighting','unlit','AlphaDataMapping','scaled',...
              'MarkerSize',1,'LineSmoothing','on');
          mArrow3(O,1.00*w1,'color','red','stemWidth',0.01/2,'facealpha',1.00,'LineSmoothing','on');
          mArrow3(O,1.00*w2,'color','red','stemWidth',0.01/2,'facealpha',1.00,'LineSmoothing','on');
          mArrow3(O,1.00*w3,'color','red','stemWidth',0.01/2,'facealpha',1.00,'LineSmoothing','on');
          % DRAW THE EXTENDED LINE 
          tt = 1:0.1:1.75; 
          wxw =w1*tt; 
          lline=plot3(wxw(1,:),wxw(2,:),wxw(3,:),'--r'); 
          set(lline,'LineWidth',1,'LineSmoothing','on');
          text('Interpreter','latex','String','$\mathbf{w}_{1}=\mathbf{z}_{2}$','Position',1.66*w1-0.125*w2,'FontSize',20);
          text('Interpreter','latex','String','$\mathbf{w}_{2}=\mathbf{z}_{3}$','Position',1.1*w2+0.01*w3,'FontSize',20);
          text('Interpreter','latex','String','$\mathbf{w}_{3}=\mathbf{z}_{1}$','Position',1.1*w3-0.02*w1,'FontSize',20);
          %  MOVING CONE (X)
          MovingCone = surf(MCx, MCy, MCz);
          set(MovingCone,'FaceAlpha',1.0, 'EdgeColor','none',...
              'FaceLighting','phong','FaceColor',rgb('DodgerBlue'),...
               'AmbientStrength',0.8,'DiffuseStrength',.8,...
               'SpecularStrength',.9,'SpecularExponent',25,...
              'BackFaceLighting','unlit','AlphaDataMapping','direct',...
              'MarkerSize',1,'LineSmoothing','on');
          % MOVING POLAR CONE (Z)
          MovingPolarCone = surf(MPCx, MPCy, MPCz);
          set(MovingPolarCone,'FaceAlpha',1,'EdgeColor','none',...
              'FaceLighting','phong','FaceColor',[0.6 0.2 0.6],...
              'AmbientStrength',0.8,'DiffuseStrength',.8,...
              'SpecularStrength',.9,'SpecularExponent',25,...
              'BackFaceLighting','unlit','AlphaDataMapping','scaled',...
              'MarkerSize',1,'LineSmoothing','on');
          % CAMERA SETTING
          light('Position',w1,'Style','local');
          light('Position',w2,'Style','local');
          light('Position',w3,'Style','infinite');
          light('Position',-w3,'Style','infinite');
          camlight headlight;
          camlight left;
          camlight right;
         xx1   = [MovingCone_Posn(:,1,kk) MovingCone_Posn(:,2,kk) MovingCone_Posn(:,3,kk)];
         yy1   = [PolarMovingCone_Posn(:,1,kk) PolarMovingCone_Posn(:,2,kk) PolarMovingCone_Posn(:,3,kk)];
         a1 = sprintf('$$x_%d$$',1);
         ab1 = text(1.03*xx1(1,1),1.03*xx1(2,1),1.03*xx1(3,1),'$\mathbf{x}_{1}$');
         set(ab1,'interpreter','latex');set(ab1,'FontSize',18);
         set(ab1,'EraseMode', 'normal');
                 if  ind_seg == 3 && (2*n_time + 63 < kk &&  kk < 2*n_time +186)
                          set(ab1, 'visible','off');
                  else
                       set(ab1, 'visible','on');
                 end
         a2 = sprintf('$$x_%d$$',2);
         ab2 = text(1.03*xx1(1,2),1.03*xx1(2,2),1.03*xx1(3,2),'$\mathbf{x}_{2}$');
         set(ab2,'interpreter','latex');set(ab2,'FontSize',18);
         set(ab2,'EraseMode', 'normal');
                  if  ind_seg == 3 && ( 2*n_time+ 443 < kk &&  kk < 3*n_time -435)
                          set(ab2, 'visible','off');
                  else
                       set(ab2, 'visible','on');
                 end
         a3 = sprintf('$$x_%d$$',3);
         ab3 = text(1.03*xx1(1,3),1.03*xx1(2,3),1.03*xx1(3,3),'$\mathbf{x}_{3}$');
         set(ab3,'interpreter','latex');set(ab3,'FontSize',18);
         set(ab3,'EraseMode', 'normal');
                  if  ind_seg == 2 && ( 1*n_time+ 460 < kk &&  kk < 2*n_time )
                          set(ab3, 'visible','off');
                  else
                       set(ab3, 'visible','on');
                  end
         b1 = sprintf('$$y_%d$$',1);
         ba1 = text(1.03*yy1(1,1),1.03*yy1(2,1),1.03*yy1(3,1),'$\mathbf{y}_{1}$');
         set(ba1,'interpreter','latex');set(ba1,'FontSize',18);
         set(ba1,'EraseMode', 'normal');
                 if  ind_seg == 3 && ( 2*n_time+ 1 < kk &&  kk < 3*n_time - 8 )
                          set(ba1, 'visible','on');
                  else
                       set(ba1, 'visible','on');
                 end
         b2 = sprintf('$$y_%d$$',2);
         ba2 = text(1.05*yy1(1,2),1.05*yy1(2,2),1.05*yy1(3,2),'$\mathbf{y}_{2}$');
         set(ba2,'interpreter','latex');set(ba2,'FontSize',18);
         set(ba2,'EraseMode', 'normal');
                  if  ind_seg == 1 &&  ((0*n_time < kk &&  kk <= 120 ) || (602 < kk &&  kk <= 1*n_time + 1))
                          set(ba2, 'visible','off');
                  elseif ind_seg == 2 &&  ((1*n_time-1 <= kk &&  kk <= 2*n_time-505))
                         set(ba2, 'visible','off');
                  elseif ind_seg == 3 &&  ((3*n_time-50 <= kk &&  kk <= 3*n_time))
                         set(ba2, 'visible','off');
                  else
                      set(ba2, 'visible','on');
                 end
         b3 = sprintf('$$y_%d$$',3);
         ba3 = text(1.03*yy1(1,3),1.03*yy1(2,3),1.03*yy1(3,3),'$\mathbf{y}_{3}$');
         set(ba3,'interpreter','latex');set(ba3,'FontSize',18);
         set(ba3,'EraseMode', 'normal');
                  if  ind_seg == 2 && ( 1*n_time+ 5 < kk &&  kk < 2*n_time )
                          set(ba3, 'visible','on');
                  else
                       set(ba3, 'visible','on');
                  end
         Fa1=w1+(w2-w1)/4+(w3-w1)/4;
         L1 = text(Fa1(1),Fa1(2),Fa1(3),'$\mathcal{F} = \mathcal{F}_{\rm P}$');
         set(L1,'interpreter','latex');set(L1,'FontSize',18,'Rotation',1);
         set(L1,'EraseMode', 'normal');
         Fa2= 1*(xx1(:,1)+xx1(:,2)+xx1(:,3))/3;
         L2 = text(Fa2(1),Fa2(2),Fa2(3),'$\bf \mathcal{M}$');
         set(L2,'interpreter','latex');set(L2,'FontSize',18);
         if ind_seg == 2 && ( 1*n_time+450  < kk &&  kk <=2*n_time + 1)
                   set(L2, 'visible','off');
         elseif ind_seg == 3 && (2*n_time-1  < kk &&  kk <= 3*n_time-45)
             set(L2, 'visible','off');
         else
                 set(L2, 'visible','on'); set(L2,'Rotation',0);
         end
          set(L2,'EraseMode', 'normal');
         Fa3= 1*(yy1(:,1)+yy1(:,2)+yy1(:,3))/3;
         L3 = text(Fa3(1),Fa3(2),Fa3(3),'$\bf \mathcal{M}_{\rm P}$');
         set(L3,'interpreter','latex');set(L3,'FontSize',18);
         set(L3,'EraseMode', 'normal');
         if  ind_seg == 1 && ( 0*n_time  < kk &&  kk <= 1*n_time+1)
                          set(L3, 'visible','off');
         elseif ind_seg == 2 && ( 1*n_time-1  < kk &&  kk <= 1*n_time + 465)
                    set(L3, 'visible','off');
         elseif ind_seg == 3 && ( 3*n_time-60  < kk &&  kk <= 3*n_time)
                    set(L3, 'visible','off');
         else
             set(L3, 'visible','on');
        end
      end
      handleLeg = legend([FixedPolarCone,MovingCone,MovingPolarCone],...
          '\textrm{\hspace{0.05in}Stationary cone $\mathcal{F}$ and its polar cone $\mathcal{F}_{\rm P}$}',...
          '\textrm{\hspace{0.01in} Moving cone $\mathcal{M},$ rolls on $\mathcal{F}$}',...
          '\textrm{\hspace{0.01in} Moving polar cone $\mathcal{M}_{\rm P},$ slides on $\mathcal{F}_{\rm P}$}');
      set(handleLeg,'interpreter','latex');
      set(handleLeg, 'Box', 'off');
      set(handleLeg,'fontsize',18,'fontweight','b');
      set(gcf,'Units','normalized');
      set(handleLeg,'Position',[0.7 0.85 0.3 0.01]);
      set(handleLeg,'location','NorthEastOutside');

      grid off;
      axis([-1 1 -1 1 -1 1]);
      axis off;
      cycle_axis = cycle_axis1(cycle_axis1~=ind_seg);
      handleTitle = title('\textrm{\hspace{2in} \bf Visualization of a closed sequence of three rotations using rolling and sliding motions of cones}');
      text('Interpreter','latex','String','\textrm{Supplementary material to the article  ``Closed Rotation Sequences"  Discrete and Computational Geometry by}','Position',[-0.0,-0.0,-2.10] ,'FontSize',12);
      text('Interpreter','latex','String','\textrm{Sanjay P. Bhat and N. Crasta}','Position',[-0.0,0.0,-2.20] ,'FontSize',12);
      set(handleTitle,'interpreter','latex');
      set(handleTitle,'Position',[0.0,0.0,-2.00]);
      set(handleTitle,'FontSize',20);
      % Animation Loop
      camzoom(1.7);
      view(-72,58); %  FIXED VIEW (-72,58)

      if(vid==1)
          drawnow;
          currFrame = getframe(fig);
          writeVideo(animation, currFrame);
      else
          pause(0.0);
          drawnow;
      end
   end
  if(vid==1)
      close(animation);
  end
end