function result = model1()

% Biological parameters:
w = 1; % m/day
D = 5;
zBottom = 100; % m

% Numerical parameters:
n = 100; % no. of grid cells
dz = zBottom/n;

% Set up grid:
z = linspace(0,zBottom,n);

% Initial conditions:
P0 = zeros(1,n);
P0(floor(3*end/8):floor(5*end/8)) = 10;

[t, P] = ode45(@f, [0 120], P0);

clf
surface(t,-z,P')
shading interp
xlabel('time (days)')
ylabel('Depth (m)')
zlim([0 max(P(:))])
zlabel('P')


  function dPdt = f(t,P)
    Ja(2:n+1) = w*P;
    Ja(1) = 0;
    
    Jd(2:n) = -D/dz*(P(2:n) - P(1:n-1));
    Jd(1) = 0;
    Jd(n+1) = 0;
    
    J = Ja + Jd;
    
    dPdt = -(J(2:n+1)- J(1:n))'/dz;
  end
end
