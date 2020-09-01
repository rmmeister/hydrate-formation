function sumError = getHydratePressure (y, T, p)

A0 = [1.63636 6.41934 -7.8499 -2.17137 -37.211 1.78857 9.0242 -4.7071];
A1 = [0 0 0 0 .86564 0 0 .06192];
A2 = [0 0 0 0 0 -0.001356 0 0];
A3 = [31.6621 -290.283 47.056 0 732.20 -6.187 -207.033 82.627];
A4 = [-49.3534 2629.10 0 0 0 0 0 0];
A5 = [-5.31e-6 0 -1.17e-6 0 0 0 4.66e-5 -7.39e-6];
A6 = [0 0 7.145e-4 1.251e-3 0 0 -6.992e-3 0];
A7 = [0 -9e-8 0 1e-8 9.37e-6 2.5e-7 -2.89e-6 0];
A8 = [0.128525 0.129759 0 0.166097 -1.07657 0 -6.223e-3 0.240869];
A9 = [-0.78338 -1.19703 0.12348 -2.75945 0 0 0 -0.64405];
A10 = [0 -8.46e4 1.669e4 0 0 0 0 0];
A11 = [0 -71.0352 0 0 -66.221 0 0 0];
A12 = [0 .596404 .23319 0 0 0 .27098 0];
A13 = [-5.3569 -4.7437 0 0 0 0 0 -12.704];
A14 = [0 7.82e4 -4.48e4 -8.84e2 9.17e5 5.87e5 0 0];
A15 = [-2.3e-7 0 5.5e-6 0 0 0 8.82e-5 -1.3e-6];
A16 = [-2e-8 0 0 -5.4e-7 4.98e-6 1e-8 2.55e-6 0];
A17 = [0 0 0 -1e-8 -1.26e-6 1.1e-7 0 0];

for i = 1:length(y)
    K(i) = exp(A0(i) + A1(i)*T + A2(i)*p + A3(i)/T + A4(i)/p + A5(i)*p*T + A6(i)*T^2 + A7(i)*p^2 + A8(i)*p/T + A9(i)*log(p/T) ...
        + A10(i)/p^2 + A11(i)*T/p + A12(i)*T^2/p + A13(i)*p/T^2 + A14(i)*T/p^3 + A15(i)*T^3 + A16(i)*p^3/T^2 + A17(i)*T^4);
end
summation = sum(y./K);
sumError = abs(summation - 1);

end