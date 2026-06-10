clear; clc; close all;

Nvals = [19 25];

figure; hold on; grid on;
xlabel('Real Part');
ylabel('Imaginary Part');
%xlim([-0.05 0]);
%ylim([0 0.08]);
axis equal;

for k = 1:length(Nvals)

    N = Nvals(k);

    TSM = zeros(2,N);
    for r = 0:N-1
        TSM(:,r+1) = TunedSystemMode_TUFRG(r,N); % change variables in this script
    end

    x_b = real(TSM(1,:));
    y_b = imag(TSM(1,:));

    plot(x_b,y_b,'-o','LineWidth',1.0,'DisplayName',sprintf('N = %d',N));

end

legend show;


figure; hold on; grid on;
xlabel('Real Part');
ylabel('Imaginary Part');
%xlim([-0.3 -0.15]);
%ylim([0.14 0.2]);
axis equal;

for k = 1:length(Nvals)

    N = Nvals(k);

    TSM = zeros(2,N);
    for r = 0:N-1
        TSM(:,r+1) = TunedSystemMode_TUFRG(r,N);
    end

    x_t = real(TSM(2,:));
    y_t = imag(TSM(2,:));

    plot(x_t,y_t,'-o','LineWidth',1.0,'DisplayName',sprintf('N = %d',N));

end

legend show;
