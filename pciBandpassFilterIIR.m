function [output] = pciBandpassFilterIIR( input )
%Filtering for impedance signal
fs_filter = 250;
order = 4;   % Order
Fc1 = 1; %Low cutoff
Fc2 = 10;  % High Cutoff Frequency
% Construct an FDESIGN object and call its BUTTER method.
h_bpf  = fdesign.bandpass('N,F3dB1,F3dB2', order, Fc1, Fc2, fs_filter);
Hd_bpf = design(h_bpf, 'butter');
output= filtfilt(Hd_bpf.sosMatrix, Hd_bpf.scaleValues, input);

end