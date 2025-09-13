%% AEM 4305 Project 2 Question 2
% Created by James Richard Forbes
% Edited by Ryan James Caverly and Shreyans Kinattumkara
% March 2021

% This is a piece of sample code written for AEM 4305. 
% The purpose of this code is to show students how to use matlab to 
% numerically integrate DEs, and how to write clean code. This code is not
% ``perfect'' in that I have my own personal style, but it is clean,
% reasonably commented, and overall neat and tidy. 
%
% We will simulate a pendulum whose differential equations of motion
% derived in class. Try simulating with different initial conditions to see
% where the pendulum settles. If the damping is set to zero, then all
% forces acting on the particle are conservative and energy should remain
% constant.

clear all
clc
close all
format long

%profile on; % Try uncommenting this ``profile off;'' code at the bottom.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constants:
const_struct_proj2 % All constants in one file.

mS = const.mS; % kg, mass of IceCube satellite
muE = const.muE; % m^3/s^2, gravitational constant for Earth
J2 = const.J2; % J2 pertubation coefficient for Earth
Re = const.Re; % m, radius of Earth
r = const.r; % m, orbit radius from center of Earth (LEO)
i = const.i; % rad, orbit inclination
g = const.g; % m/s^2, gravitational acceleration constant for Earth
IC = const.IC0; % initial conditions (R and V) initialization for integration
e = const.e; % eccentricity of LEO
a = const.a; % semimajor axis for circular LEO
w = const.w; % argument of perigee for circular LEO
RA = const.RA; % right ascension for circular LEO
tp = const.tp; % perigee time for generating R and V initial conditions
ti = const.ti; % R and V will be found at ti=92.5min

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial conditions:
[IC(1:3), IC(4:6)] = findRandV(muE,e,i,a,w,RA,tp,ti);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulation time:
t0 = 0; % s
t_max = ti; % s
t_div = 10001; % number of steps to divide the time series into.
t_span = linspace(t0,t_max,t_div); % Total simulation time.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulation options:
 options = odeset('AbsTol',1e-9,'RelTol',1e-9); % This changes the integration tolerence.
%options = [];

tic
% Use any solver; I use these three the most. 
[t,x_out] = ode45(@ODEs_proj2,t_span,IC,options,const);
%[t,x_out] = ode15s(@ODEs,t_span,IC,options,output_flag,dummy_matrix,t_span,waitbar_handle,const);
%[t,x_out] = ode113(@ODEs,t_span,IC,options,output_flag,dummy_matrix,t_span,waitbar_handle,const);

time_stamp = toc

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Post Processing:
post_processing_v2_proj2

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot data:
plot_script_v2_proj2

EarthPlot(x_out(:,1),x_out(:,2),x_out(:,3),Re)
%profile off;
%profview;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save all the data: (You never know when you'll need it again.)
save sim_data_v1