%%=======================================================================%%
% ANIMATION OF VIVIANIS CURVE USING THE NORMAL PARAMETRIZATION
% Authos: Dr. S. P. Bhat and Naveen
% MATLAB verison: 2014a
% External files needed: mArrow3
% Last modified: December 24, 2014 
% For the explanation refer to the paper "Closed Attitude Trajectories"
% NOTE: PLEASE MAXIMIZE THE FIGURE WHEN IT APPEARS
%%=======================================================================%%
function n = nu(t,a)
n = a*(1/su(t,a))*[-sin(t/2)^3;...
                    cos(t/2)*(2-cos(t/2)^2);...
                   -cos(t/2)^2];
