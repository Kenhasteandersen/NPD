function [g,L,gL,gN] = calcgrowth(N,P,param,t)

Lsurface = param.L0 * (1+param.Lamplitude*sin(t/365*2*pi));
L = Lsurface * exp(-param.kw*param.z -param.kp*cumsum(P)*param.dz) ;

gL = param.gmax*(param.alphaL*L./(param.alphaL*L + param.gmax));

gN = param.gmax*(param.alphaN*N./(param.alphaN*N + param.gmax));

g = min(gL, gN);
