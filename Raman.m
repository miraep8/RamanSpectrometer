classdef Raman < spectra_Class
    %Raman  This class is an extension of the Spectra Class.  Its function
    %is to create the specialized type of plot that is specific for a Raman
    %plot.
    %   The Raman class extends the spectra_Class by averaging the data to
    %   be plotted for the graph.  It works best if several dark samples
    %   are taken to cancel out the background noise.
    
    % Author Mirae Parker
    % Last Edit: 19.08.16
    
    properties
        
                   %GUI Objects
        greenLight_532          %the Radio-Button that indicates Green Raman       
        redLight_633            %the Radio-Button that indicates Red Raman
        normal_Spectrum         %the Radio Button that indicates normal spectrum
        radio_Panel             %the panel which contains all the radiobuttons
        imaging2D_Panel         %the panel which allopws the user to seelect size of Raman imaging
        xDim_Text               %editable text to change x dimension in the scanning range
        yDim_Text               %editable text to change y dimension in the scanning range.
        xDim_Label              %label for the xDim
        yDim_Label              %label for the yDim
        
                   %Variables for data manipulation
        cutoff = 0;                     %Orginally cutoff is at 0, regualar spectrum         
        greenText = 'Green (532)';      %The text labeling the Green button
        redText = 'Red (633)';          %The text labeling the Red button
        normalText = 'No Laser';        %The text labeling the Normal button
        recentChange = 1;               %Bool keeps track if recent x axis change needs update. 
        
        x_Mes2 = 'Wavenumber';
        x_Mes1 = 'Wavelength (nm)';
        
        xDim = 1;
        yDim = 1;
        
    end, 
    
    methods
        
        function raman = Raman
           
            raman@spectra_Class;
            %declaration and placement of Raman Specific buttons
            raman.radio_Panel = uibuttongroup(raman.body, 'Title', 'Wavelength of Laser', 'Position', [.85, .22, .1, .14]);
            raman.normal_Spectrum = uicontrol(raman.radio_Panel, 'Style', 'radiobutton', 'String', raman.normalText, 'Position', [12, 60, 140, 15], 'Callback', @raman.normal_Callback);
            raman.greenLight_532 = uicontrol(raman.radio_Panel, 'Style', 'radiobutton', 'String', raman.greenText, 'Position', [12, 10, 140, 15], 'Callback', @raman.green_Callback);
            raman.redLight_633 = uicontrol(raman.radio_Panel, 'Style', 'radiobutton', 'String', raman.redText, 'Position', [12, 35, 140, 15], 'Callback', @raman.red_Callback);
            dark = Backdrop_Sample(raman.scans_Num, raman.int_Num, raman.xMin_Num, raman.xMax_Num);
            raman.dark_Spectrum = dark.back_Spectrum;
            raman.imaging2D_Panel = uipanel(raman.body, 'Title', 'Dimensions of 2D image', 'Position', [.85, .4, .1, .1]);
            raman.xDim_Text = uicontrol(raman.imaging2D_Panel, 'Style', 'edit', 'Position', [62, 10, 50, 20], 'String', num2str(raman.xDim), 'Callback', @raman.xDim_Callback);
            raman.yDim_Text = uicontrol(raman.imaging2D_Panel, 'Style', 'edit', 'Position', [62, 40, 50, 20], 'String', num2str(raman.yDim), 'Callback', @raman.yDim_Callback);
            raman.xDim_Label = uicontrol(raman.imaging2D_Panel, 'Style', 'text', 'Position', [12, 40, 50, 20], 'String', 'X Dim:');
            raman.yDim_Label = uicontrol(raman.imaging2D_Panel, 'Style', 'text', 'Position', [12, 10, 50, 20], 'String', 'Y Dim:');
            
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
                raman.xMax_Num = raman.wavelengths(length(raman.wavelengths));
            end
            
            if raman.saving == 1
               
                ramanSaving(raman)
                
            end
                
                
            plot(raman.graph, raman.wavelengths, raman.spectrum)
           
            hold on
            [~, n] = size(raman.saved_Spectra);
            for k = 1:n
               plot(raman.graph, raman.wavelengths, raman.saved_Spectra(:, k)) 
            end
            
            hold off    
            
            xlim([raman.xMin_Num, raman.xMax_Num])
            xlabel(raman.x_Text)
            ylabel(raman.y_Text)
        end
        
        function ramanSaving(raman)
            
            raman.saving = 0;
            raman.saved_Waves = [raman.saved_Waves transpose(raman.wavelengths)];
            
            for k = 1:raman.num_Saved
                dlmwrite(raman.filename, raman.saved_Waves(:, k), '-append', 'delimiter', ' ')
            end
            
        end
    end
    
    
    
end

