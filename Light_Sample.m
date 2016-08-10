classdef Light_Sample < handle
    %Light_Sample is a sister GUI that pops up and collects a light
    %background sample at the users bidding. 
    %   It has a support function that allows for the user to retrieve the
    %   spectrum collected, and update the sample backdrop privately. 
    
    properties
        body
        background
        picture
        graph
        light_Sample                %Button for taking a light sample. 
        
        light_Spectrum
        light_Size = 0;
        light_Bool = 0;
        new_Light = 1;
        
    end
    
    methods
        
        function sample = Light_Sample
           
            sample.body = figure('Position', [350, 160, 900, 550]);
            sample.background = axes('Parent', sample.body, 'Position', [0,0,1,1]);
            sample.picture = imread('Images/light_background.png');
            image(sample.background, sample.picture)
            axis off
            
        end
        
        function spectrum = getSpectrum(sample)

        
    end
    
end
