function u = controller(z,s,delt,u_prev)
b1 = 100 * pi/180; % given [rad/Vs^2]
b2 = 100 * pi/180; % given [rad/Vs^2]
%lambda = 4; % given [m]

PandT = desired_angle(z, s);
delpsi = PandT(1,1) - s(1,1);
delphi = PandT(2,1) - s(2,1);

u_now1 = (delpsi/delt - s(3,1))/b1;
u_now2 = (delphi/delt - s(4,1))/b2;

u_now = [u_now1 u_now2]';

dudt = (u_now - u_prev)/delt;

kp1 = 0.3;
kp2 = 0.3;
kd1 = 0.03;
kd2 = 0.03;

u1 = kp1*u_now(1,1) + kd1*dudt(1,1);
u2 = kp2*u_now(2,1) + kd2*dudt(2,1);

% saturation
u1 = min(1, max(-1, u1));
u2 = min(1, max(-1, u2));

u = [u1 u2]';
end