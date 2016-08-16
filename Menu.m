classdef Menu < handle
    
    %Menu is a GUI that allows the user the opportunity to choose
    % what type of spectral analysis they would like to perform
    %   It calls each of the other spectral classes if the 
    %   correct button is pressed. 
    
    % Author Mirae Parker
    % Last Edit: 18.07.16
    
    
    properties
        
        body                    %A GUI figure which stores the GUI objects
        trans_Button            %The button which opens the Tranmittion interface
        trans_Pic               %The axis holding the snazzy transmition image
        abs_Button              %The button which opens the Absorbtion interface
        abs_Pic                 %Not what it sounds like, just another image storing axis
        reflect_Button          %The button which opens the Reflection interface
        reflect_Pic             %Axis storing the Reflect image
        raman_Button            %The button which opens the Raman interface
        raman_Pic               %Axis which stores the Raman image
        background              %Axis which will store the professional-looking backdrop
        
        
        picture                 %Stores the background picture for the Menu App

        
       
    end
    
    methods
        
        %This function descripes the properties of each of the GUI objects,
        %callbacks, locations etc, and is run at the opening of the GUI.
        function menu = Menu
            
            
            menu.body = figure('Position', [350, 160, 900, 550]);
            menu.background = axes('Parent', menu.body, 'Position', [0,0,1,1]);
            menu.picture = imread('Images/Menu_Backdrop.png');
            image(menu.background, menu.picture)
            axis off
            
            menu.trans_Button = uicontrol(menu.body, 'ForegroundColor', [1,1,1],  'BackgroundColor', [.05, .05, .4], 'Style', 'pushbutton', 'Position', [715, 270, 170, 40], 'String', 'Transmittance','FontSize', 20, 'Callback', @menu.transButton_Callback);
            menu.reflect_Button = uicontrol(menu.body, 'ForegroundColor', [1,1,1],  'BackgroundColor', [.1, .1, .4], 'Style', 'pushbutton', 'Position', [490, 270, 170, 40], 'String', 'Reflectance','FontSize', 20, 'Callback', @menu.reflectButton_Callback);
            menu.abs_Button = uicontrol(menu.body, 'ForegroundColor', [1,1,1], 'BackgroundColor', [.15, .15, .4], 'Style', 'pushbutton', 'Position', [260, 270, 170, 40], 'String', 'Absorbance','FontSize', 20, 'Callback', @menu.absButton_Callback);
            menu.raman_Button = uicontrol(menu.body, 'ForegroundColor', [1,1,1], 'BackgroundColor', [.2, .2, .4], 'Style', 'pushbutton', 'Position', [25, 270, 170, 40], 'String', 'Raman','FontSize', 20, 'Callback', @menu.ramanButton_Callback);
            
            end
            
        %opens the Trans class when the button is clicked
        function transButton_Callback(menu, hObject, eventdata)
            
            regular_Spectra(0)
            
        end
        
        %opens the Reflect class when the button is clicked        
        function reflectButton_Callback(menu, hObject, eventdata)
            
            regular_Spectra(0)
            
        end
        
        %opens the Abs class when the button is clicked         
        function absButton_Callback(menu, hObject, eventdata)
              
            regular_Spectra(1)
        end
        
        %opens the Raman class when the button is clicked         
        function ramanButton_Callback(menu, hObject, eventdata)
            
            Raman
            
        end
        
    end
    
end