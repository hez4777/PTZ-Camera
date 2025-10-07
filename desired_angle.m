function PandT = desired_angle(z, s)
lambda = 4;

% Find the coordinates in inertial frame
px = z(1,1);
py = z(2,1);

psi = s(1,1);
phi = s(2,1);

R_phi = [1, 0, 0; 0, cos(phi), sin(phi); 0, -sin(phi), cos(phi)];
R_psi = [cos(psi), sin(psi), 0; -sin(psi), cos(psi), 0; 0, 0, 1];

C = [R_phi(3,:)*R_psi(:,1), R_phi(3,:)*R_psi(:,2), R_phi(3,:)*R_psi(:,3)];
P = [px, py, lambda]';

k = -lambda/(C*P);

xT_recon = k*R_psi'*R_phi'*[px py lambda]' - [0,0,-lambda]';


% Calcuate desired pan and tilt angle
pan = pi/2 + atan2(xT_recon(2,1),xT_recon(1,1));
tilt = pi/2 + atan2(4,sqrt(xT_recon(1,1)^2+xT_recon(2,1)^2));

PandT = [pan, tilt]';

end