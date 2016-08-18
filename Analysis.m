classdef Analysis < handle
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
           param = textscan(fileID, '%d', 2, 'Delimiter', '/');
           
           titles = textscan(fileID, '%[^~]', sav);
           disp(titles);
           
            
        end
        
    end
    
end

