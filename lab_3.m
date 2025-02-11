eps = 10^(-4);

x1 = -5:0.01:2;
x2 = x1;

f1 = cos(x1 + 0.5) + x2 - 0.8;
f2 = -2 .* x1 + sin(x2) - 1.6;


% 1.1
g1 = acos(0.8 - x2) + 0.5;
g2 = (1.6 - sin(x2)) ./ (-2);

figure();
plot(x1, g1, x2, g2);
xlabel('x1');
ylabel('x2');
title('Графики функций: g1 и g2');
grid on;
legend("g1", "g2");


% 1.2
phi1 = -cos(x1 + 0.5) + 0.8;
phi2 = (1.6 - sin(x2)) ./ (-2);

% 1.3
x1_0 = 0;
x2_0 = 0;

for k = 1:100
    x1_next = (1.6 - sin(x2_0)) ./ (-2);
    x2_next = -cos(x1_0 + 0.5) + 0.8;

    if abs(x1_next - x1_0) < eps && abs(x2_next - x2_0) < eps
        break;
    end

    x1_0 = x1_next;
    x2_0 = x2_next;
end

fprintf('Сошлось к (%f, %f)\n', x1_0, x2_0);
fprintf('\n\n');

J = [ 
        -sin(x1 + 0.5),  1
        -2            ,  cos(x2) 
    ];
q = norm(J);


% 1.4
eps_0 = ((1 - q) / q) * eps;