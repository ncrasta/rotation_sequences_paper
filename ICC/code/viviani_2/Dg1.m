%%=======================================================================%%
% ANIMATION OF VIVIANIS CURVE USING THE NORMAL PARAMETRIZATION
% Authos: Dr. S. P. Bhat and Naveen
% MATLAB verison: 2014a
% For the explanation refer to the paper "Closed Attitude Trajectories"
%%=======================================================================%%

% Derivative of g1(t)

function Dx1 = Dg1(t)
Dx1 = -(3/(2*pi^2))*t^2 + (3/pi)*t;
