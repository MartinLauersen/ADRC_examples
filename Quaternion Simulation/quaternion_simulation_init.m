% Based on Quadrotor Quaternion Control by J. Carino, H. Abuanza & P.
% Castillo
clear all; close all; clc

%% Initialize Simulation Variables
Ts = 0.005;

%% Paper K_att and K_pos
m_uav = 1.3; %Mass in kg
J_uav = diag([0.0118976 0.0118976 0.0218816]); % Inertia

% As shown in Section (IV) in J.Carino, et al.
K_att = [diag([100 100 3.16e-6]) diag([14.142 14.142 2.51e-3])];
K_pos = [diag([3.1622 3.1622 3.1622]) diag([2.7063 2.7063 2.7603])];
% 
% 
% %% Paper K_att real test
% K_att = [diag([0.35 0.35 0.2]) diag([0.08 0.08 0.2])];