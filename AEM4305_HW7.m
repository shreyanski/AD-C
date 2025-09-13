%% AEM 4305 - HOMEWORK 7
clear; clc;

%% 1(b): Without sensor noise ("b"-frame values are exact)

s1_a = [0; 1; 2];
s2_a = [1; 3; 0];
s3_a = [1; 1; 1];
s1_b = [2.0139;  0.7545;   0.6124];
s2_b = [1.7398;  1.2292;  -2.3371];
s3_b = [1.6578; -0.0429;  -0.5000];

% DCM & EulerAngles estimates for (s1, s2) pair 
C_ba_s1s2 = TRIAD(s1_a, s2_a, s1_b, s2_b)
EA_s1s2 = DCM2Euler321(C_ba_s1s2) % [rad]

% DCM & EulerAngles estimates for (s1, s3) pair 
C_ba_s1s3 = TRIAD(s1_a, s3_a, s1_b, s3_b)
EA_s1s3 = DCM2Euler321(C_ba_s1s3) % [rad]

% Both pairs of measurements describe the same DCM estimate 
% (within ~10^-5) according to the TRIAD algorithm since they are 
% unbiased and noiseless inputs. 


%% 1(c): Including sensor noise ("b"-frame values have error)

s1_b_noise = [2.0712;  0.7264;   0.6192];
s2_b_noise = [1.8040;  1.1874;  -2.3363];
s3_b_noise = [1.1046; -0.2449;  -0.3776];

% DCM & EulerAngles estimates for (s1, s2) pair 
C_ba_s1s2_noise = TRIAD(s1_a, s2_a, s1_b_noise, s2_b_noise)
EA_s1s2_noise = DCM2Euler321(C_ba_s1s2_noise) % [rad]

% DCM & EulerAngles estimates for (s1, s3) pair 
C_ba_s1s3_noise = TRIAD(s1_a, s3_a, s1_b_noise, s3_b_noise)
EA_s1s3_noise = DCM2Euler321(C_ba_s1s3_noise) % [rad]

% The pairs of measurements do NOT describe the same DCM estimate,
% this time, due to the effect of noise on the values of the 
% (s1, s3) pair.

% EulerAngle error due to s2 and s3 noisy measurements
s2_noise_error = abs( EA_s1s2_noise - EA_s1s2 ) % [rad]
s3_noise_error = abs( EA_s1s3_noise - EA_s1s3 ) % [rad]
% s3_noise_error > s2_noise_error, so the noisy s3_b measurement
% results in a more inaccurate estimate of the DCM & EulerAngles.

% Out of the vector measurements including noise, s3_b seems to be
% the noisier measurement. The corresponding 3-2-1 Euler angles 
% show that the noisy (s1,s3) pair encounters larger angle offsets 
% from its noiseless measurements, compared to the (s1,s2) pair.
% This means that the s3_b noisy measurement has a larger standard 
% deviation than the s2_b noisy measurement, so s3_b contributes more
% prominently to the error in the attitude determination than s2_b.

    
