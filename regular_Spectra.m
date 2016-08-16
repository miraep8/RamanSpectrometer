classdef regular_Spectra < spectra_Class
    %regular Spectra contains all of the functionality for Transmittance 
    %Reflectance and Absorbance Spectra.  
    %   It contains a bool to differentiate between Absorbance which is the
    %   neg. logarithm of Transmittance, and the other two types of plots.
    %   Reflectance and Transmittance have an identical relationship
    %   between light which the sample recieves and that which reaches the
    %   detector again, the only difference being the direction of the
    %   incident light. 
    
    properties
        light_Spectrum
        light_Button
        isAbs_Bool = 0;
    end
    
    methods
        
        function reg = regular_Spectra (isAbs)
           
            reg@spectra_Class
            
            reg.isAbs_Bool = isAbs;
            
            global NUM_SCANS
            reg.light_Spectrum = zeros(1, NUM_SCANS -1);
            
            reg.sample_Panel = uipanel(reg.body, 'Title', 'Background Sampling', 'Position', [.85, .37, .1, .12]);
            reg.light_Button = uicontrol(reg.sample_Panel, 'Style', 'togglebutton', 'String', 'Light Sample', 'Position', [15, 40, 100, 17], 'Callback', @reg.light_Spectra_Callback);
            reg.dark_Sample = uicontrol(reg.sample_Panel, 'Style', 'togglebutton', 'String', 'Dark Sample', 'Position', [15, 12, 100, 17], 'Callback', @reg.dark_Spectra_Callback);
            
            sample = Backdrop_Sample(reg.scans_Num, reg.int_Num, reg.xMin_Num, reg.xMax_Num, reg.light_Back);
            reg.light_Spectrum = sample.back_Spectrum;
            
            while reg.keepGraphing == 1
                lightPlot(reg)
            end
            
        end
        
        %light plot is similar to the plot Spectra function in the
        %spectra_Class, however it also uses a light standard and uses this
        %to calculate transmittance, reflectance and absorption. 
        function lightPlot(reg)
            
            plotSpectra(reg)
            reflected = reg.spectrum/(reg.light_Spectrum -reg.dark_Spectrum);
            
            if reg.isAbs_Bool == 1
                reflected = -log10(reflected);
            end
                
            plot(reg.graph, reg.wavelengths, reflected)
            xlim([raman.xMin_Num, raman.xMax_Num])
            xlabel(raman.x_Text)
            ylabel(raman.y_Text)
            
        end
        
        %this call back function aolows the user to collect a whole new
        %light background sample by clicking on the light sample button. 
        function light_Spectra_Callback(reg, hObject, eventdata)
            
            sample = Backdrop_Sample(reg.scans_Num, reg.int_Num, reg.xMin_Num, reg.xMax_Num, reg.light_Back);
            reg.dark_Spectrum = sample.back_Spectrum;
            
        end
    end
    
end
