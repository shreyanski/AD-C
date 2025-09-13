%% Main Script - Question 2 Numerical Simulation of PD Attitude Control - Equation (1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE:
% Given known quantities describing the spacecraft and its orbit around 
% Earth, RK45 numerical integration is used to determine its orbital 
% mechanics and attitude in response to specified initial conditions. 
% The simulated responses of position, velocity, angular velocity, total
% energy, both quaternion and (3-2-1) Euler angle attitudes are plotted 
% over one orbital period.
%
% - "const_struct.m" obtains the satellite's dimensions, mass and 
%    rotational inertia.
%
% - "post_processing.m" obtains the values of the state vector x over the
%    time spanned during RK45 simulation.
%    x = [ position             (3x1); 
%          velocity             (3x1); 
%          quaternion           (4x1); 
%          angular velocity     (3x1);
%          estimated quaternion (4x1) ];
%
% - "plot_script.m" obtains plots for state vector's response over time, as
%    well as the behavior of Euler angles and total energy.  

% Necessary functions (m-files) in MATLAB path are:
% findRandV
% Quaternion2DCM
% EarthPlot
% AttitudeAnimEst
% GammaQuaternion
% EarthMagField
% crossm
% uncrossm
% RateGyroNoisy
% DCM2Euler321
% EarthSensorNoisy
% MagnetometerNoisy
% TRIAD
% DCM2Quaternion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all; clc; format long;

%%% CONSTANTS:
global TORQ;
% Set TORQ = "gravity" or "dipole" or "both" for external torque
% applied on spacecraft:
TORQ = "gravity";

const_struct_proj6 
mB = const.mB;   % mass of IceCube satellite (CubeSat)
muE = const.muE; % gravitational constant for Earth
J2 = const.J2;   % J2 pertubation coefficient for Earth
Re = const.Re;   % radius of Earth
r = const.r;     % orbit radius from center of Earth (LEO)
i = const.i;     % orbit inclination
g = const.g;     % gravitational ACCELERATIONAL constant for Earth
e = const.e;     % eccentricity of LEO
a = const.a;     % semimajor axis for circular LEO
w = const.w;     % argument of perigee for circular LEO
RA = const.RA;   % right ascension for circular LEO
tp = const.tp;   % perigee time for generating R and V initial conditions
ti = const.ti;   % R and V will be found at orbital period ti=92.5*60 [s]
wid = const.wi;  % width of CubeSat 
dep = const.wi;  % depth of CubeSat
len = const.le;  % length of CubeSat
I = const.I;     % Inertia matrix of CubeSat

%%% INITIAL CONDITIONS:
[R0, V0] = findRandV(muE,e,i,a,w,RA,tp,ti);  % initial position & velocity
q0 = [1/sqrt(6);                             % initial quaternion
      1/sqrt(6); 
      1/sqrt(6); 
      1/sqrt(2)];
omega0 = [0.08;                              % initial angular velocity
         -0.1; 
          0.3]; 
q_est0 = q0;                                 % initial estimated quaternion      
C_ba0 = Quaternion2DCM(q0);                  % initial attitude (DCM)
C_ba_est0 = C_ba0;                           % initial estimated DCM
% initial conditions state vector:
IC = [R0; V0; q0; omega0; q_est0];            

%%% SIMULATION:
t_start = 0;                                 % simulation start time [s]
t_end = 60;                                  % simulation end time [s]
Ndt = 10001;                                 % number of timesteps
time = linspace(t_start,t_end,Ndt);          % total simulation time [s]
tol = odeset('AbsTol',1e-6,'RelTol',1e-7);   % integration tolerance
tic                                          % start timer 
[t,x_out] = ode45(@ODEs_q2_Equation1,time,IC,tol,const,TORQ);
toc                                          % end timer

%%% POST PROCESSING:
post_processing_q2

%%% PLOTTING:
plot_script_proj6

%%% EARTH PLOT & ATTITUDE ANIMATION:
% EarthPlot(x_out(:,1),x_out(:,2),x_out(:,3),Re)
% AttitudeAnimEst('anim_TRUE',q,q_IN,q_TRIAD,len,wid,dep,time,8);

%%% SAVE DATA:
% save anim_project6