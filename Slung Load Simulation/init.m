%% Clean up
clear all; close all; clc;

%% Variables for Simulation - Environment
g = 9.82;                   % Acceleration due to gravity
Ts = 1/500;                % Sample time in seconds

%% Variables for simulation - UAV
% Physical parameters
m_c = 2.5;                  % Mass in kg

%% Variables for simulation - Cable
L = 1;%0.7%4.2;            % Cable length in meters

%% Variables for simulation - Load
% Physical parameters
m_l = 0.250;                % Mass in grams
d = 0.1;                    % Drag

% Initial conditions
nu_init = [0 0 -L 0 0]';     % x y z phi theta
eta_init = [0 0 0 0 0]';   % dx dy dz dphi dtheta

%% Controller saturations
% Saturate possible output forces for copter velocity controller:
xyforce = [-10 10];
zforce = [-40 40];

% Saturate output of X Y Z load velocity controllers:
ldx_sat = [-5 5];
ldy_sat = ldx_sat;
ldz_sat = ldx_sat;


%% Gains for Load X Position Control
b = 2;
Tsettle = 0.5;
K = 4/Tsettle;
s_cl = -K;
s_eso = 10*s_cl;
bw_con = -s_cl;
bw_eso = -s_eso;

%% Gains for Load X Velocity Control
b = 2;
Tsettle = 0.5;
K = 4/Tsettle;
s_cl = -K;
s_eso = 3*s_cl;
bw_con = -s_cl;
bw_eso = -s_eso;

%% WORKS FOR L = 0.6 - Gains for Load X Velocity Control
b = 2;
Tsettle = 4;
K = 4/Tsettle;
s_cl = -K;
s_eso = 10*s_cl;
bw_con = -s_cl;
bw_eso = -s_eso;

%% WORKS FOR L = [0.8, 1, 1.2], m_l = [0.25 1] - Gains for Load X Velocity Control
b = 1;
Tsettle = 2;
K = 4/Tsettle;
s_cl = -K;
s_eso = 10*s_cl;
bw_con = -s_cl;
bw_eso = -s_eso;

%% WORKS FOR L = [1.2] m_l = [1] - Gains for Load X Velocity Control
b = 1;
Tsettle = 1.5;
K = 4/Tsettle;
s_cl = -K;
s_eso = 10*s_cl;
bw_con = -s_cl;
bw_eso = -s_eso;