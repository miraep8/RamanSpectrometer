function [ names ] = getNames
%THis function runs through to check which spectrometers are connected and 
% creates a list of the spectrometer names


spectrometer

numSpectras = wrapper.getNumberOfSpectrometersFound();
temp = zeros(1, numSpectras);
for h = 0:numSpectras-1
   
    identity = wrapper.getName(h);
    temp(h) = identity;
    
end
disp(temp)
names = temp;

end

