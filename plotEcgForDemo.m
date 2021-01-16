function [] = plotEcgForDemo(ecgData,ecgSampleRate, pciData, pciSampleRate, figOffset)
%{

---------------------------------------------------------------------------

Copyright (C) 2019 Jason Coult

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

---------------------------------------------------------------------------

INPUTS
ecgData: ecg input
ecgSample Rate: ecg sampling rate
pciData: chest impedance
pciSampleRate: chest impedance sampling rate
figOffset: offset figure position in pixels

---------------------------------------------------------------------------

%}

%params
pciPlotOffset = -1.4; 
yMax = 1.3;
yMin= -2.05;  
pciLinWid = 1.1;
ecgLinWid  = 1.3; 
ecgColor = [0 0 0]; %black

epochSize = length(ecgData)/ecgSampleRate; %epoch size 
ecgTime = 0:1/ecgSampleRate:epochSize -1/ecgSampleRate;  %ecg time vector
pciTime = 0:1/pciSampleRate:length(pciData)/pciSampleRate -1/pciSampleRate; %pci time

%Set figure based on ecg length
figure('Position',[(20+figOffset) (600-figOffset) epochSize*97 210]); %[left bottom width height]
set(0,'defaulttextinterpreter','latex');  
set(0, 'defaultAxesTickLabelInterpreter','latex');  
set(0, 'defaultLegendInterpreter','latex');

%ECG plot
plot(ecgTime, ecgData, 'Color', ecgColor, 'Linewidth', ecgLinWid, 'LineStyle', '-')
hold on

%Labels and limits
xlabel('Time (s) ' );
ylabel('ECG (mV)');
ylim([yMin yMax]);
xlim([(0) (epochSize)]);
yticks([-1 0 1])
xticks([0 1 2 3 4 5])
xticklabels({'0', '1', '2', '3', '4', '5'})
grid on

yyaxis right

%PCI plot
pciData = detrend(pciData); 
pciWin = tukeywin(length(pciData), .05); 
pciData = pciData.*pciWin; 
plot(pciTime, (pciData)./4,  'Linewidth', pciLinWid, 'LineStyle', '-.')

ylim([yMin-pciPlotOffset yMax-pciPlotOffset]);
xlim([(0) (epochSize)]);
txt = 'Impedance (Ohm)';
ylabel(txt);
yticks([-.5 0 .5])
yticklabels({'-2','0','2'})
yrh = get(gca,'ylabel');
yrp = get(yrh, 'Position');
yrp(2) = yrp(2)-2;
set(yrh, 'Rotation',-90, 'Position',yrp, 'VerticalAlignment','bottom', 'HorizontalAlignment','right')

end 

