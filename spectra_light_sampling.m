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
        light_Size = 0;
        light_Bool = 0;
        new_Light = 1;
        
    end
    
    methods
        
        function light = spectra_light_sampling
           %this is the constructor.  It describes how to create the light
           %button. 
           light@spectra_Class;
           light.light_Sample = uicontrol(light.sample_Panel, 'Style', 'togglebutton', 'String', 'Light Sample', 'Position', [15, 42, 100, 17], 'Callback', @light.light_Spectra_Callback);
            
            
        end
        
        function lightPlot (light)
            plot(light)
            if light.light_Bool == 0
                
                if light.new_Light == 1
                    global NUM_SCANS
                    light.new_Light = 0;
                    light.light_Spectrum = zeros(1, NUM_SCANS);
                    light.light_Size = 0;
                end
                
                next = light.light_Spectrum*light.light_Size + light.spectrum;
                light.light_Spectrum = next/(light.light_Size + 1);
                light.light_Size = light.light_Size + 1;
                
            end
        end
        
        function light_Spectra_Callback (light, hObject, eventdata)
            pressed = get(hObject, 'Value');
            if pressed == get(hObject, 'Max')
                light.dark_Bool = 0;
                light.new_Dark = 1;
                light.dark_Size = 0;
            elseif pressed == get(hObject, 'Min')
                light.dark_Bool = 1;
            end 
            
        end
        
    end
    
end

