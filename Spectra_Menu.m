function varargout = Spectra_Menu(varargin)
% SPECTRA_MENU MATLAB code for Spectra_Menu.fig
%      SPECTRA_MENU, by itself, creates a new SPECTRA_MENU or raises the existing
%      singleton*.
%
%      H = SPECTRA_MENU returns the handle to a new SPECTRA_MENU or the handle to
%      the existing singleton*.
%
%      SPECTRA_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPECTRA_MENU.M with the given input arguments.
%
%      SPECTRA_MENU('Property','Value',...) creates a new SPECTRA_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Spectra_Menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Spectra_Menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Spectra_Menu

% Last Modified by GUIDE v2.5 04-Jul-2016 15:19:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Spectra_Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @Spectra_Menu_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Spectra_Menu is made visible.
function Spectra_Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Spectra_Menu (see VARARGIN)

% Choose default command line output for Spectra_Menu
handles.output = hObject;



addpath ('C:\Users\Public\Pictures\Sample Pictures\')

axes(handles.rainbow_backdrop)
backdropImage = imread ('Rainbow_Backdrop.jpg');
image(backdropImage)
axis off

axes(handles.Trans)
transmittancePic = imread ('Transmitted.jpg');
image(transmittancePic)
axis image
axis off

axes(handles.Abs)
absorbancePic = imread ('Absorbed.jpg');
image(absorbancePic)
axis image
axis off


axes(handles.Reflect)
reflectancePic = imread ('Reflective.jpg');
image(reflectancePic)
axis image
axis off

axes(handles.Raman_Pic)
ramanPic = imread ('Raman_Noodle_Pic.jpg');
image(ramanPic)
axis image
axis off


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Spectra_Menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Spectra_Menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Transmittance.
function Transmittance_Callback(hObject, eventdata, handles)
% hObject    handle to Transmittance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Transmittance_Spectra

% --- Executes on button press in Absorbance.
function Absorbance_Callback(hObject, eventdata, handles)
% hObject    handle to Absorbance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Absorbance_Spectra


% --- Executes on button press in Reflectance.
function Reflectance_Callback(hObject, eventdata, handles)
% hObject    handle to Reflectance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Reflectance_Spectra


% --- Executes on button press in Raman.
function Raman_Callback(hObject, eventdata, handles)
% hObject    handle to Raman (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Raman_Spectra
