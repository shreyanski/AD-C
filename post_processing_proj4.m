%% AEM 4305 PROJECT 4 - Processing after Numerical Integration
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
switch attitude
%%%%%%%%%%%%%%%%%%%%% QUATERNION PARAMETRIZATION CASE %%%%%%%%%%%%%%%%%%%%%  
    case "Quaternion"
    % Compute Distance "r" for each timestep using x,y,z:
    r(lv1) = vecnorm(x_out(lv1,1:3),2,2);
    % Compute Force due to Earth's gravity (including J2 pertubation):
    fg(lv1,:) =   (-1*muE*mB/r(lv1)^3)*x_out(lv1,1:3)...
                + (3*muE*mB*J2*Re^2/2/r(lv1)^5)...
                * ( (5/r(lv1)^2)*((x_out(lv1,3)^2)-1)*x_out(lv1,1:3) ...
                     - 2*(x_out(lv1,3))*[0, 0, 1] );
    % Compute Kinetic Energy (translational&rotational) at each timestep:
    T(lv1) =   (mB/2)*x_out(lv1,4:6)*x_out(lv1,4:6)'...
             + (1/2)*x_out(lv1,end-2:end)*I*x_out(lv1,end-2:end)';
    % Compute Potential Energy (gravitational forces) at each timestep:  
    Vg(lv1) =    -1*muE*mB/r(lv1)...
              + (muE*mB*J2*Re^2/r(lv1)^3)...
              * ( (3/2/r(lv1)^2)*(x_out(lv1,3))^2 - (1/2) );
    % Compute Potential Energy (gravity-gradient torque) at each timestep:
    C_ba = Quaternion2DCM(x_out(lv1,7:end-3)'); 
    Vgg(lv1) =   (muE/2/r(lv1)^3)...
               * ( (3/r(lv1)^2) * (C_ba*x_out(lv1,1:3)')' * I ...
                    * (C_ba*x_out(lv1,1:3)') - trace(I) );
    % Compute TOTAL ENERGY at each timestep:
    if torque == "dipole"
        E(lv1) = T(lv1) + Vg(lv1);
    else
        E(lv1) = T(lv1) + Vg(lv1) + Vgg(lv1);
    end % end if
    % Compute Euler Angles associated with quaternion at each timestep:
    EulerAngles = DCM2Euler321(C_ba);
    EA(lv1,:) = EulerAngles;
    % Compute (Norm of Quaternion minus 1) at each timestep:
    N(lv1) = x_out(lv1,7:9) * x_out(lv1,7:9)' + x_out(lv1,10)^2 - 1;

%%%%%%%%%%%%%%%%%%%%%% DCM PARAMETRIZATION CASE %%%%%%%%%%%%%%%%%%%%%%%%%%%
    case "DCM"
    % Compute Distance "r" for each timestep using x,y,z:
    r(lv1) = vecnorm(x_out(lv1,1:3),2,2);
    % Compute Force due to Earth's gravity (including J2 pertubation):
    fg(lv1,:) =   (-1*muE*mB/r(lv1)^3)*x_out(lv1,1:3)...
                + (3*muE*mB*J2*Re^2/2/r(lv1)^5)...
                * ( (5/r(lv1)^2)*((x_out(lv1,3)^2)-1)*x_out(lv1,1:3) ...
                     - 2*(x_out(lv1,3))*[0, 0, 1] );
    % Compute Kinetic Energy (translational&rotational) at each timestep:
    T(lv1) =   (mB/2)*x_out(lv1,4:6)*x_out(lv1,4:6)'...
             + (1/2)*x_out(lv1,end-2:end)*I*x_out(lv1,end-2:end)';
    % Compute Potential Energy (gravitational forces) at each timestep:  
    Vg(lv1) =    -1*muE*mB/r(lv1)...
              + (muE*mB*J2*Re^2/r(lv1)^3)...
              * ( (3/2/r(lv1)^2)*(x_out(lv1,3))^2 - (1/2) );
    % Compute Potential Energy (gravity-gradient torque) at each timestep:
    C_ba = reshape(x_out(lv1,7:end-3)',[3,3]); 
    Vgg(lv1) =   (muE/2/r(lv1)^3)...
               * ( (3/r(lv1)^2) * (C_ba*x_out(lv1,1:3)')' * I ...
                    * (C_ba*x_out(lv1,1:3)') - trace(I) );
    % Compute TOTAL ENERGY at each timestep:
    if torque == "dipole"
        E(lv1) = T(lv1) + Vg(lv1);
    else
        E(lv1) = T(lv1) + Vg(lv1) + Vgg(lv1);
    end % end if
    % Compute Euler Angles associated with DCM at each timestep:
    EulerAngles = DCM2Euler321(C_ba);
    EA(lv1,:) = EulerAngles;
    % Compute (Determinant of DCM minus 1) at each timestep:
    D(lv1) = det(C_ba) - 1;
      
end % end switch 

end % end for