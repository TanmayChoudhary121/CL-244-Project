tolerances=[10^-8,10^-7,10^-6,10^-5,10^-4];
time_rk3=[1.4843,0.7218,0.4969,0.3352,0.2627];
time_am3=[1.6254,1.2311,1.0132,0.9128,0.8322];
hold on
plot(tolerances,time_rk3);
plot(tolerances,time_am3);
legend('RK3','AM3')
title('Time complexity of RK3 & AM3 for different relative tolerances')
xlabel('Relative Tolerances')
ylabel('Time in seconds')
grid()