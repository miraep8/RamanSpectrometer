classdef spectra_light_sampling < spectra_Class
    %This is an extension of the spectra class that allows for
    %light sampling, as well as dark sampling, something that most of
    %the spectral classes depend on. 
    %   The process for using the light sample is very similar to that 
    %   used for the dark sample, and relies on processing a large number
    %   of light samples to build up a statistical representation of the 
    %   white background. 
    
    properties
        Light_Sample                %Button for taking a light sample. 
        
        Light_Spectrum
        Light_Size
        
    end
    
    methods
        
        function app = spectra_light_sampling
           %this is the constructor.  It describes how to create the light
           %button. 
           
           app.Light_Sample = uicontrol(app.Sample_Panel, 'Style', 'togglebutton', 'String', 'Light Sample', 'Position', [15, 42, 100, 17], 'Callback', @app.Light_Spectra_Callback);
            
            
        end
        
        function Light_Spectra_Callback (app, hObject, eventdata)
           app.Light_Spectrum =  
            
        end
        
    end
    
end

