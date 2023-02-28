function dydt = model3deriv(t,y,param)
n = param.n;

N = y(1:n);
P = y(n+1:end);
%
% Diffusive fluxes for nutrients:
%
Jd(2:n) = -param.D/param.dz*(N(2:n) - N(1:n-1));
Jd(1) = 0;
Jd(n+1) = param.D*(N(end) - param.Nbottom)/param.dz;

Jnutrients = Jd;

%
% Advective and diffusive fluxes for phytoplankton:
%
Ja(2:n+1) = param.w*P;
Ja(1) = 0;

Jd(2:n) = -param.D/param.dz*(P(2:n) - P(1:n-1));
Jd(1) = 0;
Jd(n+1) = 0;

Jphyto = Ja + Jd;


%
% Reaction:
%
g = model3calcgrowth(N,P, param,t);

dNdt = -(Jnutrients(2:n+1)- Jnutrients(1:n))'/param.dz ...
  -g.*P + param.epsilon*param.m*P;
dPdt = -(Jphyto(2:n+1)- Jphyto(1:n))'/param.dz ...
  + g.*P - param.m*P;

dydt = [dNdt; dPdt];
