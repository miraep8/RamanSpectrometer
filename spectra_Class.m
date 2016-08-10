classdef spectra_Class < handle
    %Spectra Class contains all of the common GUI functionality for the
    %Spectra GUIS.
    %   It controls the basic interfaces and common handles for things like
    %   controlling the x limits and sizing the various components.

    
    properties
                                 %GUI Objects
        body                    %the container/background for the whole app
        background              %the axis for the background image
        graph                   %the axis for the graph
        xMin                    %the editable text which changes the XMin_Num
        xMax                    %the editable text which changes the XMax_Num
        scans                   %the editable text which changes the Scans_Num
        integration             %%the editable text which changes the Int_Num
        xMin_Label              %Holds text label for XMin Button
        xMax_Label              %Holds text label for XMax Button
        scans_Label             %Holds text label for Scans Button
        int_Label               %Holds text label for Int Button
        limits_Panel            %The panel containing the X Limit controls
        specta_Panel            %The panel containing the scans/int controls
        sample_Panel            %The panel for the dark (and in subclasses) light sampling
        dark_Sample             %The toggle-button for the Dark background sample 
        pause                   %UIControl to pause graphing
        stop                    %UIcontrol to stop graphing and exit program
        
                        %Variables for Data Processing
        dark_Spectrum ;         %stores the electrical dark vector sample       
        dark_Size = 0;          %records how many spectra have been used to make the daks sample
        new_Dark = 1;           %tracks if it is the first dark-spectra
        dark_Bool = 0;          %records whether or not the program should be collecting dark samples
        scans_Num = 50;         %the number of scans to average the spectrometer should take
        int_Num = 1000;         %the integration time of the spectrometer in ms
        xMin_Num         %the min x axis value displayed.
        xMax_Num        %the max x axis value displayed
        spectrum                %stores the latest spectrum from spectrometer
        wavelengths             %stores the latest wavelengths from the spectrometer
        picture                 %holds the image that is put on the background
        keepGraphing = 1;       %keeps track of whether subclasses should keep updating. 
        halt = 0;
        
                        %Beginning Strings
        xMin_Start               %the default X Min read at the beggining                        
        xMax_Start               %the default X MAx read at the beginning
        int_Start = '1000';      %the original int time text
        scans_Start = '50';      %the original scans to average text
        
                        %Labels for UIControls
        xMin_Label_Text = 'X axis Min Value';   %label for XMin
        xMax_Label_Text = 'X axis Max Value';   %label for XMax
        scans_Label_Text = 'Number of Scans per Average';   %label for scans
        int_Label_Text = 'Integration Time (ms)';   %label for int time
        
    end
    
    methods
        
        function app = spectra_Class
            %This is the constructor.  It runs when a new object is created
            %it is written in a way to make the graphics between all of
            %the programs fundamentally similar.
            
            
            global NUM_SCANS
            app.dark_Spectrum = zeros(1, NUM_SCANS);
            
            [yValues, xValues] = spectraWizard(app.scans_Num, app.int_Num);
            app.xMin_Num = xValues(1);
            app.xMax_Num = xValues(length(xValues));
            app.xMax_Start = num2str(app.xMax_Num); 
            app.xMin_Start = num2str(app.xMin_Num);
            
            app.body = figure('Position', [100, 50, 1300, 700]);
            app.background = axes('Parent', app.body, 'Position', [0,0,1,1]);
            app.picture = imread('Images/app_background.jpg');
            image(app.background, app.picture)
            axis off
            app.limits_Panel = uipanel( app.body, 'Title', 'Control X Axis', 'Position', [.85,.55 ,.1,.185]);
            app.specta_Panel = uipanel(app.body, 'Title', 'Spectrum Sampling', 'Position', [.85, .77, .1, .2]);
            app.sample_Panel = uipanel(app.body, 'Title', 'Background Sampling', 'Position', [.85, .37, .1, .09]);
            app.xMin = uicontrol(app.limits_Panel, 'Style', 'edit', 'Position', [15, 10, 100, 20], 'String', app.xMin_Start, 'Callback', @app.xMin_Callback); 
            app.xMax = uicontrol(app.limits_Panel, 'Style', 'edit', 'Position', [15, 60, 100, 20], 'String', app.xMax_Start, 'Callback', @app.xMax_Callback);
            app.scans = uicontrol(app.specta_Panel, 'Style', 'edit', 'Position', [15, 10, 100, 20], 'String', app.scans_Start, 'Callback', @app.scans_Callback); 
            app.integration = uicontrol(app.specta_Panel, 'Style', 'edit', 'Position', [15, 67, 100, 20], 'String', app.int_Start, 'Callback', @app.int_Callback);
            app.xMin_Label = uicontrol(app.limits_Panel, 'Style', 'text', 'String', app.xMin_Label_Text, 'Position', [15, 35, 100, 20]);          
            app.xMax_Label = uicontrol(app.limits_Panel, 'Style', 'text', 'String', app.xMax_Label_Text, 'Position', [15, 85, 100, 20]); 
            app.scans_Label = uicontrol(app.specta_Panel, 'Style', 'text', 'String', app.scans_Label_Text, 'Position', [15, 33, 100, 30]); 
            app.int_Label = uicontrol(app.specta_Panel, 'Style', 'text', 'String', app.int_Label_Text, 'Position', [15, 91, 100, 30]); 
            app.dark_Sample = uicontrol(app.sample_Panel, 'Style', 'togglebutton', 'String', 'Dark Sample', 'Position', [15, 20, 100, 17], 'Callback', @app.dark_Spectra_Callback);
            app.pause = uicontrol(app.body, 'Style', 'togglebutton', 'String', 'Pause', 'Position', [15, 20, 100, 17], 'Callback', @app.pause_Callback);
            app.graph = axes('Parent', app.body, 'Position', [.07,.1,.75,.8], 'XLim', [app.xMin_Num, app.xMax_Num]);
            
            uistack(app.graph, 'down')
            
        end
    
        %triggered when the text in XMin is changed.  This updates the Xmin
        %of the object, meaning that the axis limits on the next plot will
        %change as well. 
        function xMin_Callback(app, hObject, eventdata)
            
            app.xMin_Num = str2double(get(hObject, 'String'));
            
        end
        
        %triggered when the text in XMax is changed.  This updates the Xmax
        %of the object, meaning that the axis limits on the next plot will
        %change as well. 
        function xMax_Callback(app, hObject, eventdata)
            
            app.xMax_Num = str2double(get(hObject, 'String'));
            
        end
        
        %triggered when the text in the Scans per average field is changed.
        %This updates the scans property of the object, meaning that the
        %number of scans of the next spectrum will change as well.         
        function scans_Callback(app, hObject, eventdata)
            
            app.scans_Num = str2double(get(hObject, 'String'));
            
        end
        
        %triggered when the text in the Integration time field is changed.
        %This updates the int property of the object, meaning that the
        %integration time of the next spectrum will change as well.
        function int_Callback(app, hObject, eventdata)
            
            app.int_Num = str2double(get(hObject, 'String'))*1000;
            
        end
        
        function pause_Callback(app, hObject, eventdata)
            
            pressed = get(hObject, 'Value');
            if pressed == get(hObject, 'Max')
                app.halt = 1;
            elseif pressed == get(hObject, 'Min')
                app.halt = 0;
            end
            
        end
        
        %This is a generic plot function which does a few basic actions of
        %plotting.  Many of the subclasses overwride this to some degree,
        %but it takes care of the graphics, as well as updating the
        %darkSpectrum, and preparing data. 
        function plot(app)
            
            uistack(app.graph, 'top')
            
           [app.spectrum, app.wavelengths] = spectraWizard(app.scans_Num, app.int_Num);
           
            if app.dark_Bool == 0
                
                if app.new_Dark == 1
                    global NUM_SCANS
                    app.new_Dark = 0;
                    app.dark_Spectrum = zeros(1, NUM_SCANS);
                    app.dark_Size = 0;
                end
                
                next = app.dark_Spectrum*app.dark_Size + app.spectrum;
                app.dark_Spectrum = next/(app.dark_Size + 1);
                app.dark_Size = app.dark_Size + 1;
                
            end
            
            app.spectrum = app.spectrum - app.dark_Spectrum;
%             app.Spectrum = smoothing(app.Spectrum); 
             
            
        end
        
        %function monitors the Dark Spectra button, when it is initiated it
        %begins a new dark spectra sampling process.  When it is toggeled
        %off it switches off the sampling process for plot as well. 
        function dark_Spectra_Callback(app, hObject, eventdata)
            
            pressed = get(hObject, 'Value');
            if pressed == get(hObject, 'Max')
                app.dark_Bool = 0;
                app.new_Dark = 1;
                app.dark_Size = 0;
            elseif pressed == get(hObject, 'Min')
                app.dark_Bool = 1;
            end
        end
    end
end

