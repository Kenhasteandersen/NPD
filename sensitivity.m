param = baseparameters;

alphaL = logspace(-1,-2,10);

clf

for i = 1:length(alphaL)
    param.alphaL = alphaL(i);
    result = NPD(param, 365);
    plot(result.P(end,:), -result.z, 'k','linewidth',i/3)
    hold on
end

xlabel('Phytoplankton (mmol N/m^3)')
ylabel('Depth (m)')
