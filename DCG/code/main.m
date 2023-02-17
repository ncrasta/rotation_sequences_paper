% Program to generate animation for the demonstration of rolling and
% sliding cone 
% Matlab version 8.0.0.783 (R2012b)
% Date : January 03, 2014
% Authors: N Crasta and SP Bhat
% For the explanation refer to the paper "Closed Sequences of Rotations"

addpath("utils")

function [] = main(t_init, t_final, dt, output_filename)
  if nargin < 1 || isempty(t_init)
      t_init = 0.0;
  end
  if nargin < 2 || isempty(t_final)
    t_final = 1.0;
  end
  if nargin < 3 || isempty(dt)
    dt = 1e-3;
  end
  if nargin < 4 || isempty(output_filename)
    output_filename = 'RH_TheoremCombined.mp4';
  end

  fprintf('Time interval   = [%d, %d]\n', t_init, t_final);
  fprintf('Sampling time   = %d\n', dt);
  fprintf('Numbr of points = %d\n', (t_final - t_init)/dt);
  fprintf('Output filename = %s\n', output_filename);
  
 
  % Origin
  O = [0;0;0];

  %% [1] DEFINE THE UNIT VECTORS X = [x1, x2, x3 ] = [e3, e2, e1]
  [x1, x2, x3] = deal([0;0;1], [0;1;0], [1;0;0]);
  X = [x1 x2 x3];
  % Number of Axis/Vertices
  n_vert = size(X,2);

  %% [2] COMPUTE THE ANGLES BY RH THEOREM
  % SET THE DIRECTION - 1 for CCW and 0 for CW
  d = 1;  
  % Phi = [phi1, phi2, phi3 ] = [2*d*pi-2*<x3,x1,x2>, 2*d*pi-2*<x1,x2,x3>, 2*d*pi-2*<x2,x3,x1> ]
  [phi1, phi2, phi3] = deal(2*d*pi-2*atan2(dot(x2,cross(x1,x3)),dot(cross(x1,x2),cross(x1,x3))),...
                            2*d*pi-2*atan2(dot(x3,cross(x2,x1)),dot(cross(x2,x1),cross(x2,x3))),...
                            2*d*pi-2*atan2(dot(x1,cross(x3,x2)),dot(cross(x3,x1),cross(x3,x2))));
  Phi = [phi1 phi2 phi3];

  %% [3] DEFINE THE FIXED CONE W = [w1, w2, w3] = [ x1, R(phi1, x1)*x2, x3]
  [w1, w2, w3] = deal(x1, rotate_vector(phi1, x1, x2), x3);
  W = [w1 w2 w3];

  %% [4] DEFINE THE MOVING POLAR CONE Y = [y1, y2, y3] = [ (x1 x x2)/|x1 x x2|, (x2 x x3)/|x2 x x3|, (x3 x x1)/|x3 x x1| ]
  [y1, y2, y3] = deal(cross(x1,x2)/norm(cross(x1,x2)),...
                      cross(x2,x3)/norm(cross(x2,x3)),...
                      cross(x3,x1)/norm(cross(x3,x1)));
  Y = [y1 y2 y3];

  %% [5] DEFINE THE  FIXED POLAR CONE Z = [z1, z2, z3] = [(w1 x w2)/|w1 x w2|, (w2 x w3)/|w2 x w3|, (w3 x w1)/|w3 x w1| ]
  [z1, z2, z3] = deal(cross(w1,w2)/norm(cross(w1,w2)),...
                      cross(w2,w3)/norm(cross(w2,w3)),...
                      cross(w3,w1)/norm(cross(w3,w1)));
  Z = [z1 z2 z3];

  %%
  [a1, a2, a3] = deal(x1, x2, x3);
  [p1, p2, p3] = deal(y1, y2, y3);

  % [b1, b2, b3] = [ R(phi1, a1)*a1, R(phi1, a1)*a2, R(phi1, a1)*a3 ]  
  [b1, b2, b3] = deal(rotate_vector(phi1, a1, a1),...
                      rotate_vector(phi1, a1, a2),...
                      rotate_vector(phi1, a1, a3));
  
  % [q1, q2, q3] = [ R(phi1, a1)*p1, R(phi1, a1)*p2, R(phi1, a1)*p3 ]
  [q1, q2, q3] = deal(rotate_vector(phi1, a1, p1),...
                      rotate_vector(phi1, a1, p2),...
                      rotate_vector(phi1, a1, p3));
  
  % [c1, c2, c3] = [ R(phi2, b2)*b1, R(phi2, b2)*b2, R(phi2, b2)*b3 ]
  [c1, c2, c3] = deal(rotate_vector(phi2, b2, b1),...
                      rotate_vector(phi2, b2, b2),...
                      rotate_vector(phi2, b2, b3));
  
  % [r1, r2, r3] = [ R(phi2, b2)*q1, R(phi2, b2)*q2, R(phi2, b2)*q3 ]
  [r1, r2, r3] = deal(rotate_vector(phi2, b2, q1),...
                      rotate_vector(phi2, b2, q2),...
                      rotate_vector(phi2, b2, q3));
  
  Rot_Axes = [a1 b2 c3];
  
  % MC: Moving Cone
  vertMC(:,:,1) = [a1 a2 a3];
  vertMC(:,:,2) = [b1 b2 b3];
  vertMC(:,:,3) = [c1 c2 c3];
  
  % MPC: Moving Polar Cone
  vertMPC(:,:,1) = [p1 p2 p3];
  vertMPC(:,:,2) = [q1 q2 q3];
  vertMPC(:,:,3) = [r1 r2 r3];

  %% [6] TIME DATA ( ADJUST THE STEP SIZE FOR CONTROLLING THE SPEED ) 
  t = t_init:dt:t_final;
  n_time = length(t);

  %% [7] DATA GENERATION AND SAVING TO THE FILE
  data_generation(t, n_vert, Rot_Axes, Phi, vertMC, vertMPC, W, Z);

  %% [8] ANIMATION
  animation_rh(output_filename);
end