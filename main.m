```matlab
%% SALES DATA ANALYSIS
% =========================================================
% Sales Data Analysis & Visualization
%
% This project demonstrates:
%   - CSV data import
%   - Statistical analysis
%   - Moving average calculation
%   - Data visualization
%   - Automatic report generation
%
% =========================================================

clear;
clc;
close all;

fprintf('============================================\n');
fprintf('       SALES DATA ANALYSIS PROJECT\n');
fprintf('============================================\n\n');


%% 1. LOAD DATA
% =========================================================

dataFile = 'data/sales_data.csv';

if ~isfile(dataFile)
    error('Data file not found: %s', dataFile);
end

data = readtable(dataFile);

fprintf('[+] Dataset loaded successfully.\n');
fprintf('[+] Number of records: %d\n\n', height(data));


%% 2. EXTRACT DATA
% =========================================================

months = string(data.Month);
sales = data.Sales;


%% 3. BASIC STATISTICS
% =========================================================

totalSales = sum(sales);

averageSales = mean(sales);

medianSales = median(sales);

minimumSales = min(sales);

maximumSales = max(sales);

standardDeviation = std(sales);


fprintf('---------------- STATISTICS ----------------\n');

fprintf('Total Sales:       €%.2f\n', totalSales);

fprintf('Average Sales:     €%.2f\n', averageSales);

fprintf('Median Sales:      €%.2f\n', medianSales);

fprintf('Minimum Sales:     €%.2f\n', minimumSales);

fprintf('Maximum Sales:     €%.2f\n', maximumSales);

fprintf('Standard Deviation: €%.2f\n', standardDeviation);

fprintf('---------------------------------------------\n\n');


%% 4. BEST AND WORST MONTH
% =========================================================

[maxSales, maxIndex] = max(sales);

[minSales, minIndex] = min(sales);

bestMonth = months(maxIndex);

worstMonth = months(minIndex);


fprintf('Best Month:  %s (€%.2f)\n', ...
    bestMonth, maxSales);

fprintf('Worst Month: %s (€%.2f)\n\n', ...
    worstMonth, minSales);


%% 5. MONTHLY GROWTH
% =========================================================

growth = zeros(size(sales));

for i = 2:length(sales)

    growth(i) = ...
        ((sales(i) - sales(i-1)) / sales(i-1)) * 100;

end


fprintf('--------------- MONTHLY GROWTH --------------\n');

for i = 2:length(sales)

    fprintf(
        '%-10s %8.2f%%\n', ...
        months(i), growth(i)
    );

end

fprintf('---------------------------------------------\n\n');


%% 6. MOVING AVERAGE
% =========================================================

windowSize = 3;

movingAverage = movmean(
    sales,
    windowSize
);


%% 7. CREATE FIGURES DIRECTORY
% =========================================================

figuresDirectory = 'figures';

if ~isfolder(figuresDirectory)
    mkdir(figuresDirectory);
end


%% 8. SALES TREND GRAPH
% =========================================================

figure('Name', 'Sales Trend');

plot(
    1:length(sales),
    sales,
    '-o',
    'LineWidth',
    2,
    'MarkerSize',
    6
);

hold on;

plot(
    1:length(sales),
    movingAverage,
    '--',
    'LineWidth',
    2
);

hold off;

grid on;

title('Monthly Sales Trend');

xlabel('Month');

ylabel('Sales (€)');

xticks(1:length(months));

xticklabels(months);

legend(
    'Monthly Sales',
    '3-Month Moving Average',
    'Location',
    'best'
);

saveas(
    gcf,
    fullfile(figuresDirectory, 'sales_trend.png')
);


%% 9. BAR CHART
% =========================================================

figure('Name', 'Monthly Sales');

bar(sales);

grid on;

title('Monthly Sales');

xlabel('Month');

ylabel('Sales (€)');

xticks(1:length(months));

xticklabels(months);

saveas(
    gcf,
    fullfile(figuresDirectory, 'monthly_sales.png')
);


%% 10. MONTHLY GROWTH GRAPH
% =========================================================

figure('Name', 'Monthly Growth');

bar(growth);

grid on;

title('Monthly Sales Growth');

xlabel('Month');

ylabel('Growth (%)');

xticks(1:length(months));

xticklabels(months);

yline(
    0,
    'k--',
    'LineWidth',
    1
);

saveas(
    gcf,
    fullfile(figuresDirectory, 'sales_growth.png')
);


%% 11. DISPLAY SUMMARY
% =========================================================

fprintf('================ SUMMARY ===================\n');

fprintf(
    'Total Sales:       €%.2f\n',
    totalSales
);

fprintf(
    'Average Sales:     €%.2f\n',
    averageSales
);

fprintf(
    'Best Month:        %s\n',
    bestMonth
);

fprintf(
    'Worst Month:       %s\n',
    worstMonth
);

fprintf(
    'Maximum Sales:     €%.2f\n',
    maximumSales
);

fprintf(
    'Minimum Sales:     €%.2f\n',
    minimumSales
);

fprintf('=============================================\n\n');

fprintf('[+] Analysis completed successfully.\n');

fprintf(
    '[+] Figures saved in: %s/\n',
    figuresDirectory
);
```
