classdef Raman < spectra_Class
    %Raman  This class is an extension of the Spectra Class.  Its function
    %is to create the specialized type of plot that is specific for a Raman
    %plot.
    %   The Raman class extends the spectra_Class by averaging the data to
    %   be plotted for the graph.  It works best if several dark samples
    %   are taken to cancel out the background noise.
    
    % Author Mirae Parker
    % Last Edit: 13.07.16
    
    properties
        
        greenLight_532          %GUI Objects
        redLight_633
        normal_Spectrum
        radio_Panel
        
        cutoff = 0;                 %Variables for data manipulation
        greenText = 'Green (532)';
        redText = 'Red (633)';
        normalText = 'No Laser';
        ramanShift;
        
    end, 
    
    methods
        
        function raman = Raman
           
            raman@spectra_Class;
            %declaration and placement of Raman Specific buttons
            raman.radio_Panel = uibuttongroup(raman.body, 'Title', 'Wavelength of Laser', 'Position', [.85, .22, .1, .14]);
            raman.normal_Spectrum = uicontrol(raman.radio_Panel, 'Style', 'radiobutton', 'String', raman.normalText, 'Position', [12, 60, 140, 15], 'Callback', @raman.normal_Callback);
            raman.greenLight_532 = uicontrol(raman.radio_Panel, 'Style', 'radiobutton', 'String', raman.greenText, 'Position', [12, 10, 140, 15], 'Callback', @raman.green_Callback);
            raman.redLight_633 = uicontrol(raman.radio_Panel, 'Style', 'radiobutton', 'String', raman.redText, 'Position', [12, 35, 140, 15], 'Callback', @raman.red_Callback);
            
            raman.keepGraphing = 1;
            while raman.keepGraphing == 1
                ramanPlot(raman)
                pause(1)
            end  
            
            
        end
        
        function normal_Callback(raman, hObject, eventdata)
            raman.cutoff = 0;
        end
         
        function green_Callback(raman, hObject, eventdata)
            raman.cutoff = 532;
        end
         
        function red_Callback(raman, hObject, eventdata)
            raman.cutoff = 633;
        end
        
        function ramanPlot(raman)
            plot(raman)
            if raman.cutoff ~= 0
                raman.ramanShift = ((1/raman.cutoff) - 1./raman.wavelengths)*10^7;
            else
                raman.ramanShift = raman.wavelengths;
            end
            plot(raman.graph, raman.ramanShift, raman.spectrum)
            xlim([raman.xMin_Num, raman.xMax_Num])
        end
    end
    
end

