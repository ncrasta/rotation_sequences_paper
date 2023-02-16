%%=======================================================================%%
% ANIMATION OF VIVIANIS CURVE USING THE NORMAL PARAMETRIZATION
% Authos: Dr. S. P. Bhat and Naveen
% MATLAB verison: 2014a
% External files needed: mArrow3
% Last modified: December 24, 2014 
% For the explanation refer to the paper "Closed Attitude Trajectories"
%%=======================================================================%%
function n = nu(t)
a = 0.5;
n = a*(1/su(t))*[-sin(t/2)^3;...
                    cos(t/2)*(2-cos(t/2)^2);...
                   -cos(t/2)^2];
