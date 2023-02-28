function dydt = NPDderiv(t,y,param)
n = param.n;

N = y(1:n);
P = y(n+1:2*n);
D = y(2*n+1:end);
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
% Advective and diffusive fluxes for detritus:
%
Ja(2:n+1) = param.wD*D;
Ja(1) = 0;

Jd(2:n) = -param.D/param.dz*(D(2:n) - D(1:n-1));
Jd(1) = 0;
Jd(n+1) = 0;

JD = Ja + Jd;
%
% Reaction:
%
g = calcgrowth(N,P, param,t);

dNdt = -(Jnutrients(2:n+1)- Jnutrients(1:n))'/param.dz ...
  -g.*P + param.tau*D;
dPdt = -(Jphyto(2:n+1)- Jphyto(1:n))'/param.dz ...
  + g.*P - param.m*P;
dDdt = -(JD(2:n+1)- JD(1:n))'/param.dz ...
  - param.tau*D + param.m*P;

dydt = [dNdt; dPdt; dDdt];
