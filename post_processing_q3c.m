%% Post Processing - Question 3(c) PD Control with Reaction Wheels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Processing simulation data to find gravitational force acting on 
% satellite, total energy of satellite, and attitude of satellite in terms 
% of Euler angles:
% - Force acting on CubeSat is due to Earth's gravity, including J2 
%   pertubation effects (correction for Earth's oblateness)
% - Kinetic energy of CubeSat includes both translational and rotational 
%   energy
% - Potential energy of CubeSat includes the effects of both gravitational 
%   force and gravity-gradient torque
% - Euler angles obtained from quaternion parameters using DCM2Euler321.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for lv1 = 1:length(t)  
switch ATT
%%%%%%%%%%%%%%%%%%%%% QUATERNION PARAMETRIZATION CASE %%%%%%%%%%%%%%%%%%%%%  
    case "Quaternion"
    % Compute Position,Velocity,True Quaternion&DCM for each timestep:
    r_a = x_out(lv1,1:3)';                % position in Frame a   
    r_norm = vecnorm(x_out(lv1,1:3),2,2); % distance in Frame a
    q(lv1,:) = x_out(lv1,7:10);           % quaternion at each timestep
    C_ba = Quaternion2DCM(q(lv1,:)');     % DCM (true)
    r_b = C_ba * r_a;                     % position in Frame b
    v_a = x_out(lv1,4:6);                 % velocity in Frame a
    omega_ba = x_out(lv1,11:13);          % angular velocity
%     % Compute Force due to Earth's gravity (including J2 pertubation):
%     fg(lv1,:) =   (-1*muE*mB/r_norm^3*r_a)...
%                 + (3*muE*mB*J2*Re^2/2/r_norm^5)...
%                 * ( (5/r_norm^2)*(r_a(3)^2-1)*r_a ...
%                      - 2*r_a(3)*[0, 0, 1] );
    % Compute Kinetic Energy (translational&rotational) at each timestep:
    T(lv1) =   (mB/2)*(v_a*v_a')...
             + (1/2)*omega_ba*I*omega_ba';
    % Compute Potential Energy (gravitational forces) at each timestep:  
    Vg(lv1) =    -1*muE*mB/r_norm...
              + (muE*mB*J2*Re^2/r_norm^3)...
              * ( (3/2/r_norm^2)*r_a(3)^2 - 1/2 );
    % Compute Potential Energy (gravity-gradient torque) at each timestep:
    Vgg(lv1) =   (muE/2/r_norm^3)...
               * ( (3/r_norm^2) * r_b' * I ...
                    * r_b - trace(I) );
    % Compute TOTAL ENERGY at each timestep:
    if TORQ == "dipole"
        E(lv1) = T(lv1) + Vg(lv1);
    else
        E(lv1) = T(lv1) + Vg(lv1) + Vgg(lv1);
    end % end if
    % Compute Euler Angles associated with quaternion at each timestep:
    [phi,theta,psi] = DCM2Euler321(C_ba);
    EA(lv1,:) = [phi,theta,psi];
    % Compute (True Norm of Quaternion minus 1) at each timestep:
    N(lv1) = q(lv1,:) * q(lv1,:)' - 1;
    

%%%%%%%%%%%%%%%%%%%%%% DCM PARAMETRIZATION CASE %%%%%%%%%%%%%%%%%%%%%%%%%%%
    case "DCM"
    % Compute Position,Velocity,True Quaternion&DCM for each timestep:
    r_a = x_out(lv1,1:3)';                % position in Frame a   
    r_norm = vecnorm(x_out(lv1,1:3),2,2);            % distance in Frame a
    C_ba = reshape(x_out(lv1,7:15)',[3,3]); % True DCM
    q(lv1,:) = DCM2Quaternion(C_ba);             % True Quaternion
    r_b = C_ba * r_a;                     % position in Frame b
    v_a = x_out(lv1,4:6);                 % velocity in Frame a
    omega_ba = x_out(lv1,16:18);          % angular velocity
%     % Compute Force due to Earth's gravity (including J2 pertubation):
%     fg(lv1,:) =   (-1*muE*mB/r_norm^3*r_a)...
%                 + (3*muE*mB*J2*Re^2/2/r_norm^5)...
%                 * ( (5/r_norm^2)*(r_a(3)^2-1)*r_a ...
%                      - 2*r_a(3)*[0, 0, 1] );
    % Compute Kinetic Energy (translational&rotational) at each timestep:
    T(lv1) =   (mB/2)*(v_a*v_a')...
             + (1/2)*omega_ba*I*omega_ba';
    % Compute Potential Energy (gravitational forces) at each timestep:  
    Vg(lv1) =    -1*muE*mB/r_norm...
              + (muE*mB*J2*Re^2/r_norm^3)...
              * ( (3/2/r_norm^2)*r_a(3)^2 - 1/2 );
    % Compute Potential Energy (gravity-gradient torque) at each timestep:
    Vgg(lv1) =   (muE/2/r_norm^3)...
               * ( (3/r_norm^2) * r_b' * I ...
                    * r_b - trace(I) );
    % Compute TOTAL ENERGY at each timestep:
    if TORQ == "dipole"
        E(lv1) = T(lv1) + Vg(lv1);
    else
        E(lv1) = T(lv1) + Vg(lv1) + Vgg(lv1);
    end % end if
    % Compute Euler Angles associated with quaternion at each timestep:
    [phi,theta,psi] = DCM2Euler321(C_ba);
    EA(lv1,:) = [phi,theta,psi];
    % Compute (True Determinant of DCM minus 1) at each timestep:
    D(lv1) = det(C_ba) - 1;
    
      
end % end switch 

end % end for