%% ODEs Generator - Question 2 Numerical Simulation of PD Attitude Control - Equation (1)

function  [xDOT] = ODEs_q2_Equation1(t,x,const,TORQ)
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
kp = const.kp;     % proportional control gain
kd = const.kd;     % derivative control gain

%%%%%%%%%%%%%%%%%%%%%% QUATERNION PARAMETRIZATION CASE %%%%%%%%%%%%%%%%%%%%
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
if TORQ == "gravity"
    tau_Bc = (3*muE/norm(x1)^5)*crossm(x1_Fb)*I*x1_Fb; % gravitygradient torque
elseif TORQ == "dipole"
    tau_Bc = crossm(m_Fb) * C_ba * b_Fa; % magnetic dipole torque
elseif TORQ == "both"
    tau_Bc =   (3*muE/norm(x1)^5)*crossm(x1_Fb)*I*x1_Fb ...
             + crossm(m_Fb) * C_ba * b_Fa; % both torques included
end


% Adding control torque:
tau_CTRL = -kp*x3(1:3)-kd*x4; % control torque using Eq(1) in 1(a)

x4_DOT =   inv(I) * (-1*crossm(x4)*I*x4 + tau_Bc + tau_CTRL);

% Solve for quaternion ESTIMATE derivative using kinematics equation
x5_norm = x5 / sqrt(x5'*x5); % normalized the quaternion estimate
x5_DOT = GammaQuaternion(x5_norm) * RateGyroNoisy(x4,t);

%%% STATE VECTOR DERIVATIVE:
xDOT = [x1_DOT; x2_DOT; x3_DOT; x4_DOT; x5_DOT];




