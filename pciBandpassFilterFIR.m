function [ output ] = pciBandpassFilterFIR( input )
%Impedance bandpass filtering prior to rate estimation

%HIGH PASS FILTER
Fs = 250;  %sampling Freq (hz)
N    = 54;       %order
Fc   = 1.3;      %cutoff Freq (hz)
flag = 'scale';  %sampling Flag
win = barthannwin(N+1); %window type
hpf_coefs  = fir1(N, Fc/(Fs/2), 'high', win, flag); %compute coefs

%LOW PASS FILTER:
Fs = 250; %sampling frequency
N     = 53; %order must be off for all lpf
Fpass = 4; %passband Frequency
Fstop = 8; %stopband Frequency
Wpass = 1; %passband Weight
Wstop = 1; %stopband Weight
dens  = 20; %density Factor

% Calculate the coefficients using the FIRPM function.
lpf_coefs  = firpm(N, [0 Fpass Fstop Fs/2]/(Fs/2), [1 1 0 0], [Wpass Wstop], ...
    {dens});

%Filtering
output = detrend(input);
output = filtfilt(hpf_coefs, 1, output); %highpass
output = filtfilt(lpf_coefs, 1, output); %lowpass

end