% Дані (Варіант 1)
X = [ 0.1  1.2;
      0.7  1.8;
     -0.8  1.3;
     -0.5  0.7;
     -0.3  0.6;
      0.8  0.1;
     -0.2 -0.3;
     -0.5 -0.8;
     -1.5 -1.3;
      0.0  0.0];

Y = [1 0;
     1 0;
     1 0;
     1 1;
     1 1;
     1 1;
     0 1;
     0 1;
     0 1;
     0 0];

% === Створення нейронної мережі ===
net = patternnet(6);  % 6 нейронів у прихованому шарі
net.trainParam.showWindow = true;  % показати GUI тренування
net = train(net, X', Y');

% === Класифікація ===
predicted_output = net(X');
target_classes = bi2de(Y, 'left-msb') + 1;
predicted_classes = bi2de(round(predicted_output)', 'left-msb') + 1;

disp('Цільові класи:');
disp(target_classes');

disp('Результати класифікації:');
disp(predicted_classes');

% === Графік з розфарбованими зонами ===
[x1Grid, x2Grid] = meshgrid(-2:0.05:2, -2:0.05:2);
gridX = [x1Grid(:), x2Grid(:)]';
gridY = net(gridX);
classMap = bi2de(round(gridY)', 'left-msb') + 1;

% Побудова зони класифікації
figure;
h_bg = gscatter(gridX(1,:), gridX(2,:), classMap, ...
     [0.9 0.7 0.7; 0.7 0.9 0.7; 0.7 0.7 0.9; 0.9 0.9 0.6], '.', 1);
hold on;

% Побудова точок вхідних даних
trueClass = bi2de(Y, 'left-msb') + 1;
h_data = scatter(X(:,1), X(:,2), 100, trueClass, 'filled', 'MarkerEdgeColor','k');

legend([h_bg; h_data], ...
       {'Клас 1 [1;0]', 'Клас 2 [1;1]', 'Клас 3 [0;1]', 'Клас 4 [0;0]', 'Реальні дані'});

title('Розподіл простору входів нейронною мережею');
xlabel('X_1');
ylabel('X_2');
axis equal;
grid on;
