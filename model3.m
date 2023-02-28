%
% N-P model
%

%
% Parameters:
%

% Physical parameters:
param.D = 100;  % m2/day
param.zBottom = 100; % m
% Light
param.kp = 0.05;  % Light attenuation coefficient by phytoplankton (m^2/(mmol N)) (Beckmann & Hense)
param.L0 = 300; % Incident light at the surface (mmol photons/m^2/day)
param.Lamplitude = 0;
param.kw = 0.07;%  Light attenuation coefficient by sea water (1/m)
% Nutrients:
param.Nbottom = 10; % mmol N/m3
% Phytoplankton
param.w = 0; % m/day
param.gmax = 1;  % 1/day
param.alphaL = 1/20;  
param.alphaN = 1/0.3;  %1/(mmol N/m3 day)
param.m = 0.25;
param.epsilon = 0.15;
% Numerical parameters:
param.n = 100; % no. of grid cells
param.dz = param.zBottom/param.n;

% Set up grid:
param.z = linspace(0,param.zBottom, param.n)';

%%
% run model:
%

n = param.n;
z = param.z;
% Initial conditions:
P0 = ones(param.n,1);
P0(floor(3*end/8):floor(5*end/8)) = 10;
N0 = 0.1*param.zBottom * ones(param.n,1);

options = odeset('nonnegative', 1:2*param.n);
tic
[t, y] = ode45(@model3deriv, 0:820, [N0; P0], options, param);
toc
N = y(:, 1:n);
P = y(:, n+1:end);

%
%% Make plots:
%
figure(1)
clf
subplot(2,1,1)
surface(t,-z,N')
shading interp
ylabel('Depth (m)')
zlim([0 max(N(:))])
zlabel('N')
colorbar

subplot(2,1,2)
surface(t,-z,P')
shading interp
ylabel('Depth (m)')
zlim([0 max(P(:))])
zlabel('P')
xlabel('time (days)')
colorbar


figure(2)
subplot(1,3,1)
plot(P(end,:), -z,'g-', N(end,:),-z,'b-', "linewidth",2)
ylabel("Depth (m)")
xlabel("mmol N/m^3")

subplot(1,3,2)
[g,L,gL,gN] = model3calcgrowth(N(end,:)' ,P(end,:)',param, t(end));
plot(L, -z, "linewidth",2)
xlabel("mmol photons/m^2/day")

subplot(1,3,3)
plot(gL, -z,'y-',gN,-z,'b-',g,-z,'k--', "linewidth",2)
xlabel("Limiting factor")