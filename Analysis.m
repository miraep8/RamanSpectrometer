classdef Analysis < handle
    %Analysis is meant to be the class which perform the analysis on the
    %spectra files generated through the spectra process.
    %   The types of anaysis provided:
    
    
    %Author: Mirae Parker
    %Last Edit: 19.08.16
    
    
    
    properties
        
        body
        background
        graph
        samples
        xaxis
        baseline
        sam_Label
        wavelength
        
        num = 1;
        myFile
        names
        spectras
        sav
        scan
        xDim 
        yDim
        
    end
    
    methods
        
        function thinking = Analysis (filename)
           
            thinking.myFile = filename;
            [thinking.xaxis, thinking.spectras, thinking.xDim, thinking.yDim, thinking.names] = readFile(thinking.myFile);
            
            thinking.body = figure('Position', [100, 50, 1300, 700]);
            thinking.background = axes('Parent', thinking.body, 'Position', [0,0,1,1]);
            thinking.graph = axes('Parent', thinking.body, 'Position', [.07,.1,.75,.8]);
            thinking.samples = uicontrol('Parent', thinking.body, 'Style', 'popupmenu', 'String', thinking.names, 'Position', [1100, 430, 150, 170], 'Callback', @thinking.list_Callback);
            thinking.baseline = uicontrol('Parent', thinking.body, 'Style', 'pushbutton', 'String', 'Base Line', 'Position', [1100, 200, 50, 30], 'Callback', @thinking.base_Callback);
            thinking.sam_Label = uicontrol(thinking.body, 'Style', 'text', 'String', 'Samples:', 'Position', [1150, 610, 50, 20]);
            if thinking.xDim ~= 0 && thinking.yDim ~= 0
                thinking.wavelength = uicontrol(thinking.body, 'Style', 'edit', 'String', 'Wavelength', 'Position', [1200, 200, 50, 20], 'Callback', @thinking.map_Callback);
            end
        end
        
        function map_Callback(thinking, hObject, eventData)
            
            peaks =  str2double(get(hObject, 'String'));
            x = (1:thinking.xDim);
            y = (1:thinking.yDim);
            
            distance = abs(thinking.xaxis(1, 1) - peaks);
            index = 1;
            for n = 1:length(thinking.xaxis(:,1))
                m = thinking.xaxis(n, 1);
                newDis = abs(m -peaks);
                
                if newDis < distance
                    index = n;
                end    
            end
            
            C = zeros(thinking.xDim, thinking.yDim);
            temp = zeros(1, thinking.yDim);
            for k = 1:thinking.xDim
                for s = 1:thinking.yDim
                temp(s) = thinking.spectras(index, ((k-1)*thinking.yDim + s));
                end
                C(k, :) = (temp);
            end
            
            colormap hsv
            imagesc(thinking.graph, x, y, C)
            
        end
        
        function base_Callback (thinking, hObject, eventdata)
           
            base = msbackadj(thinking.xaxis(thinking.num), thinking.spectras(thinking.num));
            hold on 
            plot(thinking.graph, thinking.xaxis(:,thinking.num), base)
            
        end
        
        function list_Callback(thinking, hObject, eventdata)
            
            thinking.num = get(hObject, 'Value');
            plot(thinking.graph, thinking.xaxis(:,thinking.num), thinking.spectras(:,thinking.num))
            %xlim( [thinking.xaxis(thinking.num, 1), thinking.xaxis(thinking.num,length(thinking.xaxis(thinking.num,:)))])
            
        end
        
        
    end
    
end

