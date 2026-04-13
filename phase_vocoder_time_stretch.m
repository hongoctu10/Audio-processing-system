function y = phase_vocoder_time_stretch(x, fs, alpha)
% Phase Vocoder time-stretching
% alpha > 1 : slow down
% alpha < 1 : speed up

x = x(:);

N  = 1024;        % frame length
Ha = N/4;         % analysis hop (75% overlap)
Hs = round(Ha*alpha);  % synthesis hop
win = hann(N,'periodic');

L = length(x);
numFrames = floor((L-N)/Ha);

Y = zeros(numFrames*Hs + N,1);

phi = zeros(N,1);
prevPhase = zeros(N,1);
omega = 2*pi*(0:N-1)'/N;

for k = 1:numFrames
    idx = (k-1)*Ha + (1:N);
    frame = x(idx).*win;

    X = fft(frame);
    mag = abs(X);
    phase = angle(X);

    if k == 1
        deltaPhi = phase;
    else
        deltaPhi = phase - prevPhase;
    end

    % Phase unwrapping
    deltaPhi = deltaPhi - omega*Ha;
    deltaPhi = mod(deltaPhi + pi, 2*pi) - pi;

    % Phase accumulation
    phi = phi + omega*Hs + deltaPhi*(Hs/Ha);
    prevPhase = phase;

    yFrame = real(ifft(mag .* exp(1j*phi))) .* win;
    outIdx = (k-1)*Hs + (1:N);
    Y(outIdx) = Y(outIdx) + yFrame;
end

% Normalize output
y = Y / max(abs(Y)+eps);
end