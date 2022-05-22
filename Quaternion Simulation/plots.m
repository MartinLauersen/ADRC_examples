%% Clean up and initialize
close all; clc;
pdir = '~/thesis/Master-Thesis-Report/figures/';
chdir = 'scenario1/';

%% Make sure all text is in LaTeX
list_factory = fieldnames(get(groot,'factory'));
index_interpreter = find(contains(list_factory,'Interpreter'));

for i = 1:length(index_interpreter)
    default_name = strrep(list_factory{index_interpreter(i)},'factory','default');
    set(groot, default_name, 'latex');
end

%% Trajectory
adrc = load("adrc_normal.mat")
state = load("state_normal.mat")
f1 = figure(1);

tiledlayout(3,1, "TileSpacing","tight", "Padding","tight");

nexttile;
plot(adrc.out.state.X)
hold on
plot(state.out.state.X)
plot(adrc.out.setpoints.X, 'k--')
hold off
legend(["ADRC","Original","Reference"], Location="southeast", Interpreter="latex");
xlabel("")
% xlabel("Time $[sec]$", Interpreter="latex")
ylabel("$x$ $[m]$", Interpreter="latex")
title("")
grid on

nexttile;
plot(adrc.out.state.Y)
hold on
plot(state.out.state.Y)
plot(adrc.out.setpoints.Y, 'k--')
hold off
xlabel("")
% xlabel("Time $[sec]$", Interpreter="latex")
ylabel("$y$ $[m]$", Interpreter="latex")
title("")
grid on

nexttile;
plot(adrc.out.state.Z)
hold on
plot(state.out.state.Z)
plot(adrc.out.setpoints.Z, 'k--')
hold off
xlabel("Time $[sec]$", Interpreter="latex")
ylabel("$z$ $[m]$", Interpreter="latex")
title("")
grid on

imgname = "quadrotor_normal_trajectory";
fstring = fullfile(pdir, chdir, imgname+'.eps');
exportgraphics(f1, fstring,'ContentType','vector')


%% Z with double mass
adrc = load("adrc_mass_150per.mat")
state = load("state_mass_150per.mat")

f2 = figure(2)
plot(adrc.out.state.Z)
hold on
plot(state.out.state.Z)
plot(out.setpoints.Z, 'k--')
hold off
legend(["ADRC","Original","Reference"], Location="southeast", Interpreter="latex");
xlabel("Time $[sec]$", Interpreter="latex")
ylabel("$z$ $[m]$", Interpreter="latex")
title("")
grid on

imgname = "quadrotor_mass_150perc";
fstring = fullfile(pdir, chdir, imgname+'.eps');
exportgraphics(f2, fstring,'ContentType','vector')


%% Trajectory with 150% mass
f3 = figure(3);

tiledlayout(3,1, "TileSpacing","tight", "Padding","tight");

nexttile;
plot(adrc.out.state.X)
hold on
plot(state.out.state.X)
plot(adrc.out.setpoints.X, 'k--')
hold off
legend(["ADRC","Original","Reference"], Location="southeast", Interpreter="latex");
xlabel("")
% xlabel("Time $[sec]$", Interpreter="latex")
ylabel("$x$ $[m]$", Interpreter="latex")
title("")
grid on

nexttile;
plot(adrc.out.state.Y)
hold on
plot(state.out.state.Y)
plot(adrc.out.setpoints.Y, 'k--')
hold off
xlabel("")
% xlabel("Time $[sec]$", Interpreter="latex")
ylabel("$y$ $[m]$", Interpreter="latex")
title("")
grid on

nexttile;
plot(adrc.out.state.Z)
hold on
plot(state.out.state.Z)
plot(adrc.out.setpoints.Z, 'k--')
hold off
xlabel("Time $[sec]$", Interpreter="latex")
ylabel("$z$ $[m]$", Interpreter="latex")
title("")
grid on

imgname = "quadrotor_mass_150perc_trajectory";
fstring = fullfile(pdir, chdir, imgname+'.eps');
exportgraphics(f3, fstring,'ContentType','vector')


%% Trajectory with disturbance
adrc = load("adrc_disturbance.mat")
state = load("state_disturbance.mat")
f4 = figure(4);

t = tiledlayout(2,1, "TileSpacing","tight", "Padding","tight");

ax1 = nexttile;
plot(state.out.state.X)
hold on
plot(state.out.state.Y)
plot(state.out.state.Z)
plot(state.out.setpoints.X, 'k--')
hold off
legend(["$x$","$y$","$z$","Reference"], Location="northwest", Interpreter="latex");
xlabel("")
% xlabel("Time $[sec]$", Interpreter="latex")
ylabel("Position $[m]$", Interpreter="latex")
title("Original")
grid on

ax2 = nexttile;
plot(adrc.out.state.X)
hold on
plot(adrc.out.state.Y)
plot(adrc.out.state.Z)
plot(adrc.out.setpoints.X, 'k--')
hold off
% legend(["$x$","$y$","$z$","Reference"], Location="southeast", Interpreter="latex");
xlabel("")
% xlabel("Time $[sec]$", Interpreter="latex")
ylabel("Position $[m]$", Interpreter="latex")
title("ADRC")
grid on

linkaxes([ax1 ax2], 'xy')

imgname = "quadrotor_disturbance_1_neg2_4_trajectory";
fstring = fullfile(pdir, chdir, imgname+'.eps');
exportgraphics(f4, fstring,'ContentType','vector')

%% Trajectory with extreme disturbance
adrc = load("adrc_disturbance_extreme.mat")
state = load("state_disturbance_extreme.mat")
f5 = figure(5);

t = tiledlayout(2,1, "TileSpacing","tight", "Padding","tight");

ax1 = nexttile;
plot(state.out.state.X)
hold on
plot(state.out.state.Y)
plot(state.out.state.Z)
plot(state.out.setpoints.X, 'k--')
hold off
legend(["$x$","$y$","$z$","Reference"], Location="southeast", Interpreter="latex");
xlabel("")
% xlabel("Time $[sec]$", Interpreter="latex")
ylabel("Position $[m]$", Interpreter="latex")
title("Original")
grid on

ax2 = nexttile;
plot(adrc.out.state.X)
hold on
plot(adrc.out.state.Y)
plot(adrc.out.state.Z)
plot(adrc.out.setpoints.X, 'k--')
hold off
% legend(["$x$","$y$","$z$","Reference"], Location="southeast", Interpreter="latex");
xlabel("")
% xlabel("Time $[sec]$", Interpreter="latex")
ylabel("Position $[m]$", Interpreter="latex")
title("ADRC")
grid on

linkaxes([ax1 ax2], 'xy')

imgname = "quadrotor_disturbance_extreme_trajectory";
fstring = fullfile(pdir, chdir, imgname+'.eps');
exportgraphics(f5, fstring,'ContentType','vector')
%% Disturbance signal
dist = load("disturbance_signal.mat");

f6 = figure(6);
plot(dist.out.disturbance)
legend(["$\ddot{x}_{dist}$","$\ddot{y}_{dist}$","$\ddot{z}_{dist}$"], Location="northeast", Interpreter="latex");
grid on
title("")
xlabel("Time $[sec]$", Interpreter="latex")
ylabel("Amplitude", Interpreter="latex")

imgname = "quadrotor_disturbance_signal";
fstring = fullfile(pdir, chdir, imgname+'.eps');
exportgraphics(f6, fstring,'ContentType','vector')
