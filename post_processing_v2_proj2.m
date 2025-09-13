% Post processing script.
% Created by James Richard Forbes
% Edited by Ryan James Caverly and Shreyans Kinattumkara

% Here is where you do post processing. 
% For instance, when all forces are conservative, energy should be 
% conserved. So, let's compute the energy, E = T + V.

for lv1 = 1:length(t)    
    % computing r for each timestep using x,y,z:
    r(lv1) = vecnorm(x_out(lv1,1:3),2,2);
    
    % Compute total energy at each time step:
    % Not including J2 pertubation
    E(lv1) = (mS/2)*x_out(lv1,4:6)*x_out(lv1,4:6)' - (muE*mS/r(lv1)); %(J2=0)
    % INCLUDING J2 pertubation
    %E(lv1) = (mS/2)*x_out(lv1,4:6)*x_out(lv1,4:6)'...
              %... - (muE*mS*J2*Re^2/r(lv1)^3)*( (3/2/r(lv1)^2)*(x_out(lv1,3))^2 - (1/2) );
              
    % Computing force due to Earth's gravity including J2 pertubation:
    fsg(lv1,:) = (-1*muE*mS/r(lv1)^3)*x_out(lv1,1:3) + (3*muE*mS*J2*Re^2/2/r(lv1)^5)...
               *( (5/r(lv1)^2)*((x_out(lv1,3)^2)-1)*x_out(lv1,1:3) ...
                  - 2*(x_out(lv1,3))*[0, 0, 1] );
end

