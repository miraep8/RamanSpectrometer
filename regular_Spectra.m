classdef regular_Spectra < spectra_Class
    %light_Spectra is an extension of the spectra_Class class that allows
    %for the ligt Sampling capability to be demanded as well.
    %   Very similar to dark sampling, and uses the same helper function
    %   Backdrop_Sample to accomplish this.
    
    properties
        light_Spectrum
        light_Button
        isAbs_Bool = 0;
    end
    
    methods
        
        function light = regular_Spectra (isAbs)
           
            light@spectra_Class
            
            light.isAbs_Bool = isAbs;
            
            global NUM_SCANS
            light.light_Spectrum = zeros(1, NUM_SCANS -1);
            
            light.sample_Panel = uipanel(light.body, 'Title', 'Background Sampling', 'Position', [.85, .37, .1, .12]);
            light.light_Button = uicontrol(light.sample_Panel, 'Style', 'togglebutton', 'String', 'Light Sample', 'Position', [15, 40, 100, 17], 'Callback', @light.light_Spectra_Callback);
            light.dark_Sample = uicontrol(light.sample_Panel, 'Style', 'togglebutton', 'String', 'Dark Sample', 'Position', [15, 12, 100, 17], 'Callback', @light.dark_Spectra_Callback);
            
            sample = Backdrop_Sample(light.scans_Num, light.int_Num, light.xMin_Num, light.xMax_Num, light.light_Back);
            light.light_Spectrum = sample.back_Spectrum;
            
            while light.keepGraphing == 1
                lightPlot(light)
            end
            
        end
        function lightPlot(light)
            
            plotSpectra(light)
            reflected = light.spectrum/(light.light_Spectrum -light.dark_Spectrum);
            
            if light.isAbs_Bool == 1
                reflected = log(reflected);
            end
                
            plot(light.graph, light.wavelengths, reflected)
            
        end
        
        function light.light_Spectra_Callback(light, hObject, eventdata)
            
            sample = Backdrop_Sample(light.scans_Num, light.int_Num, light.xMin_Num, light.xMax_Num, light.light_Back);
            light.dark_Spectrum = sample.back_Spectrum;
            
        end
    end
    
end

