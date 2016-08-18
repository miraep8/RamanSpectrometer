classdef Analysis < handle
    %Analysis is meant to be the class which perform the analysis on the
    %spectra files generated through the spectra process.
    %   The types of anaysis provided:
    
    
    
    properties
        myFile
        names
        spectras
    end
    
    methods
        
        function thinking = Analysis (filename)
           
            thinking.myFile = filename;
            readFile(thinking);
            
            
        end
        
        function readFile(thinking)
            
           fileID = fopen(thinking.myFile);
           param = textscan(fileID, '%d', 2, 'Delimiter', '/');
           nums = param{1, 1};
           
           sav = nums(1);
           scan = nums(2);
           
           titles = textscan(fileID, '%s', sav, 'Delimiter', '~');
           thinking.names = titles{1, 1};
           
           for k = 1:sav
                   data = textscan(fileID, '%f', scan, 'Delimiter', sprintf('\n'));
                   next = data{1,1};
                   thinking.spectras = [thinking.spectras next];
           end
           
          
        end
        
    end
    
end

