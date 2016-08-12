classdef Reflect < light_Spectra
    
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
            
            reflect@light_Spectra;
            
            while reflect.keepGraphing == 1
                reflectPlot(reflect)
            end
            
        end
        
        function reflectPlot(reflect)
           
            lightPlot(reflect)
            reflected = light.spectrum/(light.light_Spectrum -light.dark_Spectrum);
            plot(light.graph, light.wavelengths, reflected)
            
            
        end
            
        
    end
end