%% AEM 4305 PROJECT 3 - Plotting File

% Plotting Quaternion parameters:
figure (1);
plot(t, x_out(:,1), t, x_out(:,2), t, x_out(:,3));
title('Quaternion Response$-\epsilon$','interpreter','latex');
ylabel('$\epsilon_{1},\epsilon_{2},\epsilon_{3}$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
legend('$\epsilon_{1}$','$\epsilon_{2}$','$\epsilon_{3}$','interpreter','latex');
legend('location','southeast');
grid(gca,'minor');
figure(2);
plot(t, x_out(:,4));
title('Quaternion Response$-\eta$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$\eta$','interpreter','latex');
grid(gca,'minor');

% Plotting Euler Angle parameters:
figure(3);
plot(t, EA(:,1));
title('(3-2-1) Euler Angle Response$-\phi$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$\phi-[rad]$','interpreter','latex');
grid(gca,'minor');
figure(4);
plot(t, EA(:,2));
title('(3-2-1) Euler Angle Response$-\theta$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$\theta-[rad]$','interpreter','latex');
grid(gca,'minor');
figure(5);
plot(t, EA(:,3));
title('(3-2-1) Euler Angle Response$-\psi$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$\psi-[rad]$','interpreter','latex');
grid(gca,'minor');

% Plotting Norm of Quaternion minus 1:
figure(6);
plot(t,N);
title('Divergence of Quaternion Norm from Unity','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$(\epsilon^{T}\epsilon+\eta^2)-1$','interpreter','latex');
grid(gca,'minor');

% Plotting Angular Velocity:
figure(7);
plot(t,x_out(:,5),t,x_out(:,6),t,x_out(:,7));
ylim([-0.2 0.35]);
yticks(-0.2:0.05:0.35);
title('Angular Velocity Response$-\omega^{ba}_{b}$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$\omega^{ba}_{b_{1}},\omega^{ba}_{b_{2}},\omega^{ba}_{b_{3}}-[rad/s]$','interpreter','latex');
legend('$\omega^{ba}_{b_{1}}$','$\omega^{ba}_{b_{2}}$','$\omega^{ba}_{b_{3}}$','interpreter','latex');
legend('location','southeast');
grid(gca,'minor');

% Plotting Rotation Kinetic Energy T:
figure(8);
subplot(2,1,1);
plot(t,T);
title('(Rotational) Kinetic Energy Response$-T^{Bw/a}$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$T^{Bw/a}-[J]$','interpreter','latex');
grid(gca,'minor');
subplot(2,1,2);
plot(t,(T-T(1))/T(1));
title('Normalized Change Response$-\frac{T^{Bw/a}-T^{Bw/a}_{0}}{T^{Bw/a}_{0}}$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$\frac{T^{Bw/a}-T^{Bw/a}_{0}}{T^{Bw/a}_{0}}$','interpreter','latex');
grid(gca,'minor');

