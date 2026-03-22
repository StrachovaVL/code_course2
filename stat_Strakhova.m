% stat_Strakhova.m
% Статистический анализ результатов
% Страховая Виктория, группа А-03-22

clear all;

% Загрузка данных
XX = load('dan_vuz.txt');
load('res_Strakhova.mat');

disp("=========================================");
disp("Статистический анализ результатов");
disp("Страховая Виктория, группа А-03-22");
disp("=========================================");

% Статистика для Res
fprintf('\n=== СТАТИСТИКА ОЦЕНОК РЕЗУЛЬТАТИВНОСТИ (Res) ===\n');
fprintf('Минимальное значение: %f\n', min(Res));
fprintf('Максимальное значение: %f\n', max(Res));
fprintf('Среднее значение: %f\n', mean(Res));
fprintf('Стандартное отклонение: %f\n', std(Res));
fprintf('Медиана: %f\n', median(Res));

% Квартили
q = quantile(Res, [0.25, 0.5, 0.75]);
fprintf('\nКвартили:\n');
fprintf('  1-й квартиль (25%%): %f\n', q(1));
fprintf('  2-й квартиль (50%%): %f\n', q(2));
fprintf('  3-й квартиль (75%%): %f\n', q(3));

% Гистограмма с настройками
figure(2);
hist(Res, 20);
xlabel('Results (оценка результативности)');
ylabel('Number of Universities');
title('Гистограмма распределения оценок (Страховая В.)');
grid on;
saveas(gcf, 'Hist_Strakhova_detail.jpg', 'jpg');

% Boxplot для наглядности
figure(3);
boxplot(Res);
ylabel('Results');
title('Ящичковая диаграмма оценок результативности');
grid on;
saveas(gcf, 'Boxplot_Strakhova.jpg', 'jpg');

disp("Графики сохранены:");
disp("  - Hist_Strakhova_detail.jpg");
disp("  - Boxplot_Strakhova.jpg");
disp("=========================================");