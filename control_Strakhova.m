% control_Strakhova.m
% Контрольное задание: анализ столбцов 14-15 (финансирование и др.)
% Страховая Виктория, группа А-03-22

clear all;
close all;
clc;

disp("=========================================");
disp("Контрольное задание (столбцы 14-15)");
disp("Страховая Виктория, группа А-03-22");
disp("=========================================");

% Открытие файла для записи
fp1 = fopen('ppp_Strakhova.txt', 'w');

% Загрузка сохраненных результатов из первой части
struct = load('res_Strakhova.mat');
Res2 = struct.Res;
disp("Загружены результаты Res2 из res_Strakhova.mat");

% Загрузка исходных данных
YY = load('dan_vuz.txt');
disp("Размер YY:");
size(YY)

% Выделение столбцов 14-15
Y = YY(:, 14:15);
disp("Матрица Y (столбцы 14-15):");
Y(1:10, :)  % показываем первые 10 строк

% Метод главных компонент для Y
[vect1, lambda1] = eig(Y' * Y);
Sobst1 = diag(lambda1);
fprintf(fp1, '=== КОНТРОЛЬНОЕ ЗАДАНИЕ ===\n');
fprintf(fp1, 'Собственные значения для матрицы Y:\n');
for i = 1:length(Sobst1)
    fprintf(fp1, '%f\n', Sobst1(i));
end

% Наибольшее собственное значение
SobMax1 = Sobst1(end);
GlComp1 = vect1(:, end);
fprintf(fp1, '\nНаибольшее собственное значение: %f\n', SobMax1);
fprintf(fp1, 'Соответствующий собственный вектор:\n');
fprintf(fp1, '%f\n%f\n', GlComp1(1), GlComp1(2));

% Доля информации
Delt1 = 100 * SobMax1 / sum(Sobst1);
fprintf(fp1, '\nDelta1 = %.2f%%\n', Delt1);
fprintf(fp1, 'Res1= %f\n', Delt1);

% Оценки по главной компоненте Y
Res1 = Y * GlComp1;
fprintf(fp1, '\nОценки Res1 (главная компонента для Y):\n');
for i = 1:length(Res1)
    fprintf(fp1, 'Res1= %f\n', Res1(i));
end

% Корреляция Res1 с финансированием (столбец 2)
CorFin1 = corr(Res1, YY(:, 2));
fprintf(fp1, '\nCorrFin1 = %f\n', CorFin1);

% Корреляция Res1 с Res2 (результативность из первой части)
CorFin2 = corr(Res1, Res2);
fprintf(fp1, '\nCorrFin2 = %f\n', CorFin2);

fclose(fp1);
disp("Результаты контрольного задания записаны в файл ppp_Strakhova.txt");

% Дополнительный вывод в командное окно
fprintf('\n=== РЕЗУЛЬТАТЫ КОНТРОЛЬНОГО ЗАДАНИЯ ===\n');
fprintf('Delta1 = %.2f%%\n', Delt1);
fprintf('CorrFin1 = %f\n', CorFin1);
fprintf('CorrFin2 = %f\n', CorFin2);

disp("=========================================");
disp("Контрольное задание выполнено");
disp("=========================================");