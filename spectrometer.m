% spectrometer contains the basic controls for connecting to the
% spectrometer and initializing a connection.
%     it should be run at the beginning of every usage of the Raman GUI

close all
clear all

javaaddpath('C:\Program Files\Ocean Optics\OmniDriver\OOI_HOME\OmniDriver.jar');
wrapper = com.oceanoptics.omnidriver.api.wrapper.Wrapper();
wrapper.openAllSpectrometers();
spectrum = wrapper.getSpectrum(0);
wavelengths = wrapper.getWavelengths(0);
global NUM_SCANS
NUM_SCANS = length(spectrum);
wavelengths = wrapper.getWavelengths(0);
