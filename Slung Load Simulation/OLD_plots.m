close all;

%% Format data
t = out.tout;
x = squeeze(out.states.Position.X.Data());
y = squeeze(out.states.Position.Y.Data());
z = squeeze(out.states.Position.Z.Data());
phi = squeeze(out.states.Position.Phi.Data());
theta = squeeze(out.states.Position.Theta.Data());

% For "plotTransform()"
translations = [x y z];
rotations = eul2quat(zeros(length(x),3));
load_pos_x = squeeze(out.estimate.Position.X.Data());
load_pos_y = squeeze(out.estimate.Position.Y.Data());
load_pos_z = squeeze(out.estimate.Position.Z.Data());

%% Plot position of load relative to UAV
% figure(1)
% tiledlayout(3,1)
% 
% nexttile;
% plot(t,x)
% hold on
% plot(t,load_pos_x)
% hold off
% legend("Quadcopter", "Load")
% 
% nexttile;
% plot(t,y)
% hold on
% plot(t,load_pos_y)
% hold off
% 
% nexttile;
% plot(t,z)
% hold on
% plot(t,load_pos_z)
% hold off

%% Plot position in 3D
index = 150;
lines_x = downsample([load_pos_x x],750)';
lines_y = downsample([load_pos_y y],750)';
lines_z = downsample([load_pos_z z],750)';

figure(2);
plot3(x, y, z)
hold on
plot3(load_pos_x,load_pos_y,load_pos_z)
plot3(lines_x, lines_y, lines_z, Color='#EDB120')
hold off

grid on
xlabel("X (m)");
ylabel("Y (m)")
zlabel("Z (m)")
view(45, 45);
legend(["Quadcopter", "Load", "Cable"]);

ax = gca;
ax.ZDir = 'reverse';

% ylim([100 105])

%% Plot Y Position of load and UAV
figure(3);
ds = 500;
time = downsample(t,ds);
yd = downsample(y, ds);
yld = downsample(load_pos_y, ds);

plot(time, yd, '-o')
hold on
plot(time, yld, '-x')
hold off

grid on
legend(["Quadcopter", "Load"]);
xlim([29 40])

%% Plot X Position of load and UAV
figure(4);
ds = 500;
time = downsample(t,ds);
yd = downsample(x, ds);
yld = downsample(load_pos_x, ds);

plot(time, yd, '-o')
hold on
plot(time, yld, '-x')
hold off

grid on
legend(["Quadcopter", "Load"]);
% xlim([20 40])

%% Plot load angle
figure(5);
plot(t, rad2deg(theta));
hold on
plot(t, rad2deg(phi));
hold off
legend(["Theta", "Phi"]);
ylabel("Degrees")
xlabel("Time")
grid on