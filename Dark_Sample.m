classdef Dark_Sample < handle
    %Dark_Sample is a sister GUI that pops up and collects a dark
    %background sample at the users bidding. 
    %   It has a support function that allows for the user to retrieve the
    %   spectrum collected, and update the sample backdrop privately. 
    
    properties
        
        body
        background
        graph
        picture
        dark_Sample_Button
        
        
    end
    
    methods
        
        function sample = Dark_Sample
           
            sample.body = figure('Position', [350, 160, 900, 550]);
            sample.background = axes('Parent', sample.body, 'Position', [0,0,1,1]);
            sample.picture = imread('Images/dark_background.png');
            image(sample.background, sample.picture)
            axis off
            
            sample.dark_Sample_Button = uicontroluicontrol(sample.body, 'ForegroundColor', [1,1,1], 'BackgroundColor', [.2, .2, .4], 'Style', 'pushbutton', 'Position', [25, 270, 170, 40], 'String', 'Raman','FontSize', 20, 'Callback', @sample.ramanButton_Callback);
            
        end
        
        
    end
    
end

