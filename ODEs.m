%% AEM 4305 PROJECT 5 - ODEs Generator

function  [xDOT] = ODEs(t,x,const,attitude,torque)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [xDOT] = ODEs(t,x,const) returns xDOT = f(x,t) by specifying the 
% differential equations of the system in first-order form.
%
% INPUT PARAMETERS:
% t = time
% x = system states
% const = a structure that contains all relevant physical parameters
%
% OUTPUT PARAMETERS:
% xDOT = the first-order differential equation evaluated at x and t
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% CONSTANTS:
muE = const.muE;   % m^3/s^2, gravitational constant for Earth
J2 = const.J2;     % J2 pertubation coefficient for Earth
Re = const.Re;     % m, radius of Earth
I = const.I;       % Inertia Matrix for CubeSat
m_Fb = const.m_Fb; % residual magnetic dipole moment vector resolved in Fb

switch attitude
%%%%%%%%%%%%%%%%%%%%%% QUATERNION PARAMETRIZATION CASE %%%%%%%%%%%%%%%%%%%%
    case "Quaternion"
%%% STATE VECTOR:
x1 = x(1:3);   % position vector resolved in Frame a
x2 = x(4:6);   % velocity vector resolved in Frame a
x3 = x(7:10);  % quaternion vectrix
x4 = x(11:13); % angular velocity vector resolved in Frame b
x5 = x(14:17); % estimated quaternion vectrix

%%% DYNAMICS:

% Solve for position derivative using velocity
x1_DOT = x2;

% Solve for velocity derivative using Newton's 2nd Law, where
% acceleration = (gravitational force with J2 / mass of CubeSat)
x2_DOT =   (-1*muE/norm(x1)^3)*x1 ...
         + (3*muE*J2*Re^2/2/norm(x1)^5) ...
         * ( (5/norm(x1)^2)*((x1(3)^2)-1)*x1 - 2*(x1(3))*[0;0;1] );

% Solve for quaternion derivative using Gamma matrix, where
% quaternion rates = (Gamma matrix * angular velocities)
x3_DOT = GammaQuaternion(x3) * x4;

% Solve for angular velocity derivative using Euler's Law for Rotation
C_ba = Quaternion2DCM(x3);  % obtain DCM from quaternion
x1_Fb = C_ba * x1;          % resolve position vector in Frame b
b_Fa = EarthMagField(x1,t); % obtain Earth's magnetic field vector
if torque == "gravity"
    tau_Bc = (3*muE/norm(x1)^5)*crossm(x1_Fb)*I*x1_Fb; % gravitygradient torque
elseif torque == "dipole"
    tau_Bc = crossm(m_Fb) * C_ba * b_Fa; % magnetic dipole torque
elseif torque == "both"
    tau_Bc =   (3*muE/norm(x1)^5)*crossm(x1_Fb)*I*x1_Fb ...
             + crossm(m_Fb) * C_ba * b_Fa; % both torques included
end
x4_DOT =   inv(I) * (-1*crossm(x4)*I*x4 + tau_Bc);

% Solve for quaternion ESTIMATE derivative using kinematics equation
x5_norm = x5 / sqrt(x5'*x5); % normalized the quaternion estimate
x5_DOT = GammaQuaternion(x5_norm) * RateGyroNoisy(x4,t);

%%% STATE VECTOR DERIVATIVE:
xDOT = [x1_DOT; x2_DOT; x3_DOT; x4_DOT; x5_DOT];

%%%%%%%%%%%%%%%%%%%%%%%%%% DCM PARAMETRIZATION CASE %%%%%%%%%%%%%%%%%%%%%%%
    case "DCM"
%%% STATE VECTOR:
x1 = x(1:3);   % position vector resolved in Frame a
x2 = x(4:6);   % velocity vector resolved in Frame a
x3 = x(7:9);   % 1st column of DCM
x4 = x(10:12); % 2nd column of DCM
x5 = x(13:15); % 3rd column of DCM
x6 = x(16:18); % angular velocity vector resolved in Frame b
x7 = x(19:21); % 1st column of estimated DCM
x8 = x(22:24); % 2nd column of estimated DCM
x9 = x(25:27); % 3rd column of estimated DCM

%%% DYNAMICS:

% Solve for position derivative using velocity
x1_DOT = x2;

% Solve for velocity derivative using Newton's 2nd Law, where
% acceleration = (gravitational force with J2 / mass of CubeSat)
x2_DOT =   (-1*muE/norm(x1)^3)*x1 ...
         + (3*muE*J2*Re^2/2/norm(x1)^5) ...
         * ( (5/norm(x1)^2)*((x1(3)^2)-1)*x1 - 2*(x1(3))*[0;0;1] );

% Solve for DCM derivative using Poisson's Equation, where
% DCM derivative = (-1 * cross-product matrix of angular velocity * DCM)
C_ba = reshape([x3;x4;x5],[3,3]);
C_ba_DOT = -1 * crossm(x6) * C_ba;
x3_DOT = C_ba_DOT(:,1);
x4_DOT = C_ba_DOT(:,2);
x5_DOT = C_ba_DOT(:,3);

% Solve for angular velocity derivative using Euler's Law for Rotation
x1_Fb = C_ba * x1;          % obtain position vector in Frame b
b_Fa = EarthMagField(x1,t); % obtain Earth's magnetic field vector
if torque == "gravity"
    tau_Bc = (3*muE/norm(x1)^5)*crossm(x1_Fb)*I*x1_Fb; % gravitygradient 
elseif torque == "dipole"
    tau_Bc = crossm(m_Fb) * C_ba * b_Fa; % magnetic dipole torque
elseif torque == "both"
    tau_Bc =   (3*muE/norm(x1)^5)*crossm(x1_Fb)*I*x1_Fb ...
             + crossm(m_Fb) * C_ba * b_Fa; % both torques included
end
x6_DOT =   inv(I) * (-1*crossm(x6)*I*x6 + tau_Bc);

% Estimate DCM derivative using Poisson's Equation, where
% DCM derivative = (-1 * cross-product matrix of omega measurments * DCM)
C_ba_est = reshape([x7;x8;x9],[3,3]);
omega_est = RateGyroNoisy(x6,t);
C_ba_DOT_est = -1 * crossm(omega_est) * C_ba_est;
x7_DOT = C_ba_DOT_est(:,1);
x8_DOT = C_ba_DOT_est(:,2);
x9_DOT = C_ba_DOT_est(:,3);

%%% STATE VECTOR DERIVATIVE:
xDOT = [x1_DOT; x2_DOT; x3_DOT; x4_DOT; x5_DOT; x6_DOT; x7_DOT; x8_DOT; x9_DOT];

end % end switch




