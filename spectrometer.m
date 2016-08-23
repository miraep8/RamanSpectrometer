% spectrometer contains the basic controls for connecting to the
% spectrometer and initializing a connection.
%     it should be run at the beginning of every usage of the Raman GUI

    %Author: Mirae Parker
    %Last Edit: 19.08.16


%adds the path to the spectrometer file
javaaddpath('C:\Program Files\Ocean Optics\OmniDriver\OOI_HOME\OmniDriver.jar');
wrapper = com.oceanoptics.omnidriver.api.wrapper.Wrapper();
wrapper.openAllSpectrometers();

%the length of the original scan sets the length of all the other vectors.
global NUM_SCANS
NUM_SCANS = length(spectrum);



