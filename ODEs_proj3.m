%% AEM 4305 PROJECT 3 - ODEs Generator

function  [dot_x] = ODEs_proj3(t,x,const)
%ODES  
% [dot_x] =ODEs(t,x,const) returns x_dot = f(x,t) by
% specifying the differential equations of the system in first-order form.
%
% INPUT PARAMETERS:
% t = time
% x = system states
% const = a structure that contains all relevant physical parameters
%
% OUTPUT PARAMETERS:
% dot_x = the first-order differential equation evaluated at x and t
%
% Created by Ryan Caverly, edited by Shreyans Kinattumkara
% Updated March 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calling Constants:
% Extract constants from const

I = const.I;      % Inertia Matrix for CubeSat
tau = zeros(3,1); % Moment matrix used for simulation

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dynamics:

% First, extract states in a convenient form. 
X1 = x(1:3);
X2 = x(4);
X3 = x(5:7);

% Form dot_x = f(x,u) system.
gam = GammaQuaternion([X1; X2]);
q_dot = gam*X3;
dot_X1 = q_dot(1:3);
dot_X2 = q_dot(4);
dot_X3 = inv(I)*(-1*crossm(X3)*I*X3 + tau);

dot_x = [dot_X1; dot_X2; dot_X3];

% dot_X1 = (1/2)*(X2*eye(3) + crossm(X1))*X3;
% dot_X2 = (1/2)*(-1*X1')*X3;
% dot_X3 = inv(I)*(-1*crossm(X3)*I*X3 + tau);
% dot_x = [dot_X1; dot_X2; dot_X3];





