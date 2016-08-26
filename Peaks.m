function Peaks(spectra, waves)
%Peaks is just a simple program to identify the curvature of the dataset,
%and demonstrate which points would be used in a baseling fit program and
%which would not
%   It graphs these two classes of data in two different colors via
%   scatterplot.

threshold = 2;
blueInd = zeros(1);
redInd = zeros(1);
plot(waves,spectra)

for k = 2:(length(waves)-1)
    dxR = (spectra(k)^(1/2))*((spectra(k)-spectra(k-1))/(waves(k) - waves(k-1)))^2;
    dxL = (spectra(k)^(1/2))*((-spectra(k)+spectra(k+1))/(-waves(k) + waves(k+1)))^2;
    if abs(dxR) > threshold || abs(dxL) >threshold || abs(dxR+dxL)> threshold
        blueInd = [blueInd, k];
    else
        redInd = [redInd, k];
    end    
end

blueX = zeros(1, length(blueInd));
blueY = zeros(1, length(blueInd));
for m = 2:length(blueInd)
    blueX(m) = waves(blueInd(m));
    blueY(m) = spectra(blueInd(m));
end
redX = zeros(1, length(redInd));
redY = zeros(1, length(redInd));
for m = 2:length(redInd)
    redX(m) = waves(redInd(m));
    redY(m) = spectra(redInd(m));
end 

hold on
scatter(blueX, blueY, 10, 'b')
scatter(redX, redY, 10, 'r')
hold off

end

