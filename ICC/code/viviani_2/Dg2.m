%%=======================================================================%%
% ANIMATION OF VIVIANIS CURVE USING THE NORMAL PARAMETRIZATION
% Authos: Dr. S. P. Bhat and Naveen
% MATLAB verison: 2014a
% Last modified: December 24, 2014 
% For the explanation refer to the paper "Closed Attitude Trajectories"
%%=======================================================================%%

% Derivative of g2(t)

function Dx2 = Dg2(t)
Dx2 = -Dg1(4*pi-t);   
