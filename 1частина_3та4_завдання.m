clc;
clear;
close all;

% Вхідні дані (3-елементні вектори, кожен стовпчик — вхід)
P = [-3 -3 -3 -3 -3  3  3  3;
     -3 -3  3  3 -3  3  3 -3;
     -3  3 -3  3  3 -3  3  3];

% Цільові класи
T = [0 0 1 1 0 1 1 1];

% Створення одношарового персептрона
net = perceptron;
net.trainParam.epochs = 20;  % Кількість епох


% Навчання мережі
net = train(net, P, T);

% Отримання результатів класифікації
Y = net(P);

% Вивід результатів у консоль
disp('--- Результати класифікації ---');
disp('      Вхідний вектор         Ціль     Результат');
for i = 1:size(P, 2)
    fprintf('[%4d %4d %4d]            %d         %d\n', ...
        P(1, i), P(2, i), P(3, i), T(i), Y(i));
end

% Побудова графіку у 3D
figure;
hold on;
for i = 1:size(P,2)
    if T(i) == 0
        plot3(P(1,i), P(2,i), P(3,i), 'ro', 'MarkerSize', 10, 'DisplayName', 'Клас 0');
    else
        plot3(P(1,i), P(2,i), P(3,i), 'bx', 'MarkerSize', 10, 'DisplayName', 'Клас 1');
    end
end

% Побудова площини розділення
w = net.IW{1};  % ваги
b = net.b{1};   % зсув
[x, y] = meshgrid(-4:1:4, -4:1:4);  % сітка
z = -(w(1)*x + w(2)*y + b)/w(3);   % площина з рівняння w1*x + w2*y + w3*z + b = 0

surf(x, y, z, 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'DisplayName', 'Гіперплощина');

xlabel('x1'); ylabel('x2'); zlabel('x3');
title('Класифікація тривимірних даних (Варіант 1)');
legend({'Клас 0', 'Клас 1', 'Гіперплощина'});
grid on;
view(3);
hold off;
