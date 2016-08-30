function [ names ] = getNames
%THis function runs through to check which spectrometers are connected and 
% creates a list of the spectrometer names


spectrometer

numSpectras = wrapper.getNumberOfSpectrometersFound();
for h = 1:numSpectras
   
    identity = wrapper.getSerialNumber(h-1);
    temp(h) = identity;
    
end
names = char(temp);

end

