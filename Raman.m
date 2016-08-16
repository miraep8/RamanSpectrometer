classdef Raman < spectra_Class
    %Raman  This class is an extension of the Spectra Class.  Its function
    %is to create the specialized type of plot that is specific for a Raman
    %plot.
    %   The Raman class extends the spectra_Class by averaging the data to
    %   be plotted for the graph.  It works best if several dark samples
    %   are taken to cancel out the background noise.
    
    % Author Mirae Parker
    % Last Edit: 11.08.16
    
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
        recentChange = 1;               %Bool keeps track if recent x axis change needs update. 
        
        x_Mes2 = 'Wavenumber';
        x_Mes1 = 'Wavelength (nm)';
        
    end, 
    
    methods
        
        function raman = Raman
           
            raman@spectra_Class;
            %declaration and placement of Raman Specific buttons
            raman.radio_Panel = uibuttongroup(raman.body, 'Title', 'Wavelength of Laser', 'Position', [.85, .22, .1, .14]);
            raman.normal_Spectrum = uicontrol(raman.radio_Panel, 'Style', 'radiobutton', 'String', raman.normalText, 'Position', [12, 60, 140, 15], 'Callback', @raman.normal_Callback);
            raman.greenLight_532 = uicontrol(raman.radio_Panel, 'Style', 'radiobutton', 'String', raman.greenText, 'Position', [12, 10, 140, 15], 'Callback', @raman.green_Callback);
            raman.redLight_633 = uicontrol(raman.radio_Panel, 'Style', 'radiobutton', 'String', raman.redText, 'Position', [12, 35, 140, 15], 'Callback', @raman.red_Callback);
            dark = Backdrop_Sample(raman.scans_Num, raman.int_Num, raman.xMin_Num, raman.xMax_Num, raman.dark_Back);
            raman.dark_Spectrum = dark.back_Spectrum;
            
            while raman.keepGraphing == 1
                if raman.halt == 0
                ramanPlot(raman)
                end
                pause(.1)
            end  
            
            
        end
        
        function normal_Callback(raman, hObject, eventdata)
            raman.cutoff = 0;
            raman.x_Text = raman.x_Mes1;
            raman.recentChange = 0;
        end
         
        function green_Callback(raman, hObject, eventdata)
            raman.cutoff = 532;
            raman.x_Text = raman.x_Mes2;
            raman.recentChange = 0;
        end
         
        function red_Callback(raman, hObject, eventdata)
            raman.cutoff = 633;
            raman.x_Text = raman.x_Mes2;
            raman.recentChange = 0;
        end
        
        %this plot function runs continually, wheich means that the spectra
        %is continuosly updated, creating a continuously updated Data.  It
        %overrides the plot function from the original specra_Class
        %superclass, and does a bit of algebra on the spectrum to calculate
        %the Raman shift for the x axis. 
        function ramanPlot(raman)
   
            plotSpectra(raman)
            
            if raman.cutoff ~= 0
                raman.wavelengths = ((1/raman.cutoff) - 1./raman.wavelengths)*10^7;
            end
            
            if raman.recentChange == 0
                raman.recentChange = 1;
                raman.xMin_Num = raman.wavelengths(1);
                raman.xMax_Num = raman.wavelengths(length(raman.wavelenghts));
            end
                
            plot(raman.graph, raman.wavelengths, raman.spectrum)
            xlim([raman.xMin_Num, raman.xMax_Num])
            xlabel(raman.x_Text)
            ylabel(raman.y_Text)
        end
    end
    
end

