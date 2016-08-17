function varargout = Asama1(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Asama1_OpeningFcn, ...
                   'gui_OutputFcn',  @Asama1_OutputFcn, ...
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


% --- Executes just before Asama1 is made visible.
function Asama1_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for Asama1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Asama1_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function img_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in select.
function select_Callback(hObject, eventdata, handles)
global im imGray
axes(handles.img1);
[filename,pathname] = uigetfile('*.bmp; *.jpg; *.png', 'Please select an image file');     
im=fullfile (pathname,filename); 
im=imread(im);
[rows, columns, numberOfColorChannels] = size(im);
if numberOfColorChannels > 1
    imGray     = rgb2gray(im); 
else imGray = im;
end
axes(handles.img1);
imshow(im);

% --- Executes during object creation, after setting all properties.
function medianfilter_Callback(hObject, eventdata, handles)
global imGray current
med = medfilt2(imGray);
current = med;
axes(handles.img2);
imshow(med);

% --- Executes on button press in select.
function pushbutton66_Callback(hObject, eventdata, handles)
% hObject    handle to select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in match.
function match_Callback(hObject, eventdata, handles)
global imGray 
% axes(handles.img1);
[filename,pathname] = uigetfile('*.bmp; *.jpg; *.png', 'Histogram Eþleþtirme için hedef görüntü seçin');     
match=fullfile (pathname,filename); 
match=imread(match);
[rows, columns, numberOfColorChannels] = size(match);
if numberOfColorChannels > 1
    G_match     = rgb2gray(match); 
else G_match = match;
end
match = HistogramMatch(G_match,imGray);
axes(handles.img2);
imshow(match);


% --- Executes on button press in equazilation.
function equazilation_Callback(hObject, eventdata, handles)
global imGray 
hist = HistogramEqualization(imGray);
axes(handles.img2);
imshow(hist);


% --- Executes on button press in contour.
function contour_Callback(hObject, eventdata, handles)
global imGray 
axes(handles.img2);
imcontour(imGray,2);
current = imcrop(imGray,[1:size(imGray,1) 1:size(imGray,2)]);
figure;imshow(current);


% --- Executes on button press in adapt.
function adapt_Callback(hObject, eventdata, handles)
global imGray  
adapt = adapthisteq(imGray);
axes(handles.img2);
imshow(adapt);

% --- Executes on button press in wthe.
function wthe_Callback(hObject, eventdata, handles)
global imGray
wthe = WTHE(imGray,0.3,0.5);
axes(handles.img2);
imshow(wthe,[]);


% --- Executes on button press in binary.
function binary_Callback(hObject, eventdata, handles)
global imGray 
bin = imbinarize(imGray);
axes(handles.img2);
imshow(bin);


% --- Executes on button press in gray.
function gray_Callback(hObject, eventdata, handles)
global imGray
axes(handles.img2);
imshow(imGray);


% --- Executes on button press in maxContour.
function maxContour_Callback(hObject, eventdata, handles)
global imGray
contourMat = imcontour(imGray,2);
axes(handles.img2);
maxContourLine(contourMat);


% --- Executes during object deletion, before destroying properties.
function select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



