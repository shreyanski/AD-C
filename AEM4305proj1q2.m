%% AEM 4305 Project 1 Question 2

% Given DCM:
Cba = [0.8995   0.3870  -0.2026;
      -0.3201   0.8995   0.2974;
       0.2974  -0.2026   0.9330];
   
% Part(b):  
q_ba = DCM2Quaternion(Cba)

% Part(d):
EA = DCM2Euler321(Cba);
phi = EA(1)
theta = EA(2)
psi = EA(3)