%%=======================================================================%%
% ANIMATION OF VIVIANIS CURVE USING THE NORMAL PARAMETRIZATION
% Authos: Dr. S. P. Bhat and Naveen
% MATLAB verison: 2014a
% External files needed: mArrow3
% Last modified: December 24, 2014 
% For the explanation refer to the paper "Closed Attitude Trajectories"
%%=======================================================================%%
function p = pu(t)
a= 0.5;
p = a*[1 + cos(t);...
       sin(t);....
       2*sin(t/2)];
