syms s

sys = tf([23.2],[1 1.41 0])
k = 11.67

%%
sys = tf(1, [1 1 0])

sys*k

% subs(sys, s, s/1.41)

sys.tf()

%% 
close all
gamma = 0.2;

num = [1];
den = [1, 2*gamma, 1];

sys = tf(num,den)%, 'InputDelay',0.4)

step(sys)

pzmap(sys)

rlocus(sys)

[A, B, C, D] = tf2ss(num, den)
sys_ss = ss(A, B, C, D)
K = place(A, B, [-2, -3])