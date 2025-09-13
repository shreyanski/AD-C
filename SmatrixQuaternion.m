function [Sb_ba] = SmatrixQuaternion(q_ba)
%
% FUNCTION PURPOSE:
% [Sb_ba] = SmatrixQuaternion(q_ba) obtains the S matrix using the 
% relation between the angular velocity (of frame "b" relative to frame 
% "a" resolved in the "b" frame) and the quaternion rates
%
% INPUT PARAMETERS:
% q_ba = 4x1 column matrix containing quaternion parameters [ eps1;
%                                                             eps2;
%                                                             eps3;
%                                                              eta ]
%
% OUTPUT PARAMETERS:
% Sb_ba = S matrix of frame "b" relative to frame "a", resolved in frame b
%         (3x4 matrix)
%
eta = q_ba(4);
eps = q_ba(1:3);
epsCROSS = crossm(eps);
Sb_ba = [2*(eta*eye(3)-epsCROSS)      -1*eps];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION DEFINITION ("crossm.m")
function [M] = crossm(v)
%CROSSM  Cross product matrix calculation.
% [M] = CROSSM(v) solves for cross product matrix of v.
%
% INPUT PARAMETERS:
% v = 3x1 column matrix
%
% OUTPUT PARAMETERS:
% M = 3x3 cross product matrix of v
%
% Ryan Caverly
% Updated February 2019
%
M = [0 -v(3) v(2);v(3) 0 -v(1);-v(2) v(1) 0];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end






