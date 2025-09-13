function [v] = uncrossm(M)
% Reverse cross-product matrix calculation to find vector
% [v] = uncrossm(M) solves for vector v that has the cross-product
%       matrix M.
%
% INPUT PARAMETERS:
% M = 3x3 cross product matrix of v
%     [ 0   -v(3)  v(2);
%      v(3)   0   -v(1);
%     -v(2)  v(1)   0];
%
% OUTPUT PARAMETERS:
% v = 3x1 column matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

v = [M(3,2); M(1,3); M(2,1)];