%% AEM 4305 Homework 1 code
clear; close; clc;
%
% Question 2)
%
A = [3     5     2;
     4     2     3;
     -1    2     4]; 
 
DETERMINANT = det(A)
%
% Question 3)
%
A = [-2   -6    0;
      2    5    0;
      0    0    4];
[eigVEC,eigVAL] = eig(A)
% written answers were scaled eigenvectors (to output whole numbers):
eigVEC(:,1) = eigVEC(:,1)/eigVEC(2,1);
eigVEC(:,2) = eigVEC(:,2)/eigVEC(2,2);

eigVEC


