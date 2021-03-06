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

%% Mass increase
adrc = load("adrc_mass_150perc.mat");
orig = load("orig_mass_150perc.mat");

t = adrc.states.X_ned.Time;
f1 = figure(1);

plot(t, -adrc.states.X_ned.Data(3, :))
hold on
plot(t, -orig.states.X_ned.Data(3, :))
xline(10, 'k--')
hold off

legend(["LADRC","Original","Mass increase"], Location="northeast", Interpreter="latex");
xlabel("Time $[s]$", Interpreter="latex");
ylabel("$z$ $[m]$", Interpreter="latex")
title("")
grid on
imgname = "parrot_150perc_mass";
fstring = fullfile(pdir, chdir, imgname+'.eps');
exportgraphics(f1, fstring,'ContentType','vector')

%% Propeller failure
adrc = load("adrc_1prop_60perc.mat");
orig = load("orig_1prop_60perc.mat");

t_adrc = adrc.states.X_ned.Time;
t_orig = orig.states.X_ned.Time;

f2 = figure(2);
t = tiledlayout(2,1, "TileSpacing","tight", "Padding","tight");
ax1 = nexttile;
plot(t_adrc, adrc.states.X_ned.Data(1,:)-adrc.states.X_ned.Data(1,1,1))
hold on
plot(t_adrc, adrc.states.X_ned.Data(2,:)-adrc.states.X_ned.Data(2,1,1))
hold off

xline(10, 'k--')
legend(["$x$", "$y$","Prop failure"], Location="northeast", Interpreter="latex");
grid on
ylabel("Position $[m]$", Interpreter="latex")

ax2 = nexttile;
plot(t_adrc, adrc.states.X_ned.Data(3,:)-adrc.states.X_ned.Data(3,1,1))
xline(10, 'k--')
hold off

xlabel("Time $[s]$", Interpreter="latex");
ylabel("Position $[m]$", Interpreter="latex")
title("")
legend(["$z$"], Location="northeast", Interpreter="latex");
grid on

linkaxes([ax1 ax2], 'x')
xlim([0 20])
imgname = "parrot_prop_failure_adrc";
fstring = fullfile(pdir, chdir, imgname+'.eps');
exportgraphics(f2, fstring,'ContentType','vector')

%% prop failure alternate
f3 = figure(3);  

tiledlayout(2,1, "TileSpacing","tight", "Padding","tight")
ax1 = nexttile;
plot(t_adrc, adrc.states.X_ned.Data(1,:)-adrc.states.X_ned.Data(1,1,1))
hold on;
plot(t_adrc, adrc.states.X_ned.Data(2,:)-adrc.states.X_ned.Data(2,1,1))
plot(t_adrc, adrc.states.X_ned.Data(3,:)-adrc.states.X_ned.Data(3,1,1))
hold off
xline(10, 'k--')
grid on
title("LADRC",Interpreter="latex")
ylabel("Position $[m]$", Interpreter="latex")

ax2 = nexttile;

plot(t_orig, orig.states.X_ned.Data(1,:)-orig.states.X_ned.Data(1,1,1))
hold on
plot(t_orig, orig.states.X_ned.Data(2,:)-orig.states.X_ned.Data(2,1,1))
plot(t_orig, orig.states.X_ned.Data(3,:)-orig.states.X_ned.Data(3,1,1))
hold off
xline(10, 'k--')
grid on
title("Original",Interpreter="latex")
xlabel("Time $[s]$", Interpreter="latex");
ylabel("Position $[m]$", Interpreter="latex")
legend(["$x$", "$y$", "$z$","Prop failure"], Location="southeast", Interpreter="latex");

linkaxes([ax1 ax2], 'yx')

xlim([0 20])
imgname = "parrot_prop_failure";
fstring = fullfile(pdir, chdir, imgname+'.eps');
exportgraphics(f3, fstring,'ContentType','vector')


%% Plot of estimated velocity vs actual (in body frame)
figure("Name", "Velocities")
tiledlayout(3,1)

estim_titles = ["dX", "dY", "dZ"];
t = estim.time();

for index = 7:9
    nexttile;
    
    plot(t, estim.signals.values(:,index))
    hold on
    plot(t, states.V_body.Data(3-mod(9,index),:))
    hold off
    
    grid on
    ylabel(estim_titles(3-mod(9,index)) + " $[m/s]$",Interpreter="latex")
    legend(["Estimate", "State"], Location="best",Interpreter="latex")
end
xlabel("Time [s]",Interpreter="latex")

%% Plot of estimated position vs actual
figure("Name", "Position")
tiledlayout(3,1)

estim_titles = ["X", "Y", "Z"];
t = estim.time();

for index = 1:3
    nexttile;
    
    plot(t, estim.signals.values(:,index))
    hold on
    plot(t, states.X_ned.Data(index,:)-states.X_ned.Data(index,1,1))
    hold off
    
    grid on
    ylabel(estim_titles(index) + " $[m]$",Interpreter="latex")
    legend(["Estimate", "State"], Location="best",Interpreter="latex")
end
xlabel("Time [s]",Interpreter="latex")

%% Plot of estimation errors
figure("Name", "Errors")
tiledlayout(3,2)

estim_titles = ["X", "Y", "Z", "dX", "dY", "dZ"];
t = estim.time();

datpos = [1:3, 7:9];

for index = 1:6
    nexttile;
    
    plot(t, estim.signals.values(:,index))
    hold on
    if index < 4
        err = states.X_ned.Data(index,:)-states.X_ned.Data(index,1,1)-estim.signals.values(:,index);
    else
        err = states.V_body.Data(3-index,:)-estim.signals.values(:,3+index);
    end
    
    plot(t, err)
    hold off
    
    grid on
%     ylabel(estim_titles(index) + " $[m]$",Interpreter="latex")
%     legend(["Estimate", "State"], Location="best",Interpreter="latex")
end
% xlabel("Time [s]",Interpreter="latex")