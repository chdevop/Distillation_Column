%% Step 1: Load Data
data = readtable('/MATLAB Drive/Distillation_Column_Project/Distillation Column Dataset.csv');

% Display first few rows and summary
disp(head(data));
summary(data);

%% Step 2: Handle Missing Values
data_clean = rmmissing(data);
fprintf('Removed %d rows with missing values.\n', height(data) - height(data_clean));

% Step 3: Identify constant columns
constant_cols = [];
col_names = data.Properties.VariableNames;

for i = 1:width(data)
    col_data = data{:, i};
    
    % Skip non-numeric columns
    if isnumeric(col_data) && all(col_data == col_data(1))
        constant_cols = [constant_cols, i];
        fprintf('Column "%s" is constant (Value: %g)\n', col_names{i}, col_data(1));
    end
end

% Step 3: Remove constant columns
if ~isempty(constant_cols)
    data(:, constant_cols) = [];
    fprintf('Removed %d constant column(s).\n', numel(constant_cols));
else
    fprintf('No constant columns found.\n');
end

%% Step 4: Select Features and Target

X_raw = data_clean{:, 1:16}; 
y = data_clean.MoleFractionTX;

%% Step 5: Visualize Distributions (Before Scaling)

figure;
for i = 1:16
    subplot(4, 4, i);
    histogram(X_raw(:, i));
    title(sprintf('Sensor%d', i));
end
sgtitle('Feature Distributions Before Scaling');

%% Step 6: Normalize Features (Z-Score Standardization)

mu = mean(X_raw);
sigma = std(X_raw);
X = (X_raw - mu) ./ sigma;

%% Step 7: Train-Test Split

cv = cvpartition(size(X,1), 'HoldOut', 0.2);
X_train = X(training(cv), :);
y_train = y(training(cv), :);
X_test = X(test(cv), :);
y_test = y(test(cv), :);

%% Step 8: Train Linear Regression Model

mdl = fitlm(X_train, y_train);
disp(mdl);

%% Step 8: Predict on Test Data
y_pred = predict(mdl, X_test);

%% Step 9: Evaluate Model
% R-squared (custom)

SS_res = sum((y_test - y_pred).^2);
SS_tot = sum((y_test - mean(y_test)).^2);
r2 = 1 - (SS_res / SS_tot);

% Mean Absolute Error

mae = mean(abs(y_test - y_pred));

fprintf('\nModel Performance:\n');
fprintf('R² Score: %.4f\n', r2);
fprintf('Mean Absolute Error: %.4f\n', mae);

%% Step 10: Visualization – Actual vs Predicted

figure;
scatter(y_test, y_pred, 'filled');
xlabel('Actual MoleFraction\_TX');
ylabel('Predicted MoleFraction\_TX');
title('Actual vs Predicted - Linear Regression');
grid on;
hold on;
plot([min(y_test), max(y_test)], [min(y_test), max(y_test)], 'r--', 'LineWidth', 1.5);
hold off;

%% Step 11: Visualization – Residuals

residuals = y_test - y_pred;
figure;
histogram(residuals, 20);
xlabel('Residual');
ylabel('Frequency');
title('Residuals Distribution');

