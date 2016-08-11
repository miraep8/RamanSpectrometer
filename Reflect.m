classdef Reflect < spectra_Class
    
        %Trans  This class is an extension of the Spectra Class.  Its function
    %is to create the specialized type of plot that is specific for a
    %Transmittion plots.
    %   The Trans class extends the spectra_Class by averaging the data to
    %   be plotted for the graph.  It works best if several dark samples
    %   are taken to cancel out the background noise.  It also requires the
    %   using a white sample.
    
    % Author Mirae Parker
    % Last Edit: 18.07.16
    
    
    properties
        
    end
    
    methods
        
        function reflect = Reflect
            
            reflect@spectra_Class;
            
            global NUM_SCANS
            reflect.light_Spectrum = zeros(1, NUM_SCANS -1);
            
            light = Backdrop_Sample(reflect.scans_Num, reflect.int_Num, reflect.xMin_Num, reflect.xMax_Num, reflect.light_Back);
            reflect.light_Spectrum = light.back_Spectrum;
            
            while reflect.keepGraphing == 1
                reflectPlot(reflect)
            end
            
        end
        
        function reflectPlot(reflect)
           
            plot(reflect)
            
            
        end
            
        
    end
end