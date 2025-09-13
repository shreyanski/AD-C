%% AEM 4305 Homework 2 code
clear; close; clc;
%
% Question 2(a)
%
U = [1;
     2;
     3];
Ux = crossMatrix(U)
V = [7;
     6;
     5];
UcrossV = Ux * V
%
% Question 2(b)
%
NORM = sqrt(UcrossV(1)^2 + UcrossV(2)^2 + UcrossV(3)^2)


% function definition used to compute the cross product matrix Ux:
function [Ux] = crossMatrix(U)
    Ux = [ 0      -U(3)     U(2);
           U(3)    0       -U(1);
          -U(2)    U(1)     0   ];
end