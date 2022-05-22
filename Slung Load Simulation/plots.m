%% Clean up
close all; clc;

%% Plot drone and load position
figure("Name","Position")
t = tiledlayout("flow");
t.TileSpacing = "compact"
t.Padding = "compact"

ax1 = nexttile();
plot(out.states.Quadrotor.X)
hold on
plot(out.states.Load.X)
hold off
title("X Position")
grid on

ax2 = nexttile;
plot(out.states.Quadrotor.Y)
hold on
plot(out.states.Load.Y)
hold off
title("Y Position")
grid on

ax3 = nexttile;
plot(out.states.Quadrotor.Z)
hold on
plot(out.states.Load.Z)
hold off
title("Z Position")
grid on

legend(["Quadrotor", "Load"], Location="southeast")

title(t, "Quadrotor and Load position")
% xlabel(t, "Time (sec)")
linkaxes([ax1, ax2, ax3], 'x')
% xlim([10 20])

%% Plot devation of load from drone
figure("Name","Deviation")
t = tiledlayout(3,1);
t.TileSpacing = "compact";
t.Padding = "compact";

time = out.tout;
dev_x = out.states.Quadrotor.X.Data() - squeeze(out.states.Load.X.Data());
dev_y = out.states.Quadrotor.Y.Data() - squeeze(out.states.Load.Y.Data());
dev_z = out.states.Quadrotor.Z.Data() - squeeze(out.states.Load.Z.Data());

ax1 = nexttile;
plot(time, dev_x);

ax2 = nexttile;
plot(time, dev_y);

ax3 = nexttile;
plot(time, dev_z);

linkaxes([ax1, ax2, ax3], 'x')
% xlim([10 20])

%% 3D plot of drone and load
figure("Name","3D Position")

drone_pos = [out.states.Quadrotor.X.Data() out.states.Quadrotor.Y.Data() out.states.Quadrotor.Z.Data()]';
load_pos = [squeeze(out.states.Load.X.Data()) squeeze(out.states.Load.Y.Data()) squeeze(out.states.Load.Z.Data())]';

plot3(drone_pos(1,:), drone_pos(2,:), -drone_pos(3,:))
hold on
plot3(load_pos(1,:), load_pos(2,:), -load_pos(3,:))

lines_x = downsample([load_pos(1,:)' drone_pos(1,:)'],750)';
lines_y = downsample([load_pos(2,:)' drone_pos(2,:)'],750)';
lines_z = downsample([load_pos(3,:)' drone_pos(3,:)'],750)';
plot3(lines_x, lines_y, -lines_z, Color='#EDB120')
hold off

legend(["Drone", "Load"])

%% Plot all states
figure("Name","States")
t = tiledlayout(3,3);
t.TileSpacing = "compact"
t.Padding = "compact"

axes = [];
% Position
axes = [axes nexttile()];
plot(out.states.Quadrotor.X)
hold on
plot(out.states.Load.X)
hold off
title("X Position")
grid on

axes = [axes nexttile()];
plot(out.states.Quadrotor.Y)
hold on
plot(out.states.Load.Y)
hold off
title("Y Position")
grid on

axes = [axes nexttile()];
plot(out.states.Quadrotor.Z)
hold on
plot(out.states.Load.Z)
hold off
title("Z Position")
grid on

% Velocity
axes = [axes nexttile()];
plot(out.states.Quadrotor.vX)
hold on
plot(out.states.Load.vX)
hold off
title("X Velocity")
grid on

axes = [axes nexttile()];
plot(out.states.Quadrotor.vY)
hold on
plot(out.states.Load.vY)
hold off
title("Y Velocity")
grid on

axes = [axes nexttile()];
plot(out.states.Quadrotor.vZ)
hold on
plot(out.states.Load.vZ)
hold off
title("Z Velocity")
grid on

% Acceleration
axes = [axes nexttile()];
plot(out.states.Quadrotor.aX)
hold on
plot(out.states.Load.aX)
hold off
title("X Acceleration")
grid on

axes = [axes nexttile()];
plot(out.states.Quadrotor.aY)
hold on
plot(out.states.Load.aY)
hold off
title("Y Acceleration")
grid on

axes = [axes nexttile()];
plot(out.states.Quadrotor.aZ)
hold on
plot(out.states.Load.aZ)
hold off
title("Z Acceleration")
grid on


leg = legend(["Drone", "Load"], "Orientation","horizontal");
leg.Layout.Tile = 'north';

linkaxes(axes, 'x')
xlim([900 940])

%% FFT of drone and load
ts = out.tout(2)-out.tout(1);
fs = 1/ts;
L = length(out.tout)
f = floor(fs*(0:(L/2))/L);

Y = fft(out.states.Quadrotor.X.Data());
Y = abs(Y/L);
Y = Y(1:floor(L/2)+1);
Y(2:end-1) = 2*Y(2:end-1);
drone_fft = Y;

Y = fft(squeeze(out.states.Load.X.Data()));
Y = abs(Y/L);
Y = Y(1:floor(L/2)+1);
Y(2:end-1) = 2*Y(2:end-1);
load_fft = Y;

plot(f, drone_fft)
hold on
plot(f, load_fft)
hold off

f

xlim([0 1])