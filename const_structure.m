%% Constants File - For all questions answered

const.mB = 4.5;              % [kg], mass of CubeSat model B
const.muE = 3.986e14;        % [m^3/s^2], gravitational constant for Earth
const.J2 = 1.08262645e-3;    % J2 pertubation coefficient for Earth
const.Re = 6.3712e6;         % [m], radius of Earth
const.r = const.Re + 400000; % [m], LEO radius (400km altitude)
const.e = 0;                 % eccentricity of LEO
const.i = 64*pi/180;         % [rad], orbit inclination
const.a = const.r;           % [m], semimajor axis for circular LEO
const.w = 0;                 % [rad], argument of perigee for circular LEO
const.RA = 0;                % [rad], right ascension for circular LEO
const.tp = 0;                % [s] perigee time for generating R and V
const.ti = 92.5*60;          % [s] R and V will be found at ti=92.5min
const.g = 9.81;              % [m/s^2], gravitational acceleration constant

% Dimensions of 3U CubeSat (width,depth,length), in [m]:
const.wi = 0.10; 
const.de = 0.10;
const.le = 0.34;
% Density, assuming uniform mass distribution, in [kg/m^3]:
const.sigma = const.mB / (const.wi^2 * const.le);
% Inertia Matrix, about the center of mass, in [kg*m^2]:
const.I = const.sigma * ...
        [((1/12)*const.wi^4*const.le + (1/12)*const.wi^2*const.le^3), 0, 0;
         0, ((1/12)*const.wi^4*const.le + (1/12)*const.wi^2*const.le^3), 0;  
         0, 0, ((1/6)*const.wi^4*const.le)];
     
% Residual Magnetic Dipole Moment Vector induced by CubeSat, in [A*m^2]:  
const.m_Fb = [1;1;0]*10^-4;

% Control Gains:
const.kp = 3.2;
const.kd = 2.4;
const.kh = 1.2;
const.ke = 0.9;

% Reaction wheels inertia:
const.Is = 0.07;
