clear; clc; close all;

% Number of blades / sectors to compare
% Each value of N represents a different tuned system size
Nvals = [19 25];

%% Plot bending mode eigenvalues for each N

figure; hold on; grid on;

xlabel('Real Part');
ylabel('Imaginary Part');

% Optional axis limits for zooming into the bending mode region
% xlim([-0.05 0]);
% ylim([0 0.08]);

% Keep the same scale on both axes so the complex-plane shape is not distorted
axis equal;

% Loop through each value of N
for k = 1:length(Nvals)

    % Current number of blades / sectors
    N = Nvals(k);

    % Preallocate tuned system mode matrix
    % Row 1 = bending mode eigenvalues
    % Row 2 = torsional mode eigenvalues
    % Columns correspond to nodal diameter index r
    TSM = zeros(2,N);

    % Compute tuned system modes for all nodal diameters
    % r ranges from 0 to N-1
    for r = 0:N-1

        % TunedSystemMode_TUFRG should return a 2x1 complex vector
        % containing bending and torsional eigenvalues for the given r and N
        TSM(:,r+1) = TunedSystemMode_TUFRG(r,N); % change variables in this script

    end

    % Extract real and imaginary parts of the bending mode eigenvalues
    x_b = real(TSM(1,:));
    y_b = imag(TSM(1,:));

    % Plot bending mode eigenvalues in the complex plane
    plot(x_b,y_b,'-o','LineWidth',1.0,'DisplayName',sprintf('N = %d',N));

end

% Show legend using the DisplayName assigned in each plot command
legend show;


%% Plot torsional mode eigenvalues for each N

figure; hold on; grid on;

xlabel('Real Part');
ylabel('Imaginary Part');

% Optional axis limits for zooming into the torsional mode region
% xlim([-0.3 -0.15]);
% ylim([0.14 0.2]);

% Keep the same scale on both axes so the complex-plane shape is not distorted
axis equal;

% Loop through each value of N
for k = 1:length(Nvals)

    % Current number of blades / sectors
    N = Nvals(k);

    % Preallocate tuned system mode matrix
    % Row 1 = bending mode eigenvalues
    % Row 2 = torsional mode eigenvalues
    % Columns correspond to nodal diameter index r
    TSM = zeros(2,N);

    % Compute tuned system modes for all nodal diameters
    for r = 0:N-1

        % Store the bending and torsional eigenvalues for this nodal diameter
        TSM(:,r+1) = TunedSystemMode_TUFRG(r,N);

    end

    % Extract real and imaginary parts of the torsional mode eigenvalues
    x_t = real(TSM(2,:));
    y_t = imag(TSM(2,:));

    % Plot torsional mode eigenvalues in the complex plane
    plot(x_t,y_t,'-o','LineWidth',1.0,'DisplayName',sprintf('N = %d',N));

end

% Show legend using the DisplayName assigned in each plot command
legend show;
