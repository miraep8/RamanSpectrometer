classdef Analysis < handles
    %Analysis is meant to be the class which perform the analysis on the
    %spectra files generated through the spectra process.
    %   The types of anaysis provided:
    
    
    
    properties
        myFile
    end
    
    methods
        
        function thinking = Analysis (filename)
           
            thinking.myFile = filename;
            readFile(thinking);
            
            
        end
        
        function readFile(thinking)
            
           fileID = fopen(thinking.myFile);
            
        end
        
    end
    
end

