%
% N-P model
%


function res = NPD(param)
%%
% run model:
%

n = param.n;
z = param.z;
% Initial conditions:
P0 = ones(param.n,1);
P0(floor(3*end/8):floor(5*end/8)) = 10;
N0 = 0.1*param.zBottom * ones(param.n,1);
D0 = 0*N0;

options = odeset('nonnegative', 1:2*param.n);
tic
[t, y] = ode23(@model3deriv, 0:820, [N0; P0; D0], options, param);
toc
res.N = y(:, 1:n);
res.P = y(:, n+1:2*n);
res.D = y(:, 2*n+1:end);

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