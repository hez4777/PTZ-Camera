function z = measurement_cam(s, xT, xTdot)
% PT camera settings
% Cameara position / F
xC = [0, 0, 4]';
% Camera focal length
lambda = 4;

% Camera state
psi = s(1,1);
phi = s(2,1);
psiDot = s(3,1);
phiDot = s(4,1);

% Euler rotation matrices
R_phi = [1, 0, 0; 0, cos(phi), sin(phi); 0, -sin(phi), cos(phi)];
R_psi = [cos(psi), sin(psi), 0; -sin(psi), cos(psi), 0; 0, 0, 1];

% Target position / C
qT = R_phi*R_psi*([xT' 0]' - xC); % correction!
qx = qT(1,1);
qy = qT(2,1);
qz = qT(3,1);

% Target projection / VIP
pT = lambda*[qx/qz qy/qz]';
px = pT(1,1);
py = pT(2,1);

% Image Jacobian matrix
H = [-lambda/qz, 0, px/qz, px*py/lambda, -(lambda^2+px^2)/lambda, py;
    0, -lambda/qz, py/qz, (lambda^2+px^2)/lambda, -px*py/lambda, -px];

% Target projection speed / VIP
R_6 = [R_phi'*R_psi', zeros(3,3); zeros(3,3), -R_phi'];
pTdot = H*R_6*[xTdot', 0, phiDot, 0, psiDot]';

z = [pT(:);pTdot(:)];
end