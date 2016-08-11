classdef light_Spectra < spectra_Class
    %light_Spectra is an extension of the spectra_Class class that allows
    %for the ligt Sampling capability to be demanded as well.
    %   Very similar to dark sampling, and uses the same helper function
    %   Backdrop_Sample to accomplish this.
    
    properties
        light_Spectrum
        light_Button
    end
    
    methods
        
        function light = light_Spectra
           
            light@spectra_Class
            
            global NUM_SCANS
            light.light_Spectrum = zeros(1, NUM_SCANS -1);
            
            back = Backdrop_Sample(light.scans_Num, light.int_Num, light.xMin_Num, light.xMax_Num, light.light_Back);
            light.light_Spectrum = back.back_Spectrum;
            
            light.light_Button = uicontrol(light.sample_Panel, 'Style', 'togglebutton', 'String', 'Light Sample', 'Position', [15, 45, 100, 17], 'Callback', @light.light_Spectra_Callback);
            
        end
        
        function light.light_Spectra_Callback(light, hObject, eventdata)
            
            
        end
    end
    
end

