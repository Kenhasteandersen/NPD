function plotNPD(res)
N = res.N;
P = res.P;
z = res.p.z;
t = res.t;
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
[g,L,gL,gN] = calcgrowth(N(end,:)' ,P(end,:)',res.p, t(end));
plot(L, -z, "linewidth",2)
xlabel("mmol photons/m^2/day")

subplot(1,3,3)
plot(gL, -z,'y-',gN,-z,'b-',g,-z,'k--', "linewidth",2)
xlabel("Limiting factor")