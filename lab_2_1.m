A = [-13, 80, 2, 0;
     64, 9, 0, -5;
     0, 12, -9, 128;
     0, 27, 100, 3];

b = [64; 29; 0; 231];

% Шаг 1: Решение системы Ax = b с помощью встроенной функции
x_exact = A\b;

disp('Решение системы Ax = b:');
disp(x_exact);

% Шаг 2: Приведение матрицы A к диагональному преобладанию
n = size(A, 1); % size(A, 1) возвращает количество строк в матрице A.
                % size(A, 2) возвращает количество столбцов в матрице A.

for i = 1:n
    for j = i+1:n
        if abs(A(i,i)) < sum(abs(A(i,:))) - abs(A(i,i))
            A([i j], :) = A([j i], :); % : - Двоеточие : означает "все столбцы". Таким образом, A(:, :) выбирает все элементы
            b([i j]) = b([j i]);
        end
    end
end

disp('Матрица A с диагональным преобладанием:');
disp(A);
disp('Вектор b после перестановок:');
disp(b);

% Шаг 3: Проверка, что решение Ax1 = b1 совпадает с решением Ax = b
x1 = A\b;

disp('Решение системы Ax1 = b1:');
disp(x1);

if norm(x_exact - x1) < 1e-4 % norm - вычисляет норму вектора
    disp('Решения совпадают с заданной точностью.');
else
    disp('Решения не совпадают.');
end

% Шаг 4: Реализация метода простой итерации
epsilon = 1e-4;
max_iter = 100;
x_iter = zeros(n, 1);
results_table = zeros(max_iter, n + 1);

for k = 1:max_iter
    x_prev = x_iter;

    for i = 1:n
        % Метод простой итерации: вычисляем x_i
        x_iter(i) = (b(i) - A(i, [1:i-1, i+1:n]) * x_iter([1:i-1, i+1:n])) / A(i,i);
    end

    results_table(k, 1:n) = x_iter;
    results_table(k, n + 1) = norm(x_iter - x_prev);

    if norm(x_iter - x_prev) < epsilon
        disp(['Решение достигнуто на итерации: ', num2str(k)]);
        break;
    end
end

% Шаг 5: Определение номера итерации, на которой достигнута заданная точность
iteration_reached = find(results_table(:, n + 1) < epsilon, 1); % "1" - вернуть первое найденное значение
if ~isempty(iteration_reached)
    disp(['Номер итерации, на которой достигнута заданная точность: ', num2str(iteration_reached)]);
else
    disp('Заданная точность не была достигнута.');
end

% Шаг 6: Выписка решения системы x*, соответствующей найденному номеру итерации
if ~isempty(iteration_reached)
    x_star = results_table(iteration_reached, 1:n)';
    disp('Соответствующее решение x*:');
    disp(x_star);
end

% Шаг 7: Вычисление невязки R = Ax* - b
if ~isempty(iteration_reached)
    R = A * x_star - b;
    disp('Невязка R = Ax* - b:');
    disp(R);
end

% Визуализация результатов
disp('Таблица результатов итераций:');
disp('Номер итерации | x1_i | x2_i | x3_i | x_i - x_(i-1)');
disp([(1:k)', results_table(1:k, :)]);