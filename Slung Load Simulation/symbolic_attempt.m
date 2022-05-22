%% Clean up
clear; close all; clc;

%%
% states
syms x y z phi_l theta_l dx dy dz dphi_l dtheta_l ddx ddy ddz ddphi_l ddtheta_l

% inputs
syms fx fy fz

% constants
syms m_l m_c L g d

eta = transpose([x y z phi_l theta_l]);
nu = transpose([dx dy dz dphi_l dtheta_l]);
nu_dot = transpose([ddx ddy ddz ddphi_l ddtheta_l]);
tau = transpose([fx fy fz 0 0]);

M = [m_l+m_c            0                               0                                   0                               L*m_l*cos(theta_l);
     0                  m_l+m_c                         0                                   -L*m_l*cos(phi_l)*cos(theta_l)  L*m_l*sin(phi_l)*sin(theta_l);
     0                  0                               m_l+m_c                             -L*m_l*cos(theta_l)*sin(phi_l)  -L*m_l*cos(phi_l)*sin(theta_l);
     0                  -L*m_l*cos(phi_l)*cos(theta_l)  -L*m_l*cos(theta_l)*sin(phi_l)      L^2*m_l*cos(theta_l)^2          0;
     L*m_l*cos(theta_l) L*m_l*sin(phi_l)*sin(theta_l)   -L*m_l*cos(phi_l)*sin(theta_l)      0                               L^2*m_l];

C = [0 0 0 0                                                                        -L*dtheta_l*m_l*sin(theta_l);
     0 0 0 L*m_l*(dphi_l*cos(theta_l)*sin(phi_l)+dtheta_l*cos(phi_l)*sin(theta_l))  L*m_l*(dphi_l*cos(phi_l)*sin(theta_l)+dtheta_l*cos(theta_l)*sin(phi_l));
     0 0 0 -L*m_l*(dphi_l*cos(phi_l)*cos(theta_l)-dtheta_l*sin(phi_l)*sin(theta_l)) -L*m_l*(dtheta_l*cos(phi_l)*cos(theta_l)-dphi_l*sin(phi_l)*sin(theta_l));
     0 0 0 -0.5*L^2*dtheta_l*m_l*sin(2*theta_l)                                     -0.5*L^2*dphi_l*sin(2*theta_l);
     0 0 0 0.5*L^2*dphi_l*m_l*sin(2*theta_l)                                        0];

G = [0;
     0;
     -g*(m_l + m_c);
     L*g*m_l*cos(theta_l)*sin(phi_l);
     L*g*m_l*cos(phi_l)*sin(theta_l)];

D = diag([0, 0, 0, d, d]);

% eq1 = diff(eta) == nu
% eqn = M*diff(nu) + C*nu + G + D*nu == tau
% 
% dsolve(eqn)
% solve(M*nu_dot + C*nu + G + D*nu == tau, nu_dot)

simplify(M\(tau - C*eta - G - D*eta))
res = simplify(M*nu_dot + C*nu + G + D*nu)

M*nu_dot+C*nu

%% 
% T = 1/2*(m_c + m_l)*(dx^2 + dy^2 + dz^2) + 1/2*m_l*( ...
%     L^2*dtheta^2 + ...
%     2*L*dx*dtheta*cos(theta) + ...
%     L^2*dphi^2*cos(theta)^2 + ...
%     4*L^2*dtheta*dphi*sin(theta)*cos(theta)*sin(phi)*cos(phi) + ...
%     2*L*dtheta*sin(theta)*(dy*sin(phi)-dz*cos(phi)) + ...
%     2*L*dphi*cos(theta)*(dy*cos(phi)-dz*sin(phi)))

clc
T = 1/2*(m_c + m_l)*(dx^2 + dy^2 + dz^2) + 1/2*m_l*( ...
    L^2*dtheta^2 + ...
    2*L*dx*dtheta*cos(theta) + ...
    L^2*dphi^2*cos(theta)^2 + ...
    2*L*dtheta*sin(theta)*(dy*sin(phi)-dz*cos(phi)) - ...
    2*L*dphi*cos(theta)*(dy*cos(phi)+dz*sin(phi)))


dTdx = diff(T,x)
dTdy = diff(T,y)
dTdz = diff(T,z)
dTdtheta = diff(T,theta)
dTdphi = diff(T,phi)

dTddx = diff(T,dx)
dTddy = diff(T,dy)
dTddz = diff(T,dz)
dTddtheta = diff(T,dtheta)
dTddphi = diff(T,dphi)

%% Figuring out rotation matrices... again...  
syms x y z phi theta len
Rx = [1             0               0;
      0             cos(phi)       -sin(phi);
      0             sin(phi)        cos(phi)];

Ry = [cos(theta)    0               sin(theta);
      0             1               0;
      -sin(theta)   0               cos(theta)];

Rt = Rx*Ry;

R = Rx*Ry*[0 0 1]';

pos = [x; y; z;] - len*Rx*Ry*[0 0 1]'


%% Kinetic Energy 2.0
clear all; clc;

