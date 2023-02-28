%
% N-P-D model
%
function res = NPD(param, tEnd)
n = param.n;
z = param.z;
%
% Initial conditions:
%
P0 = ones(param.n,1);
P0(floor(3*end/8):floor(5*end/8)) = 10;
N0 = 0.1*param.zBottom * ones(param.n,1);
D0 = 0*N0;
%
% run model:
%
options = odeset('nonnegative', 1:3*param.n);
tic
[t, y] = ode23(@NPDderiv, 0:tEnd, [N0; P0; D0], options, param);
toc
%
% Assemble result:
%
res.N = y(:, 1:n);
res.P = y(:, n+1:2*n);
res.D = y(:, 2*n+1:end);
res.t = t;
res.p = param;
res.z = param.z;

