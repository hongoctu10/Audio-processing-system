function y = pitch_shift(x, fs, beta)
% Pitch shift giữ formant cho giọng nói

    if beta == 1
        y = x;
        return;
    end

    % 1. Time stretch (giữ formant)
    x1 = phase_vocoder_time_stretch(x, fs, 1/beta);

    % 2. Resample về đúng tốc độ
    p = round(beta * 1000);
    q = 1000;

    y = resample(x1, p, q);

    % 3. Cắt hoặc zero-pad cho bằng độ dài gốc
    if length(y) > length(x)
        y = y(1:length(x));
    else
        y = [y; zeros(length(x)-length(y),1)];
    end
end