% states
syms x y z phi theta dx dy dz dphi dtheta ddx ddy ddz ddphi ddtheta
% constants
syms m_l m_c L g d

Rx = [1             0               0;
      0             cos(phi)       -sin(phi);
      0             sin(phi)        cos(phi)];

Ry = [cos(theta)    0               sin(theta);
      0             1               0;
      -sin(theta)   0               cos(theta)];

r = [x; y; z;] + L*Rx*Ry*[0 0 1]'

dr = [dx - L*dtheta*cos(theta);
      dy - L*dtheta*sin(theta)*sin(phi) + L*dphi*cos(theta)*cos(phi);
      dz + L*dtheta*sin(theta)*cos(phi) + L*dphi*cos(theta)*sin(theta)]

T = 1/2*m_c*(dx^2+dy^2+dz^2) + 1/2*m_l*transpose(dr)*dr
simplify(T)


%% Position Vectors
% clear all; clc;

% states
syms x y z phi psi theta dx dy dz dphi dtheta ddx ddy ddz ddphi ddtheta
% constants
syms m_l m_c L g d

Rx = [1             0               0;
      0             cos(phi)       -sin(phi);
      0             sin(phi)        cos(phi)];

Ry = [cos(theta)    0               sin(theta);
      0             1               0;
      -sin(theta)   0               cos(theta)];


disp("With normal rotation matrix (no -theta -phi)")
disp("[x; y; z;] + L*Rx*Ry*[0 0 1]' = ")
r = [x; y; z;] + L*Rx*Ry*[0 0 1]';
disp(r)
disp(" ")
disp("[x; y; z;] - L*Rx*Ry*[0 0 1]' = ")
r = [x; y; z;] - L*Rx*Ry*[0 0 1]';
disp(r)
disp(" ")
disp("[x; y; z;] + L*Rx*Ry*[0 0 -1]' = ")
r = [x; y; z;] + L*Rx*Ry*[0 0 -1]';
disp(r)
disp(" ")
disp("[x; y; z;] - L*Rx*Ry*[0 0 -1]' = ")
r = [x; y; z;] - L*Rx*Ry*[0 0 -1]';
disp(r)
disp(" ")
Rx = [1             0               0;
      0             cos(phi)       sin(phi);
      0             -sin(phi)        cos(phi)];

Ry = [cos(theta)    0               -sin(theta);
      0             1               0;
      sin(theta)    0                cos(theta)];

disp("With changed rotation matrix")
disp("[x; y; z;] + L*Rx*Ry*[0 0 1]' = ")
r = [x; y; z;] + L*Rx*Ry*[0 0 1]';
disp(r)
disp(" ")
disp("[x; y; z;] - L*Rx*Ry*[0 0 1]' = ")
r = [x; y; z;] - L*Rx*Ry*[0 0 1]';
disp(r)
disp(" ")
disp("[x; y; z;] + L*Rx*Ry*[0 0 -1]' = ")
r = [x; y; z;] + L*Rx*Ry*[0 0 -1]';
disp(r)
disp(" ")
disp("[x; y; z;] - L*Rx*Ry*[0 0 -1]' = ")
r = [x; y; z;] - L*Rx*Ry*[0 0 -1]';
disp(r)
disp(" ")

%%

% states
syms x y z phi psi theta dx dy dz dphi dtheta ddx ddy ddz ddphi ddtheta

A = [cos(theta)*cos(psi) -cos(phi)*sin(psi)+sin(phi)*sin(theta)*cos(psi) sin(phi)*sin(psi)+cos(phi)*sin(theta)*cos(psi);
     cos(theta)*sin(psi) cos(phi)*cos(psi) + sin(phi)*sin(theta)*sin(psi) -sin(phi)*cos(psi)+cos(phi)*sin(theta)*sin(psi);
     -sin(theta) sin(phi)*cos(theta) cos(psi)*cos(theta)]
subs(A, psi, 0)
Rx = [1             0               0;
      0             cos(phi)       sin(phi);
      0             -sin(phi)        cos(phi)];

Ry = [cos(theta)    0               -sin(theta);
      0             1               0;
      sin(theta)   0               cos(theta)];
Rx*Ry
Ry*Rx*[0 0 1]'

%%
 R1 = [cos(theta), sin(phi)*sin(theta), cos(phi)*sin(theta);
      0,            cos(phi),           -sin(phi);
      -sin(theta), cos(theta)*sin(phi),          cos(theta)]

 R1*[0 0 -1]'

 R2 = [cos(theta), -sin(phi)*-sin(theta), -cos(phi)*sin(theta);
      0,            cos(phi),           sin(phi);
      sin(theta), -cos(theta)*sin(phi),          cos(theta)]

 R2*[0 0 -1]'

 %%
 
%  x4 + 4*zeta*x3 + (2+4*zeta^2)*omega^2*x2 + 4*zeta*omega^3 + omega^4*x 

zeta = 1;
omega = 2;

 k4 = 4*zeta*omega
 k3 = (2+4*zeta^2)*omega^2/k4
 k2 = 4*zeta*omega^3/(k4*k3)
 k1 = omega^4/(k4*k3*k2)

 t1 = min(k1*(x))