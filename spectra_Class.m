classdef spectra_Class < handle
    %Spectra Class contains all of the common GUI functionality for the
    %Spectra GUIS.
    %   It controls the basic interfaces and common handles for things like
    %   controlling the x limits and sizing the various components.
    
    properties
                                 %GUI Objects
        Body                    %the container/background for the whole app
        Background              %the axis for the background image
        Graph                   %the axis for the graph
        XMin                    %the editable text which changes the XMin_Num
        XMax                    %the editable text which changes the XMax_Num
        Scans                   %the editable text which changes the Scans_Num
        Integration             %%the editable text which changes the Int_Num
        XMin_Label              %Holds text label for XMin Button
        XMax_Label              %Holds text label for XMax Button
        Scans_Label             %Holds text label for Scans Button
        Int_Label               %Holds text label for Int Button
        Limits_Panel
        Specta_Panel
        Sample_Panel
        Plot
        Dark_Sample
        
        Dark_Spectrum ;         %Variables for Data Processing
        Dark_Size = 0;
        New_Dark = 1;
        Dark_Bool = 0;
        Scans_Num
        Int_Num
        XMin_Num = 200;
        XMax_Num = 1000;
        Spectrum
        Wavelengths
        Picture                 %holds the image that is put on the background
        
        XMin_Start = '200';                           %Beginning Strings
        XMax_Start = '1000';
        Int_Start = '1000';
        Scans_Start = '50';
        
        XMin_Label_Text = 'X axis Min Value';
        XMax_Label_Text = 'X axis Max Value';
        Scans_Label_Text = 'Number of Scans per Average';
        Int_Label_Text = 'Integration Time (ms)';
        
    end
    
    methods
        
        function app = spectra_Class
            %This is the constructor.  It runs when a new object is created
            %it is written in a way to make the graphics between all of
            %the programs fundamentally similar.
            
            
            global NUM_SCANS
            app.Dark_Spectrum = zeros(1, NUM_SCANS);
            
            app.Body = figure('Position', [100, 50, 1300, 700]);
            app.Background = axes('Parent', app.Body, 'Position', [0,0,1,1]);
            app.Picture = imread('Images/app_background.jpg');
            image(app.Background, app.Picture)
            axis off
            app.Limits_Panel = uipanel( app.Body, 'Title', 'Control X Axis', 'Position', [.85,.55 ,.1,.185]);
            app.Specta_Panel = uipanel(app.Body, 'Title', 'Spectrum Sampling', 'Position', [.85, .77, .1, .2]);
            app.Sample_Panel = uipanel(app.Body, 'Title', 'Background Sampling', 'Position', [.85, .37, .1, .09]);
            app.XMin = uicontrol(app.Limits_Panel, 'Style', 'edit', 'Position', [15, 10, 100, 20], 'String', app.XMin_Start, 'Callback', @app.XMin_Callback); 
            app.XMax = uicontrol(app.Limits_Panel, 'Style', 'edit', 'Position', [15, 60, 100, 20], 'String', app.XMax_Start, 'Callback', @app.XMax_Callback);
            app.Scans = uicontrol(app.Specta_Panel, 'Style', 'edit', 'Position', [15, 10, 100, 20], 'String', app.Scans_Start, 'Callback', @app.Scans_Callback); 
            app.Integration = uicontrol(app.Specta_Panel, 'Style', 'edit', 'Position', [15, 67, 100, 20], 'String', app.Int_Start, 'Callback', @app.Int_Callback);
            app.XMin_Label = uicontrol(app.Limits_Panel, 'Style', 'text', 'String', app.XMin_Label_Text, 'Position', [15, 35, 100, 20]);          
            app.XMax_Label = uicontrol(app.Limits_Panel, 'Style', 'text', 'String', app.XMin_Label_Text, 'Position', [15, 85, 100, 20]); 
            app.Scans_Label = uicontrol(app.Specta_Panel, 'Style', 'text', 'String', app.Scans_Label_Text, 'Position', [15, 33, 100, 30]); 
            app.Int_Label = uicontrol(app.Specta_Panel, 'Style', 'text', 'String', app.Int_Label_Text, 'Position', [15, 91, 100, 20]); 
            app.Plot = uicontrol(app.Body, 'Style', 'pushbutton', 'String', 'Plot', 'Position', [1120, 338, 100, 30], 'Callback', @app.plot_Callback);
            app.Dark_Sample = uicontrol(app.Sample_Panel, 'Style', 'togglebutton', 'String', 'Dark Sample', 'Position', [15, 20, 100, 17], 'Callback', @app.Dark_Spectra_Callback);
            app.Graph = axes('Parent', app.Body, 'Position', [.07,.1,.75,.8], 'XLim', [app.XMin_Num, app.XMax_Num]);
            
            uistack(app.Graph, 'down')
            
            
        end
    
        %triggered when the text in XMin is changed.  This updates the Xmin
        %of the object, meaning that the axis limits on the next plot will
        %change as well. 
        function XMin_Callback(app, hObject, eventdata)
            
            app.XMin_Num = str2double(get(hObject, 'String'));
            
        end
        
        %triggered when the text in XMax is changed.  This updates the Xmax
        %of the object, meaning that the axis limits on the next plot will
        %change as well. 
        function XMax_Callback(app, hObject, eventdata)
            
            app.XMax_Num = str2double(get(hObject, 'String'));
            
        end
        
        %triggered when the text in the Scans per average field is changed.
        %This updates the scans property of the object, meaning that the
        %number of scans of the next spectrum will change as well.         
        function Scans_Callback(app, hObject, eventdata)
            
            app.Scans_Num = str2double(get(hObject, 'String'));
            
        end
        
        %triggered when the text in the Integration time field is changed.
        %This updates the int property of the object, meaning that the
        %integration time of the next spectrum will change as well.
        function Int_Callback(app, hObject, eventdata)
            
            app.Int_Num = str2double(get(hObject, 'String'))*1000;
            
        end
        
        %This is a generic plot function which does a few basic actions of
        %plotting.  Many of the subclasses overwride this to some degree,
        %but it takes care of the graphics, as well as updating the
        %darkSpectrum, and preparing data. 
        function plot_Callback(app, hObject, eventdata)
            
            app.Picture = imread('plot_background.jpg');
            image(app.Background, app.Picture)
            axis off
            
            uistack(app.Graph, 'top')
            
           [app.Spectrum, app.Wavelengths] = spectraWizard(app.Scans_Num, app.Int_Num);
           
            if app.Dark_Bool == 0
                
                if app.New_Dark == 1
                    global NUM_SCANS
                    app.New_Dark = 0;
                    app.Dark_Spectrum = zeros(1, NUM_SCANS);
                    app.Dark_Size = 0;
                end
                
                next = app.Dark_Spectrum*app.Dark_Size + app.Spectrum;
                app.Dark_Spectrum = next/(app.Dark_Size + 1);
                app.Dark_Size = app.Dark_Size + 1;
                
            end
            
            app.Spectrum = app.Spectrum - app.Dark_Spectrum;
            app.spectrum = smoothing(app.spectrum); 
             
            
        end
        
        function Dark_Spectra_Callback(app, hObject, eventdata)
            
            pressed = get(hObject, 'Value');
            if pressed == get(hObject, 'Max')
                app.Dark_Bool = 0;
                app.New_Dark = 1;
                app.Dark_Size = 0;
            elseif pressed == get(hObject, 'Min')
                app.Dark_Bool = 1;
            end
        end
    end
end

