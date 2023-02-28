function result = model2()

% Biological parameters:
D = 35;
kp = 0.05;  % Light attenuation coefficient by phytoplankton (m^2/(mmol N)) (Beckmann & Hense)
L0 = 350; % Incident light at the surface (mmol photons/m^2/day)
kw = 0.0375;%  Light attenuation coefficient by sea water (1/m)

w = 4; % m/day
gmax = 1;
alphaL = 1/15;
m = 0.25;

zBottom = 100; % m

% Numerical parameters:
n = 100; % no. of grid cells
dz = zBottom/n;

% Set up grid:
z = linspace(0,zBottom,n);

% Initial conditions:
P0 = ones(1,n);
P0(floor(3*end/8):floor(5*end/8)) = 10;

% Run model
options = odeset('nonnegative', ones(1,n));
[t, P] = ode45(@f, [0 40], P0, options);

% Make plots:
figure(1)
clf
surface(t,-z,P')
shading interp
xlabel('time (days)')
ylabel('Depth (m)')
zlim([0 max(P(:))])
zlabel('P')

figure(2)
subplot(1,3,1)
plot(P(end,:), -z)

subplot(1,3,2)
plot(calclight(P(end,:)'), -z)

subplot(1,3,3)
plot(calcgrowth(P(end,:)'), -z)

result.P = P;
result.z = z;

  function dPdt = f(t,P)
    %
    % Advective and diffusive fluxes:
    %
    Ja(2:n+1) = w*P;
    Ja(1) = 0;
    
    Jd(2:n) = -D/dz*(P(2:n) - P(1:n-1));
    Jd(1) = 0;
    Jd(n+1) = 0;
    
    J = Ja + Jd;
    %
    % Reaction:
    %
    g = calcgrowth(P);
    
    dPdt = -(J(2:n+1)- J(1:n))'/dz + g'.*P - m*P;
  end

  function L = calclight(P)
    L = L0 * exp(-kw*z -kp*cumtrapz(z,P)');
  end

  function g = calcgrowth(P)
    L = calclight(P);
    g = gmax*(alphaL*L./(alphaL*L + gmax));
  end

end
