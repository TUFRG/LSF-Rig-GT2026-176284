clear; clc; close all;

% Number of blades / tuned system modes to evaluate
N = 25;

% Preallocate matrix to store tuned system mode results
% Row 1 = bending mode result
% Row 2 = torsional mode result
% Columns correspond to each nodal diameter / blade index
TSM = zeros(2, N);

% Loop through each nodal diameter from 0 to N-1
for r = 0:N-1

    % Compute the tuned system mode for nodal diameter r
    % TunedSystemMode_TUFRG should return a 2x1 complex vector
    % containing bending and torsional eigenvalues
    TSM(:, r+1) = TunedSystemMode_TUFRG(r, N); % change variables within this script

end

%% Extract real and imaginary components

% Bending mode eigenvalue components
x_b = real(TSM(1,:));   % Real part of bending mode
y_b = imag(TSM(1,:));   % Imaginary part of bending mode

% Torsional mode eigenvalue components
x_t = real(TSM(2,:));   % Real part of torsional mode
y_t = imag(TSM(2,:));   % Imaginary part of torsional mode


%% Plot bending mode eigenvalues

figure;

% Plot bending mode eigenvalues in the complex plane
plot(x_b, y_b, '-o', 'LineWidth', 1.0);

xlabel('Real Part');
ylabel('Imaginary Part');

% Optional reference line or axis limits
% line([0 0], [0.10 0.15])
% xlim([-0.05 0]);
% ylim([0 0.08]);

% Keep equal scaling on both axes so circular trends are not distorted
axis equal;

grid on;
hold on;

%{
% Optional marker highlighting for selected nodal diameters
idx =  [1, 7, 13, 19]; %[1, 6, 10, 14];
markers = {'o', 'd', '^', 's'};
colors = {'k', 'k', 'k', 'k'};

% Degrees corresponding to each marker
deg = [0, 90, 180, 270];

% Plot selected points with larger markers
for i = 1:length(idx)
    plot(x_b(idx(i)), y_b(idx(i)), markers{i}, ...
        'MarkerSize', 10, ...
        'MarkerFaceColor', colors{i}, ...
        'DisplayName', sprintf('%d°', deg(i)));
end
%}

legend show;


%% Plot torsional mode eigenvalues

figure;

% Plot torsional mode eigenvalues in the complex plane
plot(x_t, y_t, '-o', 'LineWidth', 1.0);

xlabel('Real Part');
ylabel('Imaginary Part');

% Optional reference line or axis limits
% line([0 0], [0.10 0.15])
% xlim([-0.3 -0.15]);
% ylim([0.14 0.2]);

% Keep equal scaling on both axes so circular trends are not distorted
axis equal;

grid on;
hold on;

%{
% Optional marker highlighting for selected nodal diameters
idx =  [1, 7, 13, 19];  %[1, 6, 10, 14];
markers = {'o', 'd', '^', 's'};
colors = {'k', 'k', 'k', 'k'};

% Degrees corresponding to each marker
deg = [0, 90, 180, 270];

% Plot selected points with larger markers
for i = 1:length(idx)
    plot(x_t(idx(i)), y_t(idx(i)), markers{i}, ...
        'MarkerSize', 10, ...
        'MarkerFaceColor', colors{i}, ...
        'DisplayName', sprintf('%d°', deg(i)));
end
%}

legend show;
