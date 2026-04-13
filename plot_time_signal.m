function plot_time_signal(x, Fs, title_str)
% PLOT_TIME_SIGNAL Plot waveform in time domain

t = (0:length(x)-1) / Fs;

figure;
plot(t, x, 'k');
xlabel('Time (s)');
ylabel('Amplitude');
title(title_str);
grid on;

end