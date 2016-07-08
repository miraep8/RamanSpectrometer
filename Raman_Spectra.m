
function varargout = Raman_Spectra(varargin)

%RAMAN_SPECTRA MATLAB code file for Raman_Spectra.fig
%      RAMAN_SPECTRA, by itself, creates a new RAMAN_SPECTRA or raises the existing
%      singleton*.
%
%      H = RAMAN_SPECTRA returns the handle to a new RAMAN_SPECTRA or the handle to
%      the existing singleton*.
%
%      RAMAN_SPECTRA('Property','Value',...) creates a new RAMAN_SPECTRA using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Raman_Spectra_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      RAMAN_SPECTRA('CALLBACK') and RAMAN_SPECTRA('CALLBACK',hObject,...) call the
%      local function named CALLBACK in RAMAN_SPECTRA.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Raman_Spectra

% Last Modified by Mirae Parker 01.07.16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Raman_Spectra_OpeningFcn, ...
                   'gui_OutputFcn',  @Raman_Spectra_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before Raman_Spectra is made visible.
function Raman_Spectra_OpeningFcn(hObject, eventdata, handles, varargin)

global NUM_SCANS
handles.output = hObject;

handles.scans = 50;
handles.integration = 1000;
handles.darkBool = 1;
handles.darkSpectra = zeros(1, NUM_SCANS);
handles.darkSize = 0;
handles.newDark = 0;
handles.cutoff = 0;
handles.xmin = 200;
handles.xmax = 1000;

axes(handles.background)
matlabImage = imread ('C:\Users\Public\Pictures\Sample Pictures\Raman_Backdrop.jpg');
image(matlabImage)
axis off



% Update handles structure
guidata(hObject, handles);


% UIWAIT makes Raman_Spectra wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Raman_Spectra_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on button press in dark_sample.
function dark_sample_Callback(hObject, eventdata, handles)
% hObject    handle to dark_sample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dark_sample
pressed = get(hObject, 'Value');
if pressed == get(hObject, 'Max')
    handles.darkBool = 0;
    handles.newDark = 1;
elseif pressed == get(hObject, 'Min')
    handles.darkBool = 1;
end

guidata(hObject, handles)


% --- Executes on button press in Plot_Button.
function Plot_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[spectrum, wavelengths] = spectraWizard(handles.scans, handles.integration);

wavelengths = wavelengths - handles.cutoff;

if handles.darkBool == 0
    
    if handles.newDark == 1
        global NUM_SCANS
        handles.newDark = 0;
        handles.darkSpectra = zeros(1, NUM_SCANS);
        handles.darkSize = 0;
    end 
    
    next = handles.darkSpectra*handles.darkSize + spectrum;
    div = next/(handles.darkSize + 1);
    handles.darkSpectra = div;
    handles.darkSize = handles.darkSize + 1;
    
end

spectrum = spectrum - handles.darkSpectra;



axes(handles.plot_background)
matlabImage = imread('C:\Users\Public\Pictures\Sample Pictures\plot_background.jpg');
image(matlabImage)
axis off

axes(handles.Spectrum_Plot)
plot(wavelengths, spectrum)
xlabel('Wavelengths')
ylabel('Intensity')
xlim([handles.xmin, handles.xmax])

guidata(hObject, handles);



function scan_input_Callback(hObject, eventdata, handles)
% hObject    handle to scan_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scan_input as text
%        str2double(get(hObject,'String')) returns contents of scan_input as a double
   handles.scans = str2double(get(hObject, 'String'));
   
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function scan_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scan_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function intTimeText_Callback(hObject, eventdata, handles)
% hObject    handle to intTimeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intTimeText as text
%        str2double(get(hObject,'String')) returns contents of intTimeText as a double

handles.integration = str2double(get(hObject, 'String'))*1000;


guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function intTimeText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intTimeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in green_532.
function green_532_Callback(hObject, eventdata, handles)
% hObject    handle to green_532 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of green_532

myState = get(hObject, 'Value');
if myState == get(hObject, 'Max')
    handles.cutoff = 532;
end

guidata(hObject, handles)


% --- Executes on button press in red_633.
function red_633_Callback(hObject, eventdata, handles)
% hObject    handle to red_633 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of red_633


myState = get(hObject, 'Value');
if myState == get(hObject, 'Max')
    handles.cutoff = 633;
end

guidata(hObject, handles)


% --------------------------------------------------------------------
function Camera_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to Camera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Xmin_Callback(hObject, eventdata, handles)
% hObject    handle to Xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Xmin as text
%        str2double(get(hObject,'String')) returns contents of Xmin as a double


handles.xmin = str2double(get(hObject, 'String'));


guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Xmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function XMaxText_Callback(hObject, eventdata, handles)
% hObject    handle to XMaxText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of XMaxText as text
%        str2double(get(hObject,'String')) returns contents of XMaxText as a double

handles.xmax = str2double(get(hObject, 'String'));


guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function XMaxText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XMaxText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in noShiftSpectra.
function noShiftSpectra_Callback(hObject, eventdata, handles)
% hObject    handle to noShiftSpectra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of noShiftSpectra
myState = get(hObject, 'Value');
if myState == get(hObject, 'Max')
    handles.cutoff = 0;
end

guidata(hObject, handles)
