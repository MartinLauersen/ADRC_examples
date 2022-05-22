%% Clean up
clear all; close all; clc;

%% Define system
num = [1.63];
den = [1.48889 1.0347];
sys = tf(num, den)

num_sc1 = num/den(2)
den_sc1 = den/den(2)
sys_sc1 = tf(num_sc1, den_sc1)

figure(1)
step(sys)
hold on
step(sys_sc1)
hold off
legend()


%% paper
sys = tf([23.2], [1 1.41 0])
step(sys)