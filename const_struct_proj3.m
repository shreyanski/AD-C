%% AEM 4305 PROJECT 3 - Constants File

% Mass of satellite model B, in [kg]:
const.mB = 4.5;
% Dimensions of 3U CubeSat, in [m]:
const.w = 0.1;
const.l = 0.34;
% Density, assuming uniform mass distribution, in [kg/m^3]:
const.sigma = const.mB / (const.w^2 * const.l);
% Inertia Matrix, about the center of mass, in [kg*m^2]:
const.I = const.sigma * [((1/12)*const.w^4*const.l + (1/12)*const.w^2*const.l^3), 0, 0;
                         0, ((1/12)*const.w^4*const.l + (1/12)*const.w^2*const.l^3), 0;  
                         0, 0, ((1/6)*const.w^4*const.l)];
                     
