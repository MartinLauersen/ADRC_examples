syms theta phi

Rx = [1 0 0; 
      0 cos(phi) -sin(phi);
      0 sin(phi) cos(phi)];
  
Ry = [cos(theta) 0 sin(theta);
      0 1 0;
      -sin(theta) 0 cos(theta)];
  
Rtot = Rx * Ry
R_simp = Rtot * [0 0 1]'

theta = 0;
phi = 0;

R_comp = subs(Rtot)
R_simp = subs(R_simp)

uav_pos = [0 0 -2]'

load_pos = uav_pos - R_comp * [0 0 -1]' * 0.7
load_pos = uav_pos - R_simp*0.7