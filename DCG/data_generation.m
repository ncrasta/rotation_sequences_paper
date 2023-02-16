% Program to generate animation for the demonstration of rolling and
% sliding cone 
% Matlab version 8.0.0.783 (R2012b)
% Date : January 03, 2014
% Authors: N Crasta and SP Bhat
% For the explanation refer to the paper "Closed Sequences of Rotations"

%% ******PART 1) - DATA GENERATION****
%********************************************

function [] = data_generation(a1,a2,a3,a4,a5,a6,a7,a8)
% data_generation(t,n_vert,Rot_Axis,Phi,vertMC,vertMPC)
t = a1; 
n_vert = a2;
Rot_Axis = a3;
Phi = a4;
vertMC = a5;
vertMPC = a6;
W = a7;
Z = a8;
n_time = length(t);
% ALLOCATE MEMORY FOR STORING THE COORDINATES OF THE VERTICES OF THE MOVING
% AND POLAR CONES IN A 3 DIMENSIONAL ARRAY
MovignCone_Posn = zeros(3,n_vert,n_vert*n_time);       % Moving Cone Position data
FixedCone_Posn = zeros(3,n_vert,n_vert*n_time);        % Fixed Cone Position data
PolarMovignCone_Posn = zeros(3,n_vert,n_vert*n_time);  % Polar Moving Cone Position data
PolarFixedCone_Posn = zeros(3,n_vert,n_vert*n_time);   % Polar Fixed Cone Position data
%% DEFINE THE FILENAMES TO WRITE THE DATA
filename1 = 'MovingCone_Data.mat';
filename2 = 'FixedCone_Data.mat';
filename3 = 'PolarMovingCone_Data.mat';
filename4 = 'PolarFixedCone_Data.mat';
ind = 1;
for i_vert = 1:n_vert
    u = Rot_Axis(:,i_vert);
    theta = Phi(i_vert);
    ux = [0 -u(3) u(2);u(3) 0 -u(1);-u(2) u(1) 0];
    if i_vert  == 1
        delta1 = 0.0; delta2 = 0.0;
    elseif i_vert == 2
        delta1 = 0.0; delta2 = 0.006;
    else
        delta1 = 0.00; delta2 = 0.004;
    end
    for i_time = 1:1:n_time
        MovingCone_Posn(:,:,ind) = (eye(3) + sin(Phi(i_vert)*t(i_time))*ux + (1-cos(Phi(i_vert)*t(i_time)))*(ux)^2)* vertMC(:,:,i_vert) + 1*delta1;
        FixedCone_Posn(:,:,ind) = W;
        PolarMovingCone_Posn(:,:,ind) = (eye(3) + sin(Phi(i_vert)*t(i_time))*ux + (1-cos(Phi(i_vert)*t(i_time)))*(ux)^2)* vertMPC(:,:,i_vert)+1*(-1)^i_vert*delta2;
        PolarFixedCone_Posn(:,:,ind) = Z;
        ind = ind+1;
     end
end
%% WRITE THE DATA TO THE FILE
save('FixedConeData.mat','FixedCone_Posn');
save('PolarFixedConeData.mat','PolarFixedCone_Posn');
save('MovingConeData.mat','MovingCone_Posn');
save('PolarMovingConeData.mat','PolarMovingCone_Posn');
