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
        
                   %GUI Objects
        greenLight_532          %the Radio-Button that indicates Green Raman       
        redLight_633            %the Radio-Button that indicates Red Raman
        normal_Spectrum         %the Radio Button that indicates normal spectrum
        radio_Panel             %the panel which contains all the radiobuttons
        
                   %Variables for data manipulation
        cutoff = 0;                     %Orginally cutoff is at 0, regualar spectrum         
        greenText = 'Green (532)';      %The text labeling the Green button
        redText = 'Red (633)';          %The text labeling the Red button
        normalText = 'No Laser';        %The text labeling the Normal button
        ramanShift;                     %The vector which will contain the Raman Shift wavelengths
        
    end, 
    
    methods
        
        function raman = Raman
           
            raman@spectra_Class;
            %declaration and placement of Raman Specific buttons
            raman.radio_Panel = uibuttongroup(raman.body, 'Title', 'Wavelength of Laser', 'Position', [.85, .22, .1, .14]);
            raman.normal_Spectrum = uicontrol(raman.radio_Panel, 'Style', 'radiobutton', 'String', raman.normalText, 'Position', [12, 60, 140, 15], 'Callback', @raman.normal_Callback);
            raman.greenLight_532 = uicontrol(raman.radio_Panel, 'Style', 'radiobutton', 'String', raman.greenText, 'Position', [12, 10, 140, 15], 'Callback', @raman.green_Callback);
            raman.redLight_633 = uicontrol(raman.radio_Panel, 'Style', 'radiobutton', 'String', raman.redText, 'Position', [12, 35, 140, 15], 'Callback', @raman.red_Callback);

            while raman.keepGraphing == 1
                ramanPlot(raman)
                pause(.2)
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
        
        %this plot function runs continually, wheich means that the spectra
        %is continuosly updated, creating a continuously updated Data.  It
        %overrides the plot function from the original specra_Class
        %superclass, and does a bit of algebra on the spectrum to calculate
        %the Raman shift for the x axis. 
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

