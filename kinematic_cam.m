function s_next =  kinematic_cam(s_k, u_k, delt)
% Given constraint in the problem
psiDot_m = 100 * pi/180; % given [rad/s]
phiDot_m = 100 * pi/180; % given [rad/s]
b1 = 100 * pi/180; % given [rad/Vs^2]
b2 = 100 * pi/180; % given [rad/Vs^2]

% state-space form
A = [1,0,delt,0; 0,1,0,delt; 0,0,1,0; 0,0,0,1];
B = [0,0; 0,0; b1,0; 0,b2];

s_next_raw = A*s_k + B*u_k;

% constraint vectors
b1_vec = [0, pi/2, -psiDot_m, -phiDot_m]';
b2_vec = [2*pi, pi, psiDot_m, phiDot_m]';

% saturation
s_next = min(b2_vec, max(b1_vec, s_next_raw));

end