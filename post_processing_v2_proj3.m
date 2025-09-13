%% AEM 4305 PROJECT 3 - Processing after Numerical Integration

for lv1 = 1:length(t)    

    % Compute Rotational Kinetic Energy at each time step:
    T(lv1) = (1/2) * x_out(lv1,5:7) * I * x_out(lv1,5:7)';
    
    % Compute Euler Angles associated with the Quaternion:
    C_ba = Quaternion2DCM(x_out(lv1,1:4)');
    EulerAngles = DCM2Euler321(C_ba);
    EA(lv1,:) = EulerAngles;
    
    % Compute norm of quaternion minus 1:
    N(lv1) = x_out(lv1,1:3) * x_out(lv1,1:3)' + x_out(lv1,4)^2 - 1;
    
    
end
