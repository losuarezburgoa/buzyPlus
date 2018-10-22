function [ ] = exportplotedfigure( figureName, ...
    newFileName )
%exportplotedfigure( figureName, newFileName )
%Description:
%Exports a ploted figure to a vectorial or raster format file.
%
%Input(s):
%Name of the figure which is desired to export inside '', the comlete path
%if is located outside the directory where this function
%resides(figureName).
%Desired filename with the desired extension and inside '' (newFileName).
%The supported files are a vectorial file (Encapsulated Post 
%Script black and white) by typing after the desired name the extension
%'.eps' or a raster file (monochrome BMP) by typing '.bmp'.
%
%Example(s):
%exportplotedfigure( 'estereo.fig' ,'vectorEst.eps' );
%exportplotedfigure( 'estereo' ,'vectorEst.eps' );
%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%exportplotedfigure( figureName, newFileName )

[dirF ,nameF ,extensionF] =fileparts(figureName);
if strcmp(extensionF, '.fig');
    
    figNameWithoutExt =strcat(dirF ,nameF);
    openfig(figNameWithoutExt);

    [dirN, nameN ,extensionN] =fileparts(newFileName);
    if dirN==''
        completeFileName =strcat(dirF, nameN);
    else
        completeFileName =strcat(dirN, nameN);
    end

    switch extensionN 
        case {'.eps','.EPS'}      % multiple matches 
               print ('-deps', '-tiff', completeFileName);
        case {'.bmp','.BMP'} 
               print ('-r300', '-dbmpmono', completeFileName);
        otherwise 
             disp (['Wrong output file type: ' extensionN...
             ', please recall the command and define a correct option']);
    end
else
   disp (['Wrong input file type: ' extensionF...
             ', please recall the command and choose a correct input file type']); 
end
end

