clear all; close all;

syms phi theta

Rx = [1 0 0; 
      0 cos(phi) -sin(phi);
      0 sin(phi) cos(phi)];

Ry = [cos(theta) 0 sin(theta);
      0 1 0;
      -sin(theta) 0 cos(theta)];

Rtot = Rx*Ry

%%
clc
phi = pi/2
theta = pi/2
x = -cos(phi)*sin(theta);
y = -sin(phi);
z = cos(phi)*cos(theta);

x_old = -sin(theta);
y_old = -cos(theta)*sin(phi);
z_old = cos(phi)*cos(theta);

fprintf("x1 = %4.2f \t x2 = %4.2f \n", x, x_old)
fprintf("y1 = %4.2f \t y2 = %4.2f \n", y, y_old)
fprintf("z1 = %4.2f \t z2 = %4.2f \n", z, z_old)

norm_new = sqrt(x^2 + y^2 + z^2)
norm_old = sqrt(x_old^2 + y_old^2 + z_old^2)


%%
clear all; clc;
syms dtheta theta dphi phi L

r = [dtheta*cos(theta)*cos(phi)-dphi*sin(theta)*sin(phi);
     dtheta*cos(theta)*sin(phi)+dphi*sin(theta)*cos(phi);
     -dtheta*sin(theta)]

%%
clear all; clc;
syms m_l m_c L g phi dphi theta dtheta x dx y dy z dz 

L = 1/2 * ((m_c + m_l)*(dx^2 + dy^2 + dz^2) + m_l*L^2*(dtheta^2 + dphi^2*cos(theta)^2))-g*(m_c + m_l)*z + g*m_l*L*cos(theta)*cos(phi);

disp("---------dL/dqi-------------")
L_pd_x = diff(L, x)
L_pd_y = diff(L, y)
L_pd_z = diff(L, z)
L_pd_phi = diff(L, phi)
L_pd_theta = diff(L, theta)
disp("---------dL/ddqi------------")
L_pd_dx = diff(L, dx)
L_pd_dy = diff(L, dy)
L_pd_dz = diff(L, dz)
L_pd_dphi = diff(L, dphi)
L_pd_dtheta = diff(L, dtheta)


%%
clear all; clc;
syms m_l m_c L g phi dphi theta dtheta x dx y dy z dz 

q = [x; y; z; phi; theta];
qd = [dx; dy; dz; dphi; dtheta];
M = [m_l+m_c 0 0 0 0;
     0 m_l+m_c 0 0 0;
     0 0 m_l+m_c 0 0;
     0 0 0 m_l*L^2*cos(theta) 0;
     0 0 0 0 m_l*L^2];

T = transpose(qd)*M*qd
