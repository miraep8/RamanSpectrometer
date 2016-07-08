function varargout = Transmittance_Spectra(varargin)
% TRANSMITTANCE_SPECTRA MATLAB code for Transmittance_Spectra.fig
%      TRANSMITTANCE_SPECTRA, by itself, creates a new TRANSMITTANCE_SPECTRA or raises the existing
%      singleton*.
%
%      H = TRANSMITTANCE_SPECTRA returns the handle to a new TRANSMITTANCE_SPECTRA or the handle to
%      the existing singleton*.
%
%      TRANSMITTANCE_SPECTRA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRANSMITTANCE_SPECTRA.M with the given input arguments.
%
%      TRANSMITTANCE_SPECTRA('Property','Value',...) creates a new TRANSMITTANCE_SPECTRA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Transmittance_Spectra_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Transmittance_Spectra_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Transmittance_Spectra

% Last Modified by GUIDE v2.5 05-Jul-2016 09:17:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Transmittance_Spectra_OpeningFcn, ...
                   'gui_OutputFcn',  @Transmittance_Spectra_OutputFcn, ...
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


% --- Executes just before Transmittance_Spectra is made visible.
function Transmittance_Spectra_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Transmittance_Spectra (see VARARGIN)

% Choose default command line output for Transmittance_Spectra
handles.output = hObject;

global NUM_SCANS
handles.whiteStandard = zeros(1, NUM_SCANS);
handles.blackStandard = zeros(1, NUM_SCANS);
handles.whiteBool = 1;
handles.blackBool = 1;

handles.scans = 50;
handles.integration = 1000;
handles.xmin = 200;
handles.xmax = 1000;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Transmittance_Spectra wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Transmittance_Spectra_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in white.
function white_Callback(hObject, eventdata, handles)
% hObject    handle to white (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[spectra, wavelengths] = spectraWizard(handles.scans, handles.integration);
handles.whiteStandard = spectra;
handles.whiteBool = 0;

guidata(hObject, handles)


% --- Executes on button press in black.
function black_Callback(hObject, eventdata, handles)
% hObject    handle to black (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[spectra, wavelengths] = spectraWizard(handles.scans, handles.integration);
handles.blackStandard = spectra;
handles.blackBool = 0;

guidata(hObject, handles)

% --- Executes on button press in Plot_Button.
function Plot_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.blackBool == 0 && handles.whiteBool == 0
    [spectra, wavelengths] = spectraWizard(handles.scans, handles.integration);
    trans = (spectra - handles.blackStandard)./(handles.whiteStandard - handles.blackStandard);
    axes(handles.plotAxis)
    plot(wavelengths, trans)
    ylabel('Percent Transmitted')
    xlabel('Wavelenght')
    xlim([handles.xmin, handles.xmax])
    
else
    axes(handles.plotAxis)
    warning = imread ('Trans_Warning.jpg');
    image(warning)
    axis image
    
end

guidata(hObject, handles)



function scans_text_Callback(hObject, eventdata, handles)
% hObject    handle to scans_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scans_text as text
%        str2double(get(hObject,'String')) returns contents of scans_text as a double
   handles.scans = str2double(get(hObject, 'String'));
   
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function scans_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scans_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function int_time_Callback(hObject, eventdata, handles)
% hObject    handle to int_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of int_time as text
%        str2double(get(hObject,'String')) returns contents of int_time as a double
handles.integration = str2double(get(hObject, 'String'))*1000;


guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function int_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to int_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xMin_Callback(hObject, eventdata, handles)
% hObject    handle to xMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xMin as text
%        str2double(get(hObject,'String')) returns contents of xMin as a double
handles.xmin = str2double(get(hObject, 'String'));


guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function xMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xMax_Callback(hObject, eventdata, handles)
% hObject    handle to xMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xMax as text
%        str2double(get(hObject,'String')) returns contents of xMax as a double
handles.xmax = str2double(get(hObject, 'String'));


guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function xMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
