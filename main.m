clc;
clear;
close all;

%% ===== LOAD =====
[x, fs] = load_speech('speech.wav');

if size(x,2) > 1
    x = mean(x,2);
end
x = x / max(abs(x)+eps);

t = (0:length(x)-1)/fs;

%% ===== PITCH SHIFT (GIỮ GIỌNG) =====
x_high = pitch_shift(x, fs, 0.1);   % cao
x_low  = pitch_shift(x, fs, 1.1);   % trầm

x_high = x_high / max(abs(x_high)+eps);
x_low  = x_low  / max(abs(x_low)+eps);

%% ===== TIME STRETCH (TỪ GIỌNG TRẦM) =====
x_fast = phase_vocoder_time_stretch(x_low, fs, 0.7);   % nhanh
x_slow = phase_vocoder_time_stretch(x_low, fs, 1.8);   % chậm

x_fast = x_fast / max(abs(x_fast)+eps);
x_slow = x_slow / max(abs(x_slow)+eps);

t_fast = (0:length(x_fast)-1)/fs;
t_slow = (0:length(x_slow)-1)/fs;

%% ===== PLOT 5 DẠNG SÓNG =====
figure('Name','Speech Processing Results','Color','w');

subplot(5,1,1)
plot(t, x)
title('Original Speech')
ylabel('Amp')
grid on

subplot(5,1,2)
plot(t, x_low)
title('Low Pitch (β = 1.4)')
ylabel('Amp')
grid on

subplot(5,1,3)
plot(t, x_high)
title('High Pitch (β = 0.6)')
ylabel('Amp')
grid on

subplot(5,1,4)
plot(t_fast, x_fast)
title('Fast Speech (α = 0.7)')
ylabel('Amp')
grid on

subplot(5,1,5)
plot(t_slow, x_slow)
title('Slow Speech (α = 1.8)')
xlabel('Time (s)')
ylabel('Amp')
grid on

%% ===== PLAY =====
disp('Original');      
soundsc(x, fs);
pause(length(x)/fs + 1)

disp('Low pitch');     
soundsc(x_low, fs);
pause(length(x_low)/fs + 1)

disp('High pitch');    
soundsc(x_high, fs);
pause(length(x_high)/fs + 1)

disp('Fast');          
soundsc(x_fast, fs);
pause(length(x_fast)/fs + 1)

disp('Slow');          
soundsc(x_slow, fs);