function varargout = Absorbance_Spectra(varargin)
% ABSORBANCE_SPECTRA MATLAB code for Absorbance_Spectra.fig
%      ABSORBANCE_SPECTRA, by itself, creates a new ABSORBANCE_SPECTRA or raises the existing
%      singleton*.
%
%      H = ABSORBANCE_SPECTRA returns the handle to a new ABSORBANCE_SPECTRA or the handle to
%      the existing singleton*.
%
%      ABSORBANCE_SPECTRA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ABSORBANCE_SPECTRA.M with the given input arguments.
%
%      ABSORBANCE_SPECTRA('Property','Value',...) creates a new ABSORBANCE_SPECTRA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Absorbance_Spectra_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Absorbance_Spectra_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Absorbance_Spectra

% Last Modified by GUIDE v2.5 04-Jul-2016 15:48:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Absorbance_Spectra_OpeningFcn, ...
                   'gui_OutputFcn',  @Absorbance_Spectra_OutputFcn, ...
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


% --- Executes just before Absorbance_Spectra is made visible.
function Absorbance_Spectra_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Absorbance_Spectra (see VARARGIN)

% Choose default command line output for Absorbance_Spectra
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Absorbance_Spectra wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Absorbance_Spectra_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
