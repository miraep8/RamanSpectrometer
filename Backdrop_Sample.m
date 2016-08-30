classdef Backdrop_Sample < handle
    %Backdrop_Sample contains all of the functionality for collecting a
    %background sample for reference, either a light, or dark sample, the
    %collection requirements are the same.
    %   The functionality is much like that of a pop-up window which
    %   contains the current state of the spectrometer for reference and an
    %   ability for the user to take a sample.
    
        %Author: Mirae Parker
        %Last Edit: 19.08.16

    
    properties
        body
        background
        graph
        back_Sample                %Button for taking a light sample. 
        
        back_Spectrum
        keepGraphing = 1;
        factor = 5;
        scans
        int
        min
        max
        index
        type_Label
        
        
    end
    
    methods
        
        function sample = Backdrop_Sample (numScans, intTime, xMin, xMax, specIndex, type)
           
            sample.body = figure('Position', [350, 160, 900, 550]);
            sample.background = axes('Parent', sample.body, 'Position', [0,0,1,1]);
            
            sample.back_Sample = uicontrol(sample.body, 'Style', 'togglebutton', 'String', 'Take Sample', 'Position', [15, 20, 200, 17], 'Callback', @sample.takeSample_Callback);
            
            sample.scans = numScans;
            sample.int = intTime;
            sample.min = xMin;
            sample.max = xMax;
            sample.index = specIndex;
            
            
            sample.graph = axes('Parent', sample.body, 'Position', [.07,.1,.75,.8], 'XLim', [sample.min, sample.max]);
            
            sample.type_Label = uicontrol(sample.body, 'Style', 'text', 'String', type, 'Position', [300, 500, 100, 200]);

            while sample.keepGraphing == 1
               backPlot(sample)
               pause(.2)
            end
            
            closeThis(sample)
            
        end
        
        function takeSample_Callback(sample, hObject, eventdata)
            sample.keepGraphing = 0;
            
        end
        
        function backPlot(sample)
           
            [sample.back_Spectrum, wavelengths] = spectraWizard(sample.scans, sample.int, sample.index);
            plot(sample.graph, wavelengths, sample.back_Spectrum)
            xlim([sample.min, sample.max])
            
        end
        
        function closeThis(sample)
            
            close(sample.body)
            
        end

        
    end
    
end
