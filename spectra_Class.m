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
        limits_Panel
        specta_Panel
        sample_Panel
        dark_Sample
        
        dark_Spectrum ;         %Variables for Data Processing
        dark_Size = 0;
        new_Dark = 1;
        dark_Bool = 0;
        scans_Num = 50;
        int_Num = 1000;
        xMin_Num = 200;
        xMax_Num = 1000;
        spectrum
        wavelengths
        picture            %holds the image that is put on the background
        keepGraphing = 1;      %keeps track of whether subclasses should keep updating. 
        
        xMin_Start = '200';                           %Beginning Strings
        xMax_Start = '1000';
        int_Start = '1000';
        scans_Start = '50';
        
        xMin_Label_Text = 'X axis Min Value';
        xMax_Label_Text = 'X axis Max Value';
        scans_Label_Text = 'Number of Scans per Average';
        int_Label_Text = 'Integration Time (ms)';
        
    end
    
    methods
        
        function app = spectra_Class
            %This is the constructor.  It runs when a new object is created
            %it is written in a way to make the graphics between all of
            %the programs fundamentally similar.
            
            
            global NUM_SCANS
            app.dark_Spectrum = zeros(1, NUM_SCANS);
            
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
            app.graph = axes('Parent', app.body, 'Position', [.07,.1,.75,.8], 'XLim', [app.xMin_Num, app.xMax_Num]);
            
            uistack(app.graph, 'down')
%             
%             app.keepGraphing = 1;
%             while app.keepGraphing == 1
%                 plot(app)
%             end                
            
            
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

