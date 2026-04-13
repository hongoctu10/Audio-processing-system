function plot_spectrogram(x, fs, titleStr)
figure;
spectrogram(x, hann(1024), 768, 1024, fs, 'yaxis');
title(titleStr);
colorbar;
end