% Program to generate animation for the demonstration of rolling and
% sliding cone 
% Matlab version 8.0.0.783 (R2012b)
% Date : January 03, 2014
% Authors: N Crasta and SP Bhat
% For the explanation refer to the paper "Closed Sequences of Rotations"

function z = rotate_vector(theta, u, v)
  % Rodrigues formula of rotation https://www.wikiwand.com/en/Rodrigues%27_rotation_formula
  % R(theta, u)v = v + sin(theta)(u x v) + (1-cos(theta))(ux (u x v))  
  if isequal(u, v)
    z = v;
  else
    z = v + sin(theta)*cross(u,v) + (1-cos(theta))*cross(u,cross(u,v));    
  end