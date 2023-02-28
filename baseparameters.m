function param = baseparameters()

%
% Parameters:
%

% Physical parameters:
param.D = 5;  % m2/day
param.zBottom = 100; % m
% Light
param.kp = 0.05;  % Light attenuation coefficient by phytoplankton (m^2/(mmol N)) (Beckmann & Hense)
param.L0 = 350; % Incident light at the surface (mmol photons/m^2/day)
param.Lamplitude = 0;
param.kw = 0.07;%  Light attenuation coefficient by sea water (1/m)
% Nutrients:
param.Nbottom = 30; % mmol N/m3
% Phytoplankton
param.w = 3; % Sinking velocity m/day
param.gmax = 1.5;  % maximum growth rate 1/day
param.alphaL = 0.075; % Light affinity 
param.alphaN = 5;  % Nutrient affinity 1/(mmol N/m3 day)
param.m = 0.25; % Mortality (per day)
% Detritus:
param.tau = 0.1; % per day  % Remineralization rate (1/day)
param.wD = 5; % Sinking rate per day 
% Numerical parameters:
param.n = 100; % no. of grid cells
param.dz = param.zBottom/param.n;

% Set up grid:
param.z = linspace(0,param.zBottom, param.n)';
