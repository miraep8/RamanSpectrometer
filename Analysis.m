classdef Analysis < handle
    %Analysis is meant to be the class which perform the analysis on the
    %spectra files generated through the spectra process.
    %   The types of anaysis provided:
    
    
    
    properties
        
        body
        background
        graph
        samples
        xaxis
        
        myFile
        names
        spectras
        sav
        scan
        
    end
    
    methods
        
        function thinking = Analysis (filename)
           
            thinking.myFile = filename;
            readFile(thinking);
            
            thinking.body = figure('Position', [100, 50, 1300, 700]);
            thinking.background = axes('Parent', thinking.body, 'Position', [0,0,1,1]);
            thinking.graph = axes('Parent', thinking.body, 'Position', [.07,.1,.75,.8]);
            thinking.samples = uicontrol('Parent', thinking.body, 'Style', 'listbox', 'String', thinking.names, 'Position', [1100, 420, 150, 170], 'Callback', @thinking.list_Callback);
            
        end
        
        function list_Callback(thinking, hObject, eventdata)
            
            graphNum = get(hObject, 'Value');
            plot(thinking.graph, thinking.xaxis(:,graphNum), thinking.spectras(:,graphNum))
            xlim( [thinking.xaxis(graphNum), thinking.xaxis(length(thinking.xaxis))])
            
        end
        
        function readFile(thinking)
            
           fileID = fopen(thinking.myFile);
           param = textscan(fileID, '%d', 2, 'Delimiter', '/');
           nums = param{1, 1};
           
           thinking.sav = nums(1);
           thinking.scan = nums(2);
           
           titles = textscan(fileID, '%s', thinking.sav, 'Delimiter', '~');
           thinking.names = char(titles{1, 1});
           
           textscan(fileID, '%[~]', 1);
           
           for k = 1:thinking.sav
                   data = textscan(fileID, '%f', thinking.scan, 'Delimiter', sprintf('\n'));
                   next = data{1, 1};
                   thinking.spectras = [thinking.spectras next];
           end
           for k = 1:thinking.sav
                   data = textscan(fileID, '%f', thinking.scan, 'Delimiter', sprintf('\n'));
                   next = data{1, 1};
                   thinking.xaxis = [thinking.xaxis next];
           end
          
        end
        
    end
    
end

