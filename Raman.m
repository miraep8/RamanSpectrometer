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
        Radio_Panel
        
        cutoff = 0;                 %Variables for data manipulation
        greenText = 'Green (532)';
        redText = 'Red (633)';
        normalText = 'No Laser';
        ramanShift;
        
    end, 
    
    methods
        
        function raman = Raman
           
            %declaration and placement of Raman Specific buttons
            raman.Radio_Panel = uibuttongroup(raman.Body, 'Title', 'Wavelength of Laser', 'Position', [.85, .22, .1, .14]);
            raman.normal_Spectrum = uicontrol(raman.Radio_Panel, 'Style', 'radiobutton', 'String', raman.normalText, 'Position', [12, 60, 140, 15], 'Callback', @raman.normal_Callback);
            raman.greenLight_532 = uicontrol(raman.Radio_Panel, 'Style', 'radiobutton', 'String', raman.greenText, 'Position', [12, 10, 140, 15], 'Callback', @raman.green_Callback);
            raman.redLight_633 = uicontrol(raman.Radio_Panel, 'Style', 'radiobutton', 'String', raman.redText, 'Position', [12, 35, 140, 15], 'Callback', @raman.red_Callback);
            
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
        
        function plot_Callback(raman, hObject, eventdata)
            plot_Callback@super.plot_Callback(raman, hObject, eventdata)
            if raman.cutoff ~= 0
                raman.ramanShift = ((1/raman.cutoff) - 1./raman.Wavelengths)*10^7;
            else
                raman.ramanShift = raman.Wavelengths;
            end
            plot(raman.Graph, raman.spectrum, raman.ramanShift)
        end
    end
    
end

