clear; clc; close all;

N=25;
TSM=zeros(2,N);
for r = 0:N-1
  TSM(:,r+1)= TunedSystemMode_TUFRG(r,N); % change variables within this script
end

%%

x_b = real(TSM(1,:));
y_b = imag(TSM(1,:));
x_t = real(TSM(2,:));
y_t = imag(TSM(2,:));


figure;
plot(x_b, y_b, '-o', 'LineWidth', 1.0);
xlabel('Real Part');
ylabel('Imaginary Part');
%line([0 0], [0.10 0.15])
%xlim([-0.05 0]);
%ylim([0 0.08]);
axis equal;   % makes circles look like circles
grid on;
hold on;

%{
idx =  [1, 7, 13, 19]; %[1, 6, 10, 14];
markers = {'o', 'd', '^', 's'};
colors = {'k', 'k', 'k', 'k'};

% Degrees corresponding to each marker
deg = [0, 90, 180, 270];

for i = 1:length(idx)
    plot(x_b(idx(i)), y_b(idx(i)), markers{i}, ...
        'MarkerSize', 10, ...
        'MarkerFaceColor', colors{i}, ...
        'DisplayName', sprintf('%d°', deg(i)));
end
%}
legend show;

figure;
plot(x_t, y_t, '-o', 'LineWidth', 1.0);
xlabel('Real Part');
ylabel('Imaginary Part');
%line([0 0], [0.10 0.15])
%xlim([-0.3 -0.15]);
%ylim([0.14 0.2]);
axis equal;   % makes circles look like circles
grid on;
hold on;

%{
idx =  [1, 7, 13, 19];  %[1, 6, 10, 14];
markers = {'o', 'd', '^', 's'};
colors = {'k', 'k', 'k', 'k'};

% Degrees corresponding to each marker
deg = [0, 90, 180, 270];

for i = 1:length(idx)
    plot(x_t(idx(i)), y_t(idx(i)), markers{i}, ...
        'MarkerSize', 10, ...
        'MarkerFaceColor', colors{i}, ...
        'DisplayName', sprintf('%d°', deg(i)));
end

%}
legend show;
