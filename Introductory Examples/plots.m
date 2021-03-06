%% Clean up and initialize
close all; clc;
pdir = '~/thesis/Master-Thesis-Report/figures/';
chdir = 'introduction/';

%% Define system
num = [1.63];
den = [0.48889 1.0347];
sys = tf(num, den)

num_sc1 = num/den(2)
den_sc1 = den/den(2)
sys_sc1 = tf(num_sc1, den_sc1)

figure(1)
step(sys, 20)

%% Make sure all text is in LaTeX
list_factory = fieldnames(get(groot,'factory'));
index_interpreter = find(contains(list_factory,'Interpreter'));

for i = 1:length(index_interpreter)
    default_name = strrep(list_factory{index_interpreter(i)},'factory','default');
    set(groot, default_name, 'latex');
end

%% Open loop respones
f1 = figure(1);
plot(out.ol.Output)
yline(out.ol.Reference.Data(), '--')
legend(["Output","Input"], Location="best");
xlabel("Time $[sec]$")
ylabel("Amplitude")
title("")
grid on
imgname = "ex1_openloop";
fstring = fullfile(pdir, chdir, imgname+'.eps');
exportgraphics(f1, fstring,'ContentType','vector')
%% ADRC vs PI
f2 = figure(2);
plot(out.ex1.ADRC.y)
hold on
plot(out.ex1.PI.y)
hold off
yline(out.ol.Reference.Data(), '--')
legend(["ADRC", "PI","Reference"], Location="best")
xlabel("Time $[s]$", Interpreter="latex")
ylabel("Amplitude", Interpreter="latex")
title("")
xlim([0 5])
ylim([0 1.1])
grid on
imgname = "ex1_adrc_vs_pi";
fstring = fullfile(pdir, chdir, imgname+'.eps');
exportgraphics(f2, fstring,'ContentType','vector')

%% ADRC vs PI w. disturbance
f3 = figure(3);
tiledlayout('flow', 'TileSpacing','tight')

nexttile;
plot(out.ex1_dist.ADRC.y)
hold on
plot(out.ex1_dist.PI.y)
hold off
yline(out.ol.Reference.Data(), '--')
legend(["ADRC", "PI","Reference"], Location="northeast")
xlabel("Time $[s]$", Interpreter="latex")
ylabel("Amplitude", Interpreter="latex")
title("")
grid on

nexttile;
plot(out.ex1_dist.ADRC.u)
hold on
plot(out.ex1_dist.PI.u)
hold off
legend(["ADRC", "PI"], Location="southeast")
xlabel("Time $[s]$", Interpreter="latex")
ylabel("Control Input", Interpreter="latex")
title("")
grid on
axis 'auto xy'
imgname = "ex1_disturbance";
fstring = fullfile(pdir, chdir, imgname+'.eps');
exportgraphics(f3, fstring,'ContentType','vector')

%% ADRC vs PI
f4 = figure(4);
plot(out.ex1_dist.ADRC.z)
leg = legend(["$z_1$", "$z_2$"], Location="best", Interpreter="latex");
title(leg, "States")
xlabel("Time $[s]$", Interpreter="latex")
ylabel("Amplitude", Interpreter="latex")
title("")
% xlim([0 5])
% ylim([0 1.1])
grid on
imgname = "ex1_disturbance_adrcstates";
fstring = fullfile(pdir, chdir, imgname+'.eps');
exportgraphics(f4, fstring,'ContentType','vector')

%% Plots of changing scale
clear all, close all
for i = 1:20
    data(i) = load(['ex1_changing_plant_80perc_' num2str(i) '.mat'])
end

%%
f5 = figure(5)
tiledlayout(2,1);

nexttile
hold on
for i = 1:3:length(data)
    dpname = ['$' num2str(i*10) '/%$'];
    plot(data(i).ans.ADRC.y, 'DisplayName',dpname)
end
hold off

xlim([0,10])
leg = legend(Interpreter='latex');
% title(leg, 'Scale')

nexttile
hold on
for i = 1:3:length(data)
    dpname = ['$' num2str(i*10) '/%$'];
    plot(data(i).ans.PI.y, 'DisplayName',dpname)
end
hold off