% Plotting script.
% Created by James Richard Forbes
% Edited by Ryan James Caverly and Shreyans Kinattumkara

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Font size, line size, and line width. 
font_size = 8;
line_size = 15;
line_width = 2;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Positions:
figure(1)
% plot of x vs time
plot(t,x_out(:,1),'Linewidth',line_width); 
hold on
xlabel('Time (s)','fontsize',font_size,'Interpreter','latex');
ylabel('$x_{a} (m)$','fontsize',font_size,'Interpreter','latex');
set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
grid on
figure(2)
% plot of y vs time
plot(t,x_out(:,2),'Linewidth',line_width); 
hold on
xlabel('Time (s)','fontsize',font_size,'Interpreter','latex');
ylabel('$y_{a} (m)$','fontsize',font_size,'Interpreter','latex');
set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
grid on
figure(3)
% plot of z vs time
plot(t,x_out(:,3),'Linewidth',line_width); 
hold on
xlabel('Time (s)','fontsize',font_size,'Interpreter','latex');
ylabel('$z_{a} (m)$','fontsize',font_size,'Interpreter','latex');
set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
grid on

% Velocities:
figure(4)
% Plot of xdot vs time
plot(t,x_out(:,4),'Linewidth',line_width); 
hold on
xlabel('Time (s)','fontsize',font_size,'Interpreter','latex');
ylabel('$x_{a}^{\bullet} (m/s)$','fontsize',font_size,'Interpreter','latex');
set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
grid on
figure(5)
% plot of ydot vs time
plot(t,x_out(:,5),'Linewidth',line_width); 
hold on
xlabel('Time (s)','fontsize',font_size,'Interpreter','latex');
ylabel('$y_{a}^{\bullet} (m/s)$','fontsize',font_size,'Interpreter','latex');
set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
grid on
figure(6)
% plot of zdot vs time
plot(t,x_out(:,6),'Linewidth',line_width);
hold on
xlabel('Time (s)','fontsize',font_size,'Interpreter','latex');
ylabel('$z_{a}^{\bullet} (m/s)$','fontsize',font_size,'Interpreter','latex');
set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
grid on

% Energies:
figure(7)
% Plot of total energy vs time (should be constant)
plot(t,E,'Linewidth',line_width);
hold on
title('$Total Energy Vs Time (J2=0)$','Interpreter','latex');
xlabel('Time (s)','fontsize',font_size,'Interpreter','latex');
ylabel('$E (J)$','fontsize',font_size,'Interpreter','latex');
set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
grid on
figure(8)
% Plot of normalized change in energy vs time (should be increasing because of entropy)
plot(t,(E-E(1))./E(1),'Linewidth',line_width);
hold on
title('$Normalized Change In Energy Vs Time (J2=0)$','Interpreter','latex');
xlabel('Time (s)','fontsize',font_size,'Interpreter','latex');
ylabel('$(E - E_{0})/E_{0} (J)$','fontsize',font_size,'Interpreter','latex');
set(gca,'XMinorGrid','off','GridLineStyle','-','FontSize',line_size)
grid on


