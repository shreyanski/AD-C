%% AEM 4305 PROJECT 4 - Plotting File

%%% Plotting Position and Velocity (x-axis):
figure(1)
subplot(2,1,1); % plot of x vs time
plot(t,x_out(:,1)); 
hold on
title('Position Response $x_{a}$','interpreter','latex');
xlabel('$Time-[s]$','Interpreter','latex');
ylabel('$x_{a}-[m]$','Interpreter','latex');
grid(gca,'minor');
subplot(2,1,2); % plot of xdot vs time
plot(t,x_out(:,4)); 
hold on
title('Velocity Response $\dot{x_{a}}$','interpreter','latex');
xlabel('$Time-[s]$','Interpreter','latex');
ylabel('$\dot{x_{a}}-[m/s]$','Interpreter','latex');
grid(gca,'minor');

%%% Plotting Position and Velocity (y-axis):
figure(2)
subplot(2,1,1); % plot of y vs time
plot(t,x_out(:,2)); 
hold on
title('Position Response $y_{a}$','interpreter','latex');
xlabel('$Time-[s]$','Interpreter','latex');
ylabel('$y_{a}-[m]$','Interpreter','latex');
grid(gca,'minor');
subplot(2,1,2); % plot of ydot vs time
plot(t,x_out(:,5)); 
hold on
title('Velocity Response $\dot{y_{a}}$','interpreter','latex');
xlabel('$Time-[s]$','Interpreter','latex');
ylabel('$\dot{y_{a}}-[m/s]$','Interpreter','latex');
grid(gca,'minor');

%%% Plotting Position and Velocity (z-axis):
figure(3)
subplot(2,1,1); % plot of z vs time
plot(t,x_out(:,3)); 
hold on
title('Position Response $z_{a}$','interpreter','latex');
xlabel('$Time-[s]$','Interpreter','latex');
ylabel('$z_{a}-[m]$','Interpreter','latex');
grid(gca,'minor');
subplot(2,1,2); % plot of zdot vs time
plot(t,x_out(:,6)); 
hold on
title('Velocity Response $\dot{z_{a}}$','interpreter','latex');
xlabel('$Time-[s]$','Interpreter','latex');
ylabel('$\dot{z_{a}}-[m/s]$','Interpreter','latex');
grid(gca,'minor');

f = 4; % figure #
if attitude == "Quaternion"
    %%% Plotting Quaternion parameters (epsilon and eta)
    figure(f);
    plot(t, x_out(:,7), t, x_out(:,8), t, x_out(:,9));
    title('Quaternion Response $\epsilon$','interpreter','latex');
    ylabel('$\epsilon_{1},\epsilon_{2},\epsilon_{3}$','interpreter','latex');
    xlabel('$Time-[s]$','interpreter','latex');
    legend('$\epsilon_{1}$','$\epsilon_{2}$','$\epsilon_{3}$','interpreter','latex');
    legend('location','southeast');
    grid(gca,'minor');
    figure(f+1);
    plot(t, x_out(:,10));
    title('Quaternion Response $\eta$','interpreter','latex');
    xlabel('$Time-[s]$','interpreter','latex');
    ylabel('$\eta$','interpreter','latex');
    grid(gca,'minor');
    %%% Plotting Norm of Quaternion minus 1:
    figure(f+2);
    plot(t,N);
    title('Divergence of Quaternion Norm from Unity','interpreter','latex');
    xlabel('$Time-[s]$','interpreter','latex');
    ylabel('$(\epsilon^{T}\epsilon+\eta^2)-1$','interpreter','latex');
    grid(gca,'minor');
    f = 7; % current figure #
elseif attitude == "DCM"
    %%% Plotting Determinant of DCM minus 1:
    figure(f);
    plot(t,D);
    title('Divergence of DCM Determinant from Unity','interpreter','latex');
    ylabel('$det(C_{ba})-1$','interpreter','latex');
    xlabel('$Time-[s]$','interpreter','latex');
    grid(gca,'minor');
    f = 5; % current figure #
end

%%% Plotting Euler Angle parameters:
figure(f);
plot(t, EA(:,1));
title('(3-2-1) Euler Angle Response $\phi$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$\phi-[rad]$','interpreter','latex');
grid(gca,'minor');
figure(f+1);
plot(t, EA(:,2));
title('(3-2-1) Euler Angle Response $\theta$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$\theta-[rad]$','interpreter','latex');
grid(gca,'minor');
figure(f+2);
plot(t, EA(:,3));
title('(3-2-1) Euler Angle Response $\psi$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$\psi-[rad]$','interpreter','latex');
grid(gca,'minor');


%%% Plotting Angular Velocity:
figure(f+3);
plot(t,x_out(:,end-2),t,x_out(:,end-1),t,x_out(:,end));
% ylim([-0.2 0.35]);
% yticks(-0.2:0.05:0.35);
title('Angular Velocity Response $\omega^{ba}_{b}$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$\omega^{ba}_{b_{1}},\omega^{ba}_{b_{2}},\omega^{ba}_{b_{3}}-[rad/s]$','interpreter','latex');
legend('$\omega^{ba}_{b_{1}}$','$\omega^{ba}_{b_{2}}$','$\omega^{ba}_{b_{3}}$','interpreter','latex');
legend('location','southeast');
grid(gca,'minor');

%%% Plotting Total Energy E:
figure(f+4);
subplot(2,1,1);
plot(t,E);
title('Total Energy Response $E^{Bw/a}$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$E^{Bw/a}-[J]$','interpreter','latex');
grid(gca,'minor');
subplot(2,1,2);
plot(t,(E-E(1))/E(1));
title('Normalized Change Response $\frac{E^{Bw/a}-E^{Bw/a}_{0}}{E^{Bw/a}_{0}}$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$\frac{E^{Bw/a}-E^{Bw/a}_{0}}{E^{Bw/a}_{0}}$','interpreter','latex');
grid(gca,'minor');

