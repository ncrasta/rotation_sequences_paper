%%=======================================================================%%
% ANIMATION OF VIVIANIS CURVE USING THE NORMAL PARAMETRIZATION
% Authos: Dr. S. P. Bhat and Naveen
% MATLAB verison: 2014a
% For the explanation refer to the paper "Closed Attitude Trajectories"
%%=======================================================================%%

% Derivative of h(t,a)

function Dx3 = Dh(t,a)
Dx3 = -3*pi*t^2/a^3 +3*pi*t/a^2;
