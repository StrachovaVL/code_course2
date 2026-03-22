% Prog2.m - Страховая Виктория
% Замена элементов матрицы MM, выходящих за пределы [SR-8, SR+8]

% Предварительно в командном окне:
% MM = 10 + randn(5,7)*8;
% SR = sum(sum(MM)) / numel(MM);

for i = 1:5
    for j = 1:7
        if (MM(i, j) > (SR + 8))
            MM(i, j) = SR + 8;
        endif
        if (MM(i, j) < (SR - 8))
            MM(i, j) = SR - 8;
        endif
    endfor
endfor

disp("Матрица MM после замены выбросов:");
MM