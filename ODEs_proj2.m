function  [dot_x] = ODEs_proj2(t,x,const);
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

muE = const.muE; % m^3/s^2, gravitational constant for Earth
J2 = const.J2; % J2 pertubation coefficient for Earth
Re = const.Re; % m, radius of Earth
r = const.r; % m, orbit radius from center of Earth (LEO)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dynamics:

% First, extract states in a convenient form. 
X1 = x(1:3);
X2 = x(4:6);

% Form dot_x = f(x,u) system.
dot_X1 = X2;
dot_X2 = (-1*muE/r^3)*X1 + (3*muE*J2*Re^2/2/r^5) * ( (5/r^2)*((X1(3)^2)-1)*X1 - 2*(X1(3))*[0;0;1] );
dot_x = [dot_X1; dot_X2];



