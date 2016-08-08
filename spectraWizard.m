% initialize spectrometer
function [spectra, wavelengths] = spectraWizard(scans, intTime)

spectrometer

% set integration time to 1 millisec (1000 microsec)
wrapper.setIntegrationTime(0, intTime);

% take 10,000 spectra
% time_start = datestr(now,'dd-mm-yyyy HH:MM:SS.FFF');
for i = 1:scans
  spectrum(:,i) = wrapper.getSpectrum(0);
end
% time_end = datestr(now,'dd-mm-yyyy HH:MM:SS.FFF');

% display the time it took
%display(time_start);
%display(time_end);

global NUM_SCANS
average = (1:NUM_SCANS);

for k = 1:NUM_SCANS
    nextInt = 0;
    for m = 1:scans
        nextInt = nextInt + spectrum(k,m);
    end
    nextInt = nextInt/scans;
    average(k) = nextInt;
end

spectra = average;
wavelengths = wrapper.getWavelengths(0);
