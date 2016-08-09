classdef Trans < spectra_light_sampling
        %Trans  This class is an extension of the Spectra Class.  Its function
    %is to create the specialized type of plot that is specific for a
    %Transmittion plots.
    %   The Trans class extends the spectra_Class by averaging the data to
    %   be plotted for the graph.  It works best if several dark samples
    %   are taken to cancel out the background noise.  It also requires the
    %   using a white sample.
    
    % Author Mirae Parker
    % Last Edit: 09.08.16
    
    
    properties
        
    end
    
    methods
        
        function trans = Trans
            trans@spectra_light_sampling;
            
           while trans.keepGraphing == 1
               transPlot(trans);
           end
            
        end
        
        function transPlot(trans)
            lightPlot(trans)
            
        
    end
end