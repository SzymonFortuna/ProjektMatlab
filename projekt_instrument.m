function varargout = projekt_instrument(varargin)
% PROJEKT_INSTRUMENT MATLAB code for projekt_instrument.fig
%      PROJEKT_INSTRUMENT, by itself, creates a new PROJEKT_INSTRUMENT or raises the existing
%      singleton*.
%
%      H = PROJEKT_INSTRUMENT returns the handle to a new PROJEKT_INSTRUMENT or the handle to
%      the existing singleton*.
%
%      PROJEKT_INSTRUMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJEKT_INSTRUMENT.M with the given input arguments.
%
%      PROJEKT_INSTRUMENT('Property','Value',...) creates a new PROJEKT_INSTRUMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before projekt_instrument_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to projekt_instrument_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help projekt_instrument

% Last Modified by GUIDE v2.5 08-Jan-2014 09:25:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @projekt_instrument_OpeningFcn, ...
                   'gui_OutputFcn',  @projekt_instrument_OutputFcn, ...
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


% --- Executes just before projekt_instrument is made visible.
function projekt_instrument_OpeningFcn(hObject, eventdata, handles, varargin)
clc;
handles.output = hObject;
nazwy = ['ABC','DEF','GHI'];
set(handles.listbox1,'string',nazwy);
guidata(hObject, handles);
global scale;
global a;
a = 440;
scale = [3,4,5,6,7,8,9,10,11,12,13,14,15];
global organ;
global flute;
organ = [0.85 0.75 0.1 0.2 .2 .1 .1 1 .1 .25 .5 1];
flute = [1 1 1 0.5 0.5];
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to projekt_instrument (see VARARGIN)

% Choose default command line output for projekt_instrument
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes projekt_instrument wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = projekt_instrument_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function synthesize(f,d,p)
% Matlab function synthesize(file,f,d,p) 
% creates a .wav audio file of a sound where the fundamental frequency 
% and amplitudes(power) of the harmonics may be specified.
%
% file is a string which is the name of the .wav file.
% f is the fundamental frequency in Hz
% d is the duration in seconds
% p is a length n vector of amplitudes
%
% For example, synthesize('test.wav', 220, 3, [1 .8 .1 .04])
% makes a 3 second sample at 220 Hz with the harmonics shown.
%
% Mark R. Petersen, U. of Colorado Boulder Applied Math Dept, Feb 2004

Fs=48000; nbits=8;              % frequency and bit rate of wav file

t = linspace(1/Fs, d, d*Fs);    % time
y = zeros(1,Fs*d);              % initialize sound data
for n=1:length(p);
  y = y + p(n)*cos(2*pi*n*f*t); % sythesize waveform
end
y = .5*y/max(y);                % normalize.  Coefficent controls volume.
% wavwrite( y, Fs, nbits, file)
sound(y,Fs);
axesHandle= findobj(gcf,'Tag','axes1');
% x=rand(randi(10+20,1),4);
x = spectrogram(y,512,2);
T = 0:0.001:2;
X = chirp(T,100,1,200,'q');
title('Quadratic Chirp');
%Example Input with verification
plot(axesHandle, y);
set(axesHandle,'Tag','axes1');
axis ([0 200 0 1]); 


function playSound(scalestep)

% Fs = 48000;      %# Samples per second
% % handles.edit1
global a;
global organ;
global flute;
tone = a/2 * (2^(1/12))^scalestep;
% % toneFreq = handles.edit1;
% % toneFreq = 440; %#handles.edit1;  %# Tone frequency, in Hertz
% nSeconds = 2;   %# Duration of the sound
% y = sin(linspace(0, nSeconds*tone*2*pi, round(nSeconds*Fs)));
% % When played at 1 kHz using the SOUND function, this vector will generate a 50 Hz tone for 2 seconds:
% 
% sound(y, Fs);  %# Play sound at sampling rate Fs
synthesize(tone, 0.5, organ);

% --- Executes on button press in cKey.
function cKey_Callback(hObject, eventdata, handles)
global a;
global scale;
a
playSound(scale(1));
% hObject    handle to cKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in dKey.
function dKey_Callback(hObject, eventdata, handles)
global a
a
global scale;
playSound(scale(3));
% hObject    handle to dKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in eKey.
function eKey_Callback(hObject, eventdata, handles)
global a
a
global scale;
playSound(scale(5));
% hObject    handle to eKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in fKey.
function fKey_Callback(hObject, eventdata, handles)
global a
a
global scale;
playSound(scale(6));
% hObject    handle to fKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in gKey.
function gKey_Callback(hObject, eventdata, handles)
global scale;
playSound(scale(8));
% hObject    handle to gKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in aKey.
function aKey_Callback(hObject, eventdata, handles)
global scale;
playSound(scale(10));
% hObject    handle to aKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in hKey.
function hKey_Callback(hObject, eventdata, handles)
global scale;
playSound(scale(12));
% hObject    handle to hKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cSharpButton.
function cSharpButton_Callback(hObject, eventdata, handles)
global scale;
playSound(scale(2));
% hObject    handle to cSharpButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in dSharpButton.
function dSharpButton_Callback(hObject, eventdata, handles)
global scale;
playSound(scale(4));
% hObject    handle to dSharpButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in fSharpButton.
function fSharpButton_Callback(hObject, eventdata, handles)
global scale;
playSound(scale(7));
% hObject    handle to fSharpButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in gSharpButton.
function gSharpButton_Callback(hObject, eventdata, handles)
global scale;
playSound(scale(9));
% hObject    handle to gSharpButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bButton.
function bButton_Callback(hObject, eventdata, handles)
global scale;
playSound(scale(11));
% hObject    handle to bButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on cKey and none of its controls.
function cKey_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to cKey (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
eventdata % Let's see the KeyPress event data
disp(eventdata.Key) % Let's display the key, for fun!


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
global scale;
global a;
switch eventdata.Key 
case 'a' 
    playSound(scale(1));
case 'w'
    playSound(scale(2));
case 's'
    playSound(scale(3));
case 'e'
    playSound(scale(4));
case 'd'
    playSound(scale(5));
case 'f'
    playSound(scale(6));
case 't'
    playSound(scale(7));
case 'g'
    playSound(scale(8));
case 'y'
    playSound(scale(9));
case 'h'
    playSound(scale(10));
case 'u'
    playSound(scale(11));
case 'j'
    playSound(scale(12));
case 'k'
    playSound(scale(13));
case 'z'
    a = a/2;
case 'x'
    a = a*2;

end


% --- Executes on button press in octaveDownButton.
function octaveDownButton_Callback(hObject, eventdata, handles)
% hObject    handle to octaveDownButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
a = a/2;


% --- Executes on button press in octaveUpKey.
function octaveUpKey_Callback(hObject, eventdata, handles)
% hObject    handle to octaveUpKey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;
a = a*2;
