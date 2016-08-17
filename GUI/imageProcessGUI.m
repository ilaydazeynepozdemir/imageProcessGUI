function varargout = imageProcessGUI(varargin)
% global im imGray currentImages
% % im = [];
% % imGray = [];
% % currentImages = [];

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imageProcessGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @imageProcessGUI_OutputFcn, ...
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

function imageProcessGUI_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = imageProcessGUI_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on button press in select.
function select_Callback(hObject, eventdata, handles)
global im imGray currentImages pathname filename histON_OFF 
histON_OFF = false;
im = [];
imGray = [];
currentImages = [];
axes(handles.img2);
imshow(imGray,[]);
axes(handles.img);
[filename,pathname] = uigetfile('*.bmp; *.jpg; *.png', 'G�r�nt�n�z� se�in');     
im=fullfile (pathname,filename); 
im=imread(im);
[rows, columns, numberOfColorChannels] = size(im);
if numberOfColorChannels > 1
    imGray     = rgb2gray(im); 
else imGray = im;
end
axes(handles.img);
imshow(im,[]);




% --- Executes on button press in matching.
function matching_Callback(hObject, eventdata, handles)
global imGray currentImages histON_OFF
axes(handles.img);
[filename,pathname] = uigetfile('*.bmp; *.jpg; *.png', 'Histogram E�le�tirme i�in hedef g�r�nt� se�in');     
match=fullfile (pathname,filename); 
match=imread(match);
[rows, columns, numberOfColorChannels] = size(match);
if numberOfColorChannels > 1
    G_match     = rgb2gray(match); 
else G_match = match;
end
match = HistogramMatch(G_match,imGray);
currentImages(1).im = match;
if histON_OFF == true
    histogram_Callback(hObject, eventdata, handles);
end
axes(handles.img2);
imshow(currentImages(1).im,[]);


% --- Executes on button press in equalization.
function equalization_Callback(hObject, eventdata, handles)
global imGray currentImages histON_OFF
hist = HistogramEqualization(imGray);
currentImages(1).im = hist;
if histON_OFF == true
    histogram_Callback(hObject, eventdata, handles);
end
axes(handles.img2);
imshow(hist,[]);



% --- Executes on button press in median.
function median_Callback(hObject, eventdata, handles)
global imGray currentImages histON_OFF
med = medfilt2(imGray);
currentImages(1).im = med;
if histON_OFF == true
    histogram_Callback(hObject, eventdata, handles);
end
axes(handles.img2);
imshow(med,[]);



% --- Executes on button press in gray.
function gray_Callback(hObject, eventdata, handles)
global imGray currentImages histON_OFF
currentImages(1).im = imGray;
if histON_OFF == true
    histogram_Callback(hObject, eventdata, handles);
end
axes(handles.img2);
imshow(imGray,[]);


% --- Executes on button press in binary.
function binary_Callback(hObject, eventdata, handles)
global imGray currentImages histON_OFF
bin = imbinarize(imGray);
currentImages(1).im = bin;
if histON_OFF == true
    histogram_Callback(hObject, eventdata, handles);
end
axes(handles.img2);
imshow(bin,[]);


% --- Executes on button press in adapthist.
function adapthist_Callback(hObject, eventdata, handles)
global imGray currentImages histON_OFF
adapt = adapthisteq(imGray);
currentImages(1).im = adapt;
if histON_OFF == true
    histogram_Callback(hObject, eventdata, handles);
end
axes(handles.img2);
imshow(adapt,[]);


% --- Executes on button press in WTHE.
function WTHE_Callback(hObject, eventdata, handles)
global imGray histON_OFF currentImages
wthe = WTHE(imGray,0.3,0.5);
currentImages(1).im = wthe;
if histON_OFF == true
    histogram_Callback(hObject, eventdata, handles);
end
axes(handles.img2);
imshow(wthe,[]);




% --- Executes on button press in hist.
function histogram_Callback(hObject, eventdata, handles)
global im currentImages histON_OFF
% histON_OFF = true;
if histON_OFF == true
    axes(handles.hist);
    histogram(im);
    %exceptionlari onlemek icin
    if isstruct(currentImages)
        axes(handles.hist2);
        histogram(currentImages(1).im);
    else currentImages ~= []
        axes(handles.hist2);
        histogram(currentImages(1).im);
    end
else 
    axes(handles.hist);
    histogram([]);
    axes(handles.hist2);
    histogram([]);
end



% --- Executes during object creation, after setting all properties.
function hist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate hist


% --- Executes during object creation, after setting all properties.
function hist2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hist2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate hist2


% --- Executes on button press in cut.
function cut_Callback(hObject, eventdata, handles)
global currentImages;
Crop = imcrop();
imshow(Crop, 'Parent', handles.img2);
guidata(hObject, handles);
axis(handles.img2, 'image');
    
[name, path, secilen_filtre_no] = uiputfile( ...
{'*.jpg;*.bmp;*.png;*.fig'},'G�r�nt� Kaydetme Penceresi');
file = strcat(path,name);
imwrite(Crop,file);
currentImages.im = Crop;


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
global currentImages filename pathname imGray
file = strcat(pathname,filename);

if numel(currentImages) == 1
    imwrite(currentImages(1).im,file);
    imGray = currentImages(1).im;
    axes(handles.img);
    imshow(currentImages(1).im,[]);
else
    temp = findstr(file,'.jpg');
    type = file(temp : size(file,2));
    file = file(1:temp-1);
    for i=1:numel(currentImages)
        files = strcat(file,int2str(i));
        files = strcat(files,type);
        imwrite(currentImages(i).im,files);
    end
end

% --- Executes on button press in diffSave.
function diffSave_Callback(hObject, eventdata, handles)
global currentImages;
[name, path, secilen_filtre_no] = uiputfile( ...
{'*.jpg;*.bmp;*.png;*.fig'},'G�r�nt� Farkl� Kaydetme Penceresi');
file = strcat(path,name);
if numel(currentImages) == 1
    imwrite(currentImages(1).im,file);
else
    temp = findstr(file,'.jpg');
    type = file(temp : size(file,2));
    file = file(1:temp-1);
    for i=1:numel(currentImages)
        files = strcat(file,int2str(i));
        files = strcat(files,type);
        imwrite(currentImages(i).im,files);
    end
end



% --- Executes on button press in findObj.
function findObj_Callback(hObject, eventdata, handles)
global im currentImages 
axes(handles.img2);
pos = findObjects(im,'binary');
for i=1:size(pos,1)
    kes = [pos(i,1) pos(i,2) pos(i,3) pos(i,4)];
    currentImages(i).im = imcrop(im,kes);
%     figure;imshow();
end


% --- Executes on button press in contour.
function contour_Callback(hObject, eventdata, handles)
global imGray currentImages
axes(handles.img2);
imcontour(imGray,2);
currentImages(1).im = imcrop(imGray,[1:size(imGray,1) 1:size(imGray,2)]);
figure;imshow(currentImages(1).im,[]);
% burayi duzelt

% --- Executes on button press in maxContour.
function maxContour_Callback(hObject, eventdata, handles)
global imGray
contourMat = imcontour(imGray,2);
axes(handles.img2);
maxContourLine(contourMat);


% --- Executes on button press in histg.
function histg_Callback(hObject, eventdata, handles)
global histON_OFF
if histON_OFF == true
    histON_OFF = false;
else histON_OFF = true;
end
