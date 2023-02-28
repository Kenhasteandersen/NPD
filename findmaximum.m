%
% Returns the maximum concentration (Pmax) and the depth of the maximum
% concentration (zmax).
% 
function [Pmax, zmax] = findmaximum(res)

[Pmax, imax] = max( res.P(end,:) );
zmax = -res.z(imax);