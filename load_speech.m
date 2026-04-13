function [x, fs] = load_speech(filename)

if nargin < 1 || ~isfile(filename)
    [file, path] = uigetfile({'*.wav;*.mp3','Audio Files'});
    if isequal(file,0)
        error('No audio file selected');
    end
    filename = fullfile(path, file);
end

[x, fs] = audioread(filename);

% Convert to mono
if size(x,2) > 1
    x = mean(x,2);
end

% Normalize
x = x / max(abs(x)+eps);
end