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
        baseline
        sam_Label
        
        num = 1;
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
            thinking.samples = uicontrol('Parent', thinking.body, 'Style', 'popupmenu', 'String', thinking.names, 'Position', [1100, 430, 150, 170], 'Callback', @thinking.list_Callback);
            thinking.baseline = uicontrol('Parent', thinking.body, 'Style', 'pushbutton', 'String', 'Base Line', 'Position', [1100, 200, 50, 30], 'Callback', @thinking.base_Callback);
            thinking.sam_Label = uicontrol(thinking.body, 'Style', 'text', 'String', 'Samples:', 'Position', [1150, 610, 50, 20]);
            
        end
        
        function base_Callback (thinking, hObject, eventdata)
           
            base = msbackadj(thinking.xaxis(thinking.num), thinking.spectras(thinking.num));
            hold on 
            plot(thinking.graph, thinking.xaxis(:,thinking.num), base)
            
        end
        
        function list_Callback(thinking, hObject, eventdata)
            
            thinking.num = get(hObject, 'Value');
            plot(thinking.graph, thinking.xaxis(:,thinking.num), thinking.spectras(:,thinking.num))
            xlim( [thinking.xaxis(thinking.num), thinking.xaxis(length(thinking.xaxis))])
            
        end
        
        function readFile(thinking)
            
           fileID = fopen(thinking.myFile);
           param = textscan(fileID, '%d', 2, 'Delimiter', '/');
           data = param{1, 1};
           
           thinking.sav = data(1);
           thinking.scan = data(2);
           
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

