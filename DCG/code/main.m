%==============================================================================%
% Goal      : Generate animation for the demonstration of rolling/sliding cone %
% Reference : Closed Roation Sequences, DCG, 2015                              % 
% Matlab    : Windows R2012b (last tested)                                     %
% Date      : January 03, 2014                                                 %
% Authors   : SP Bhat and N Crasta                                             %
% Need      : rgb.m and mArrow3.m                                              %
%==============================================================================%
addpath("utils")

function [] = main(t_init, t_final, dt, direction, output_filename)
    if nargin < 1 || isempty(t_init)
        t_init = 0.0;
    end
    if nargin < 2 || isempty(t_final)
        t_final = 1.0;
    end
    if nargin < 3 || isempty(dt)
        dt = 1e-3;
    end  
    if nargin < 4 || isempty(direction)
        direction = 'counter-clockwise';
    end
    if nargin < 5 || isempty(output_filename)
        output_filename = 'RH_TheoremCombined.mp4';
    end
    if direction == "counter-clockwise"
        d = 1;  % CCW
    else
        d = 0;  % CW
    end

    fprintf('Running with the following parameters:\n');
    fprintf('----------------------------------------\n');
    fprintf('Time interval   = [%d, %d]\n', t_init, t_final);
    fprintf('Sampling time   = %d\n', dt);
    fprintf('Numbr of points = %d\n', (t_final - t_init)/dt);
    fprintf('Direction       = %s\n', direction);
    fprintf('Output filename = %s\n', output_filename);
    fprintf('----------------------------------------\n');

    % Origin
    O = [0;0;0];

    %% DEFINE THE UNIT VECTORS X = [x1  x2  x3 ] = [e3  e2  e1]
    [x1, x2, x3] = deal([0;0;1], [0;1;0], [1;0;0]);
    X = [x1 x2 x3];
    % Number of Axis/Vertices
    NumVertices = size(X,2);

    %% COMPUTE THE ANGLES BY RH THEOREM. SEE THE REFERENCE FOR <.,.,.> NOTATION
    % Phi = [phi1, phi2, phi3 ] = [2*d*pi-2*<x3,x1,x2>, 2*d*pi-2*<x1,x2,x3>, 2*d*pi-2*<x2,x3,x1> ]
    [phi1, phi2, phi3] = deal(2*d*pi-2*atan2(dot(x2,cross(x1,x3)),dot(cross(x1,x2),cross(x1,x3))),...
                            2*d*pi-2*atan2(dot(x3,cross(x2,x1)),dot(cross(x2,x1),cross(x2,x3))),...
                            2*d*pi-2*atan2(dot(x1,cross(x3,x2)),dot(cross(x3,x1),cross(x3,x2))));
    Phi = [phi1 phi2 phi3];

    %% DEFINE THE FIXED CONE W = [w1  w2  w3] = [ x1  R(phi1, x1)*x2  x3]
    [w1, w2, w3] = deal(x1, rotate_vector(phi1, x1, x2), x3);
    W = [w1 w2 w3];

    %% DEFINE THE MOVING POLAR CONE Y = [y1  y2  y3] = [ (x1 x x2)/|x1 x x2|  (x2 x x3)/|x2 x x3|  (x3 x x1)/|x3 x x1| ]
    [y1, y2, y3] = deal(cross(x1,x2)/norm(cross(x1,x2)),...
                      cross(x2,x3)/norm(cross(x2,x3)),...
                      cross(x3,x1)/norm(cross(x3,x1)));
    Y = [y1 y2 y3];

    %% DEFINE THE FIXED POLAR CONE Z = [z1  z2  z3] = [(w1 x w2)/|w1 x w2|  (w2 x w3)/|w2 x w3|  (w3 x w1)/|w3 x w1| ]
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
  
    RotationAxes = [a1 b2 c3];
  
    % MC: Moving Cone
    VerticesMovingCone(:,:,1) = [a1 a2 a3];
    VerticesMovingCone(:,:,2) = [b1 b2 b3];
    VerticesMovingCone(:,:,3) = [c1 c2 c3];
  
    % MPC: Moving Polar Cone
    VerticesMovingPolarCone(:,:,1) = [p1 p2 p3];
    VerticesMovingPolarCone(:,:,2) = [q1 q2 q3];
    VerticesMovingPolarCone(:,:,3) = [r1 r2 r3];

    %% TIME DATA ( ADJUST THE STEP SIZE FOR CONTROLLING THE SPEED ) 
    t = t_init:dt:t_final;
    n_time = length(t);

    %% DATA GENERATION AND SAVING TO THE FILE
    data_generation(t,...
                    NumVertices,...
                    RotationAxes,...
                    Phi,...
                    VerticesMovingCone,...
                    VerticesMovingPolarCone,...
                    W,...
                    Z);

    %% ANIMATION
    animation_rh(output_filename);
end