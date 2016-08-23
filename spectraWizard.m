% this function facilitates communication with the spectrometer.  It
% accumulates all of the scans for the spectrum, and sets the proper
% integration time. 
 
    %Author: Mirae Parker
    %Last Edit: 19.08.16


function [spectra, wavelengths] = spectraWizard(scans, intTime, index)

%   %  FOR TESTING REMOVE
% spectra = rand(1, 50)*randn;
% wavelengths = (1:50) + 400;
% return



%must be called to reinitialize the wrapper.
spectrometer

% set the integration time, in microseconds
wrapper.setIntegrationTime(index, intTime);


%collect a matrix containing as many scans as specified
for i = 1:scans
  spectrum(:,i) = wrapper.getSpectrum(index);
end

%this variable is shared between all of the programs, and insures that all
%of the vectors are of the proper length.
global NUM_SCANS
average = (1:NUM_SCANS);

%averages the scans to create a spectrum that is the average of all the
%scans previously accumulated. 
for k = 1:NUM_SCANS
    nextInt = 0;
    for m = 1:scans
        nextInt = nextInt + spectrum(k,m);
    end
    nextInt = nextInt/scans;
    average(k) = nextInt;
end

%returns the spectra and wavelengths accumulated
spectra = average(2:end);
waves = wrapper.getWavelengths(index);
wavelengths = waves(2:end);
