classdef spectra_light_sampling < spectra_Class
    %This is an extension of the spectra class that allows for
    %light sampling, as well as dark sampling, something that most of
    %the spectral classes depend on. 
    %   The process for using the light sample is very similar to that 
    %   used for the dark sample, and relies on processing a large number
    %   of light samples to build up a statistical representation of the 
    %   white background. 
    
    properties
        light_Sample                %Button for taking a light sample. 
        
        light_Spectrum
        light_Size
        
    end
    
    methods
        
        function app = spectra_light_sampling
           %this is the constructor.  It describes how to create the light
           %button. 
           
           app.light_Sample = uicontrol(app.sample_Panel, 'Style', 'togglebutton', 'String', 'Light Sample', 'Position', [15, 42, 100, 17], 'Callback', @app.light_Spectra_Callback);
            
            
        end
        
        function light_Spectra_Callback (app, hObject, eventdata)
           app.light_Spectrum =  
            
        end
        
    end
    
end

