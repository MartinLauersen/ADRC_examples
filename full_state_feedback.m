%% Example 1: Stable System
disp("--------- STABLE SYSTEM -----------")
A = [0 1; -2 -3]
B = [0 1]'
C = [1 0]

sys = ss(A, B, C, 0);

poles = eig(A)
disp("-- Is system stable? --")
isstable(poles)
disp("-----------------------")

%% Example 1.1: Open-loop response
% Response with non-zero initial conditions
figure(1)
x0 = [1 0.0];
t = 0:0.01:10;
u = zeros(size(t));
[y, t, x] = lsim(sys, u, t, x0);
plot(t,x)
legend(["x_1", "x_2"])
xlabel("Time [sec]")
grid on

% Step response
figure(2)
[y, t, x] = step(sys, 10);
plot(t, x)
legend(["x_1", "x_2"])
xlabel("Time [sec]")
grid on;

%% Example 1.2: Traditional pole-placement
% Pick poles at -4
poles = [-5 -5]
K = acker(A, B, poles)
Nbar = rscale(sys,K)
sys_cl = ss(A-B*K, B, C, 0);

%% Example 1.3: Closed Loop response
figure(1)
x0 = [1 0.0];
t = 0:0.01:10;
u = 0.001*ones(size(t));
[y, t, x] = lsim(sys_cl, u, t, x0);

plot(t,x)
hold on
plot(t,u)
hold off
legend(["x_1", "x_2", "u"])
xlabel("Time [sec]")
grid on

% Step response
figure(2)
[y, t, x] = step(sys_cl, 10);
plot(t, x)
legend(["x_1", "x_2"])
xlabel("Time [sec]")
grid on;
