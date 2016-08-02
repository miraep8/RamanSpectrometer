classdef Menu < handle
    
    %Menu is a GUI that allows the user the opportunity to choose
    % what type of spectral analysis they would like to perform
    %   It calls each of the other spectral classes if the 
    %   correct button is pressed. 
    
    % Author Mirae Parker
    % Last Edit: 18.07.16
    
    
    properties
        
        Body                    %A GUI figure which stores the GUI objects
        Trans_Button            %The button which opens the Tranmittion interface
        Trans_Pic               %The axis holding the snazzy transmition image
        Abs_Button              %The button which opens the Absorbtion interface
        Abs_Pic                 %Not what it sounds like, just another image storing axis
        Reflect_Button          %The button which opens the Reflection interface
        Reflect_Pic             %Axis storing the Reflect image
        Raman_Button            %The button which opens the Raman interface
        Raman_Pic               %Axis which stores the Raman image
        Background              %Axis which will store the professional-looking backdrop
        
        
        Picture                 %Stores the background picture for the Menu App
        T_Icon                  %Stores the transmittion picture
        A_Icon                  %Stores the Absorbance Picture
        Ra_Icon                 %Stores the Raman Picture
        Re_Icon                 %Stores the Reflected Icon
        
       
    end
    
    methods
        
        %This function descripes the properties of each of the GUI objects,
        %callbacks, locations etc, and is run at the opening of the GUI.
        function menu = Menu
           
            addpath('C:\Users\Public\Pictures\Sample Pictures\')                           %adds a path to where all the menu images are stored
            
            menu.Body = figure('Position', [350, 160, 900, 550]);
            menu.Background = axes('Parent', menu.Body, 'Position', [0,0,1,1]);
            
            menu.Picture = imread('Menu_Background.jpg');
            image(menu.Background, menu.Picture)
            axis off
            
            menu.Trans_Button = uicontrol(menu.Body, 'Style', 'pushbutton', 'Position', [710, 270, 100, 20], 'String', 'Transmittance', 'Callback', @menu.transButton_Callback);
            menu.Reflect_Button = uicontrol(menu.Body, 'Style', 'pushbutton', 'Position', [510, 270, 100, 20], 'String', 'Reflectance', 'Callback', @menu.reflectButton_Callback);
            menu.Abs_Button = uicontrol(menu.Body, 'Style', 'pushbutton', 'Position', [310, 270, 100, 20], 'String', 'Absorbance', 'Callback', @menu.absButton_Callback);
            menu.Raman_Button = uicontrol(menu.Body, 'Style', 'pushbutton', 'Position', [110, 270, 100, 20], 'String', 'Raman', 'Callback', @menu.ramanButton_Callback);
            
            
        end
        
        function transButton_Callback(menu, hObject, eventdata)
            
            Trans
            
        end
        
        function reflectButton_Callback(menu, hObject, eventdata)
            
            Reflect
            
        end
        
        function absButton_Callback(menu, hObject, eventdata)
              
            Abs
        end
        
        function ramanButton_Callback(menu, hObject, eventdata)
            
            Raman
            
        end
        
    end
    
end