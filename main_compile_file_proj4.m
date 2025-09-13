%% AEM 4305 PROJECT 4 - QUATERNION CASE (with Gravity-Gradient Torque)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PURPOSE:
% Given known quantities describing the spacecraft and its orbit around 
% Earth, RK45 numerical integration is used to determine its orbital 
% mechanics and attitude in response to specified initial conditions. 
% The simulated responses of position, velocity, angular velocity, total
% energy, both quaternion and (3-2-1) Euler angle attitudes are plotted 
% over one orbital period.

% - "const_struct.m" obtains the satellite's dimensions, mass and 
%    rotational inertia.

% - "post_processing.m" obtains the values of the state vector x over the
%    time spanned during RK45 simulation.
%    x = [    position     (3x1); 
%             velocity     (3x1); 
%            quaternion    (4x1); 
%         angular velocity (3x1)   ];

% - "plot_script.m" obtains plots for state vector's response over time, as
%    well as the behavior of Euler angles and total energy.      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; close all; clc; format long;

%%% CONSTANTS:
global attitude torque;
% Set attitude = "Quaternion" or "DCM" for whichever attitude 
% parametrization required:
attitude = "Quaternion";
% Set torque = "gravity" or "dipole" or "both" for which external torque
% applied on spacecraft:
torque = "gravity";


const_struct 
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
switch attitude
    case "Quaternion"
[R0, V0] = findRandV(muE,e,i,a,w,RA,tp,ti);  % initial position & velocity
eps0 = [0; 0; 0];                            % initial attitude (epsilon)
eta0 = 1;                                    % initial attitude (eta)
omega0 = [0; 0; 0];                          % initial angular velocity
IC = [R0; V0; eps0; eta0; omega0];           % initial conditions vector

    case "DCM"
[R0, V0] = findRandV(muE,e,i,a,w,RA,tp,ti);  % initial position & velocity
eps0 = [0; 0; 0];                            % initial attitude (epsilon)
eta0 = 1;                                    % initial attitude (eta)
C_ba0 = Quaternion2DCM( [eps0;eta0] );       % initial attitude (DCM)
omega0 = [0; 0; 0];                          % initial angular velocity
IC = [R0; V0; C_ba0(:,1); C_ba0(:,2); C_ba0(:,3); omega0];
end

%%% SIMULATION:
t_start = 0;                                 % simulation start time [s]
t_end = ti;                                  % simulation end time [s]
Ndt = 10001;                                 % number of timesteps
time = linspace(t_start,t_end,Ndt);          % total simulation time [s]
tol = odeset('AbsTol',1e-9,'RelTol',1e-9);   % integration tolerance
tic                                          % start timer 
[t,x_out] = ode45(@ODEs_proj4,time,IC,tol,const,attitude,torque);
toc                                          % end timer

%%% POST PROCESSING:
post_processing_proj4

%%% PLOTTING:
plot_script_proj4

%%% EARTH PLOT & ATTITUDE ANIMATION:
EarthPlot(x_out(:,1),x_out(:,2),x_out(:,3),Re)
switch attitude
    case "Quaternion"
    q = x_out(:,7:10);
    AttitudeAnim('anim_project4',q,len,wid,dep,time,8)
    
    case "DCM"
    for lv2 = 1:length(t)
        C_baVEC(:,lv2) = x_out(lv2,7:15)';
        C_ba(:,:,lv2) = reshape(C_baVEC(:,lv2),[3,3]);
        q(:,lv2) = DCM2Quaternion(C_ba(:,:,lv2));
    end
    AttitudeAnim('anim_project4',q',len,wid,dep,time,8)
end

%%% SAVE DATA:
% save anim_project4