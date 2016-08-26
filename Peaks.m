function Peaks(spectra, waves)
%Peaks is just a simple program to identify the curvature of the dataset,
%and demonstrate which points would be used in a baseling fit program and
%which would not
%   It graphs these two classes of data in two different colors via
%   scatterplot.

threshold = 1.1;
plot(waves,spectra)

values = zeros(1,length(waves));
values(1) = spectra(1);
values(length(spectra)) = spectra(end);

for k = 2:(length(waves)-1)
    dxR = ((spectra(k)-spectra(k-1))/(waves(k) - waves(k-1)))^2;
    dxL = ((-spectra(k)+spectra(k+1))/(-waves(k) + waves(k+1)))^2;

    values(k) = abs(dxR) + abs(dxL);
end
modvalues = values;
blueInd = zeros(1);
redInd = zeros(1);
for n = 2:length(values)-1
   
    if values(n-1) > threshold && values(n+1) > threshold
        modvalues(n) = modvalues(n) + 1*(spectra(n))^(1/2);
    elseif values(n-1) > threshold && values(n+1) > threshold
        modvalues(n) = modvalues(n) -1*(spectra(n))^(1/2);
    end
    
    if modvalues(n)*spectra(n) >threshold
        blueInd = [blueInd, n];
    else
        redInd = [redInd, n];
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

