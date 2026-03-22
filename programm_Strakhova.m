% programm_Strakhova.m
% Тема 2. Метод главных компонент (расширенная версия с записью в файл)
% Страховая Виктория, группа А-03-22

clear all;
close all;
clc;

% Открытие файла для записи результатов
fp = fopen('prtcl_Strakhova.txt', 'w');

% Загрузка данных
XX = load('dan_vuz.txt');
fprintf(fp, '=== ДАННЫЕ О ВУЗАХ ===\n');
fprintf(fp, 'Размер матрицы XX: %d x %d\n', size(XX, 1), size(XX, 2));
fprintf(fp, 'Количество вузов: %d\n', size(XX, 1));

% Выделение показателей результативности
X = XX(:, 3:13);
fprintf(fp, '\n=== ПОКАЗАТЕЛИ РЕЗУЛЬТАТИВНОСТИ ===\n');
fprintf(fp, 'Матрица X: %d x %d (11 показателей)\n', size(X, 1), size(X, 2));

% Матрица корреляций
R = corr(X);
fprintf(fp, '\n=== МАТРИЦА КОРРЕЛЯЦИЙ ===\n');
for i = 1:size(R, 1)
    for j = 1:size(R, 2)
        fprintf(fp, '%8.4f ', R(i, j));
    end
    fprintf(fp, '\n');
end

% Метод главных компонент
[vect, lambda] = eig(X' * X);
Sobst = diag(lambda);

% Вывод собственных значений
fprintf(fp, '\n=== СОБСТВЕННЫЕ ЗНАЧЕНИЯ ===\n');
for i = 1:length(Sobst)
    fprintf(fp, '%f\n', Sobst(i));
end

% Наибольшее собственное значение
SobMax = Sobst(end);
GlComp = vect(:, end);
fprintf(fp, '\n=== ГЛАВНАЯ КОМПОНЕНТА ===\n');
fprintf(fp, 'Наибольшее собственное значение: %f\n', SobMax);
fprintf(fp, 'Соответствующий собственный вектор:\n');
for i = 1:length(GlComp)
    fprintf(fp, '%f\n', GlComp(i));
end

% Доля информации
Delt = 100 * SobMax / sum(Sobst);
fprintf(fp, '\n=== ДОЛЯ ИНФОРМАЦИИ ===\n');
fprintf(fp, 'Delta = %.2f%%\n', Delt);
fprintf(fp, 'Delta (округленно) = %d%%\n', round(Delt));

% Оценки результативности
Res = X * GlComp;

% Вывод результатов
fprintf(fp, '\n=== РЕЗУЛЬТАТЫ (номер вуза - оценка) ===\n');
fprintf(fp, 'Results:\n');
for i = 1:length(Res)
    fprintf(fp, '%d  %f\n', XX(i, 1), Res(i));
end

% Сохранение результатов
save res_Strakhova.mat Res -mat;
fprintf(fp, '\nРезультаты сохранены в файл res_Strakhova.mat\n');

% Гистограмма
figure(1);
hist(Res, 20);
xlabel('Results (оценка результативности)');
ylabel('Number of Universities');
title('Гистограмма распределения оценок результативности вузов');
grid on;
saveas(gcf, 'Hist_Strakhova.jpg', 'jpg');
fprintf(fp, 'Гистограмма сохранена в файл Hist_Strakhova.jpg\n');

% Корреляция с финансированием
CorFin = corr(Res, XX(:, 2));
fprintf(fp, '\n=== КОРРЕЛЯЦИЯ ===\n');
fprintf(fp, 'Correlation of Results and Money = %f\n', CorFin);

% Статистика
fprintf(fp, '\n=== СТАТИСТИКА ===\n');
fprintf(fp, 'min(Res) = %f\n', min(Res));
fprintf(fp, 'max(Res) = %f\n', max(Res));
fprintf(fp, 'mean(Res) = %f\n', mean(Res));
fprintf(fp, 'std(Res) = %f\n', std(Res));

fclose(fp);
disp("Результаты записаны в файл prtcl_Strakhova.txt");