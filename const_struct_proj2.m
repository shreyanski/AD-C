% Constants file.

const.mS = 4;                % kg, mass of IceCube satellite
const.muE = 3.986e14;        % m^3/s^2, gravitational constant for Earth
const.J2 = 1.08262645e-3;    % J2 pertubation coefficient for Earth
const.Re = 6.3712e6;         % m, radius of Earth
const.r = const.Re + 400000; % m, LEO radius 
const.IC0 = zeros(1,6);      % initial conditions (R and V) initialization for integration
const.e = 0;                 % eccentricity of LEO
const.i = 64*pi/180;         % rad, orbit inclination
const.a = const.r;           % semimajor axis for circular LEO
const.w = 0;                 % argument of perigee for circular LEO
const.RA = 0;                % right ascension for circular LEO
const.tp = 0;                % perigee time for generating R and V initial conditions
const.ti = 92.5*60;          % R and V will be found at ti=92.5min
const.g = 9.81;              % m/s^2, gravitational acceleration constant for Earth
