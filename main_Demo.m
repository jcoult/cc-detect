%{
---------------------------------------------------------------------------

%Run this script to demonstrate chest compression detection on example data.

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


Any use or derivations of this code should also cite the following paper:

Coult J, Blackwood J, Rea T, Kudenchuk P, Kwok H. A Method to Detect
Presence of Chest Compressions during Resuscitation using Transthoracic
Impedance. IEEE Journal of Biomedical and Health Informatics, vol. 24, no.
3, March 2020. https://doi.org/10.1109/JBHI.2019.2918790
---------------------------------------------------------------------------
%}

clear all; close all; clc;

%Folder with original example data clips and patient binary variables
dataFolder = 'data\clips\';

%output folder to save images of figures in
figFolder = 'figures\';

%set to 1 if you want to overwrite-save the output figures in figure folder
saveFigs =0; 

%List files in target folder (folder must ONLY contain clip files)
clipList = dir(dataFolder); %list clips in folder
clipList = clipList(3:end); %remove the '.' and '..'

%Loop through the demo data clips
for i = 1:length(clipList)
    
   
    %LOAD THE CLIP DATA
    currentFileName = clipList(i); %the current clip file
    load([dataFolder currentFileName.name]); %load the struct within clip
    structToLoad = currentFileName.name; %name to load
    structToLoad = structToLoad(1:(end-4)); %remove .mat
    tempID = str2double(eval([structToLoad '.cassID']));%get data from clip
    tempEcgData = (eval([structToLoad '.ecgData']));
    tempEcgSampleRate = (eval([structToLoad '.ecgSampleRate']));
    tempHasCpr = (eval([structToLoad '.hasCPR']));
    tempModel = (eval([structToLoad '.model']));
    tempShockNum = (eval([structToLoad '.shockNum']));
    tempPciSampleRate = (eval([structToLoad '.pciSampleRate']));
    tempPciData = (eval([structToLoad '.pciData']));
    
    %To display the true state in output
    if tempHasCpr ==1
        trueStateText = 'Chest Compressions Present';
    else
        trueStateText = 'No Chest Compressions' ;
    end
    
    %detect CPR using 5-second segment
    [cprDetected, cprScore, cprRate] = detectCpr(tempPciData, tempPciSampleRate, tempModel, 5);
    
    %PLOT 5-second segment
    plotEcgForDemo(tempEcgData,tempEcgSampleRate, tempPciData, tempPciSampleRate, i*25)
    title(['True State: ' trueStateText ...
        newline 'Device ' tempModel ', ID ' num2str(tempID) ...
        newline 'CCs Detected: ' num2str(cprDetected) ', CC Score: ' num2str(round(cprScore,4)) newline...
        'Compression Rate: ' num2str(round(cprRate)) ' CCs/min'])
    
    if saveFigs ==1
        %save output figure
        saveas(gcf, [figFolder 'ex' num2str(i) '_5sec'], 'png')
    end
    
    %Truncate to 3.2 seconds
    tempPciData = tempPciData(1:end-floor(1.8*tempPciSampleRate));
    tempEcgData = tempEcgData(1:end-floor(1.8*tempEcgSampleRate));
    
    %detect CPR using 3.2-second segment
    [cprDetected, cprScore, cprRate] = detectCpr(tempPciData, tempPciSampleRate, tempModel, 5);
    
    %PLOT 3.2-second segment
    plotEcgForDemo(tempEcgData,tempEcgSampleRate, tempPciData, tempPciSampleRate, i*25)
    title(['True State: ' trueStateText ...
        newline 'Device ' tempModel ', ID ' num2str(tempID) ...
        newline 'CCs Detected: ' num2str(cprDetected) ', CC Score: ' num2str(round(cprScore,4)) newline...
        'Compression Rate: ' num2str(round(cprRate)) ' CCs/min'])
    
    if saveFigs ==1
        %save output figure
        saveas(gcf, [figFolder 'ex' num2str(i) '_3sec'], 'png')
    end
    
end


