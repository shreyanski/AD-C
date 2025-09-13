function [q_ba] = DCM2Quaternion(Cba)
%
% FUNCTION PURPOSE:
% [q_ba] = DCM2Quaternion(Cba) solves for the Quaternion based on the DCM 
% using expressions on p. 25-27 of de Ruiter (2013).
%
% INPUT PARAMETERS:
% Cba = 3x3 DCM input
%
% OUTPUT PARAMETERS:
% q_ba = 4x1 column matrix containing quaternion parameters
%
%
q_ba(4) = abs(sqrt(trace(Cba)+1)/2);
q_ba(1) = (Cba(2,3) - Cba(3,2))/4/q_ba(4);
q_ba(2) = (Cba(3,1) - Cba(1,3))/4/q_ba(4);
q_ba(3) = (Cba(1,2) - Cba(2,1))/4/q_ba(4);
q_ba = q_ba';
end
