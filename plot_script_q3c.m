%% Plotting File - Question 3(c) PD Control with Reaction Wheels - WITH Magnetorquer

if ATT == "Quaternion"
    %%% Plotting Quaternion parameters (epsilon and eta):
    figure;
    plot(t, x_out(:,7), t, x_out(:,8), t, x_out(:,9));
    title('Quaternion Response - $\epsilon$','interpreter','latex');
    ylabel('$\epsilon_{1},\epsilon_{2},\epsilon_{3}$','interpreter','latex');
    xlabel('$Time-[s]$','interpreter','latex');
    legend('$\epsilon_{1}$','$\epsilon_{2}$','$\epsilon_{3}$','interpreter','latex');
    legend('location','southeast');
    grid(gca,'minor');
    figure;
    plot(t, x_out(:,10));
    title('Quaternion Response - $\eta$','interpreter','latex');
    xlabel('$Time-[s]$','interpreter','latex');
    ylabel('$\eta$','interpreter','latex');
    grid(gca,'minor');
%     %%% Plotting Norm of Quaternion minus 1:
%     figure(f+2);
%     plot(t,N);
%     title('Divergence of Quaternion Norm - $\textbf{True Attitude}$','interpreter','latex');
%     xlabel('$Time-[s]$','interpreter','latex');
%     ylabel('$q^{T}q - 1$','interpreter','latex');
%     grid(gca,'minor');
%     %%% Plotting Norm of Quaternion minus 1 using Inertial Navigation:
%     figure(f+3);
%     plot(t,N_IN);
%     title('Divergence of Quaternion Norm - $\textbf{Inertial Navigation}$','interpreter','latex');
%     xlabel('$Time-[s]$','interpreter','latex');
%     ylabel('$\hat{q}^T\hat{q} - 1$','interpreter','latex');
%     grid(gca,'minor');
%     f = f+4; % next figure #

elseif ATT == "DCM"
%     %%% Plotting Determinant of DCM minus 1:
%     figure(f);
%     plot(t,D);
%     title('Divergence of DCM Determinant - $\textbf{True Attitude}$','interpreter','latex');
%     ylabel('det($C_{ba}$) - 1','interpreter','latex');
%     xlabel('$Time-[s]$','interpreter','latex');
%     grid(gca,'minor');
%     %%% Plotting Estimated Determinant of DCM minus 1:
%     figure(f+1);
%     plot(t,D_IN);
%     title('Divergence of DCM Determinant - $\textbf{Inertial Navigation}$','interpreter','latex');
%     ylabel('det($C^{IN}_{ba}$) - 1','interpreter','latex');
%     xlabel('$Time-[s]$','interpreter','latex');
%     grid(gca,'minor');
%     f = f+2; % next figure #

end

%%% Plotting Euler Angles:
figure;
plot(t, EA(:,1)*180/pi);
title('(3-2-1) Euler Angle Response - $\phi$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$\phi-[^{\circ}]$','interpreter','latex');
grid(gca,'minor');
figure;
plot(t, EA(:,2)*180/pi);
title('(3-2-1) Euler Angle Response - $\theta$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$\theta-[^{\circ}]$','interpreter','latex');
grid(gca,'minor');
figure;
plot(t, EA(:,3)*180/pi);
title('(3-2-1) Euler Angle Response - $\psi$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$\psi-[^{\circ}]$','interpreter','latex');
grid(gca,'minor');

%%% Plotting Angular Velocity:
figure;
if ATT == "Quaternion"
    plot(t,x_out(:,11),t,x_out(:,12),t,x_out(:,13));
elseif ATT == "DCM"
    plot(t,x_out(:,16),t,x_out(:,17),t,x_out(:,18));
end
% ylim([-0.2 0.35]);
% yticks(-0.2:0.05:0.35);
title('Angular Velocity Response $\omega^{ba}_{b}$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$\omega^{ba}_{b_{1}},\omega^{ba}_{b_{2}},\omega^{ba}_{b_{3}}-[rad/s]$','interpreter','latex');
legend('$\omega^{ba}_{b_{1}}$','$\omega^{ba}_{b_{2}}$','$\omega^{ba}_{b_{3}}$','interpreter','latex');
legend('location','southeast');
grid(gca,'minor');
    

% Plotting reaction wheel speeds response:
figure;
plot(t,x_out(:,14),t,x_out(:,15),t,x_out(:,16));
title('(Reaction Wheels) Angular Velocity Response $\dot{\gamma}$','interpreter','latex');
xlabel('$Time-[s]$','interpreter','latex');
ylabel('$\dot{\gamma_{1}},\dot{\gamma_{2}},\dot{\gamma_{3}}-[rad/s]$','interpreter','latex');
legend('$\dot{\gamma_{1}}$','$\dot{\gamma_{2}}$','$\dot{\gamma_{3}}$','interpreter','latex');
legend('location','northeast');
grid(gca,'minor');
