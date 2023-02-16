% Program to generate animation for the demonstration of rolling and
% sliding cone 
% Matlab version 8.0.0.783 (R2012b)
% Date : January 03, 2014
% Authors: N Crasta and SP Bhat
% For the explanation refer to the paper "Closed Sequences of Rotations"

%%
clc;
clear all;
close all;

% Origin
O = [0;0;0];

%% [1] DEFINE THE UNIT VECTORS {x1, x2, x3}
x1 = [0;0;1];
x2 = [0;1;0];
x3 = [1;0;0];
% Store the Vectos in Matrix
X = [x1 x2 x3];
% Number of Axis/Vertices
n_vert = size(X,2);

%% [2] COMPUTE THE ANGLES BY RH THEOREM
phi1 = atan2(dot(x2,cross(x1,x3)),dot(cross(x1,x2),cross(x1,x3)));  % phi1=<x3,x1,x2>
phi2 = atan2(dot(x3,cross(x2,x1)),dot(cross(x2,x1),cross(x2,x3)));  % phi2=<x1,x2,x3>
phi3 = atan2(dot(x1,cross(x3,x2)),dot(cross(x3,x1),cross(x3,x2)));  % phi3=<x2,x3,x1>
%  SET THE DIRECTION
d = 1;  % CCW
% d = 0 % CW
phi1 = 2*d*pi-2*phi1;
phi2 = 2*d*pi-2*phi2;
phi3 = 2*d*pi-2*phi3;
% Store the angles in a vector
Phi = [phi1 phi2 phi3];

%% [3] DEFINE THE FIXED CONE
w1 = x1;                                                                  % w1 = x1;
w2 = x2 + sin(phi1)*cross(x1,x2) + (1-cos(phi1))*cross(x1,cross(x1,x2));  % w2 = R(x1,phi1)*x2;
w3 = x3;                                                                  % w3 =x3;
% Store in a matrix
W = [w1 w2 w3];

%% [4] DEFINE THE MOVING POLAR CONE
y1 = cross(x1,x2)/norm(cross(x1,x2));   % y1 = (x1 x x2)/|| x1 x x2 ||
y2 = cross(x2,x3)/norm(cross(x2,x3));   % y2 = (x2 x x3)/|| x2 x x3 ||
y3 = cross(x3,x1)/norm(cross(x3,x1));   % y3 = (x3 x x1)/|| x3 x x1 ||
% Store in a matrix
Y = [y1 y2 y3];

%% [5] DEFINE THE  FIXED POLAR CONE
z1  = cross(w1,w2)/norm(cross(w1,w2));   % w1 = (w1 x w2)/|| w1 x w2 ||
z2  = cross(w2,w3)/norm(cross(w2,w3));   % w2 = (w2 x w3)/|| w2 x w3 ||
z3  = cross(w3,w1)/norm(cross(w3,w1));   % w3 = (w3 x w1)/|| w3 x w1 ||
Z   = [z1 z2 z3];                        % Store in a matrix

%%
a1 = x1;  a2 = x2;  a3 = x3;
p1 = y1;  p2 = y2;  p3 = y3;
b1 = a1 + sin(phi1)*cross(a1,a1) + (1-cos(phi1))*cross(a1,cross(a1,a1));
b2 = a2 + sin(phi1)*cross(a1,a2) + (1-cos(phi1))*cross(a1,cross(a1,a2));
b3 = a3 + sin(phi1)*cross(a1,a3) + (1-cos(phi1))*cross(a1,cross(a1,a3));
q1 = p1 + sin(phi1)*cross(a1,p1) + (1-cos(phi1))*cross(a1,cross(a1,p1));
q2 = p2 + sin(phi1)*cross(a1,p2) + (1-cos(phi1))*cross(a1,cross(a1,p2));
q3 = p3 + sin(phi1)*cross(a1,p3) + (1-cos(phi1))*cross(a1,cross(a1,p3));
c1 = b1  + sin(phi2)*cross(b2,b1) + (1-cos(phi2))*cross(b2,cross(b2,b1));
c2 = b2 + sin(phi2)*cross(b2,b2) + (1-cos(phi2))*cross(b2,cross(b2,b2));
c3 = b3 + sin(phi2)*cross(b2,b3) + (1-cos(phi2))*cross(b2,cross(b2,b3));
r1 = q1  + sin(phi2)*cross(b2,q1) + (1-cos(phi2))*cross(b2,cross(b2,q1));
r2 = q2 + sin(phi2)*cross(b2,q2) + (1-cos(phi2))*cross(b2,cross(b2,q2));
r3 = q3 + sin(phi2)*cross(b2,q3) + (1-cos(phi2))*cross(b2,cross(b2,q3));
Rot_Axis =  [a1 b2 c3];
% MC: Moving Cone
vertMC(:,:,1)  =  [a1 a2 a3];
vertMC(:,:,2)  =  [b1 b2 b3];
vertMC(:,:,3)  = [c1 c2 c3];
% MPC: Moving Polar Cone
vertMPC(:,:,1) = [p1 p2 p3];
vertMPC(:,:,2) = [q1 q2 q3];
vertMPC(:,:,3) = [r1 r2 r3];

%% [6] TIME DATA ( ADJUST THE STEP SIZE FOR CONTROLLING THE SPEED ) 
t = 0:1e-3:1.00;
n_time = length(t);

%% [7] DATA GENERATION AND SAVING TO THE FILE
data_generation(t,n_vert,Rot_Axis,Phi,vertMC,vertMPC,W,Z);

%% [8] ANIMATION
animation_rh;
