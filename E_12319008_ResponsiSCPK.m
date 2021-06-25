function varargout = E_12319008_ResponsiSCPK(varargin)
% E_12319008_RESPONSISCPK MATLAB code for E_12319008_ResponsiSCPK.fig
%      E_12319008_RESPONSISCPK, by itself, creates a new E_12319008_RESPONSISCPK or raises the existing
%      singleton*.
%
%      H = E_12319008_RESPONSISCPK returns the handle to a new E_12319008_RESPONSISCPK or the handle to
%      the existing singleton*.
%
%      E_12319008_RESPONSISCPK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in E_12319008_RESPONSISCPK.M with the given input arguments.
%
%      E_12319008_RESPONSISCPK('Property','Value',...) creates a new E_12319008_RESPONSISCPK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before E_12319008_ResponsiSCPK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to E_12319008_ResponsiSCPK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help E_12319008_ResponsiSCPK

% Last Modified by GUIDE v2.5 25-Jun-2021 18:11:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @E_12319008_ResponsiSCPK_OpeningFcn, ...
                   'gui_OutputFcn',  @E_12319008_ResponsiSCPK_OutputFcn, ...
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


% --- Executes just before E_12319008_ResponsiSCPK is made visible.
function E_12319008_ResponsiSCPK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to E_12319008_ResponsiSCPK (see VARARGIN)

% Choose default command line output for E_12319008_ResponsiSCPK
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes E_12319008_ResponsiSCPK wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = E_12319008_ResponsiSCPK_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in showdata.
function showdata_Callback(hObject, eventdata, handles)
% hObject    handle to showdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATA RUMAH.xlsx');  %Mengambil nilai option import data dari file xlsx
opts.SelectedVariableNames = ([1,3:8]);         %Mengambil nilai kolom 1 dan kolom 3 hingga 8
lihattabel = readtable('DATA RUMAH.xlsx',opts); %Membaca file xlsx sebagai tabel dengan opts sebagai import optionnya dan menyimpan di variabel lihattabel
showtabel = table2cell(lihattabel);             %Mengubah lihattabel yang awalnya tabel menjadi cell

set(handles.uitable1,'Data',showtabel);         %Set nilai showtabel ke uitable1


% --- Executes on button press in hasilsaw.
function hasilsaw_Callback(hObject, eventdata, handles)
% hObject    handle to hasilsaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

opts1 = detectImportOptions('DATA RUMAH.xlsx'); %Mengambil nilai option import data dari file xlsx
opts1.SelectedVariableNames = (3:8);            %Mengambil nilai kolom 3 hingga 8 untuk perhitungan
data = readtable('DATA RUMAH.xlsx',opts1);      %Membaca file xlsx sebagai tabel dengan opts sebagai import optionnya dan menyimpan di variabel data
x = table2array(data);                          %Mengubah data yang awalnya table menjadi array dan simpan
                                                %ke variabel x

opts2 = detectImportOptions('DATA RUMAH.xlsx'); %Mengambil nilai option import data dari file xlsx
opts2.SelectedVariableNames = (1:8);            %Mengambil nilai kolom 1 hingga hingga 8
data2 = readtable('DATA RUMAH.xlsx',opts2);     %Membaca file xlsx sebagai tabel dengan opts sebagai import optionnya 
                                                %dan menyimpan di variabel data2
data2 = table2cell(data2);                      %Mengubah data yang awalnya table menjadi cell

k = [0 1 1 1 1 1];  % Atribut tiap-tiap kriteria, dimana nilai 1=atrribut keuntungan, dan  0= atribut biaya
                    % Harga merupakan cost karena semakin murah semakin untung si pemilik
                    % Luas Bangunan merupakan benefit, semakin luas semakin menguntungkan pak bambang
                    % Luas Tanah merupakan benefit, semakin luas semakin menguntungkan pak bambang
                    % Kamar Tidur merupakan benefit, semakin banyak semakin menguntungkan pak bambang
                    % Kamar Mandi merupakan benefit, semakin banyak semakin menguntungkan pak bambang
                    % Jumlah Garasi merupakan benefit, semakin banyak semakin menguntungkan pak bambang
                    
w = [0.3 0.2 0.23 0.1 0.07 0.1]; %Bobot sesuai dengan keinginan pak Bambang

%tahapan 1, Normalisasi matriks
[m,n]=size(x);  %inisialisasi ukuran x
R = zeros(m,n); %membuat matriks R yang merupakan matriks kosong
for j=1:n
    if k(j)==1  %Untuk Kriteria dengan atribut keuntungan
        R(:,j)=x(:,j)./max(x(:,j));
    else        %Untuk Kriteria dengan atribut cost
        R(:,j)=min(x(:,j))./x(:,j);
    end
end

%tahapan 2, proses perangkingan
for i=1:m
    V(i)=sum(w.*R(i,:));
end

V = V.';
V = num2cell(V);
hasil = {data2; V};
hasil = horzcat(hasil{:});

hasilsort = sortrows(hasil,9,'descend');        %Mengurutkan Berdasarkan kolom skor,simpan ke hasilsort
ranked = hasilsort(1:20,:);                     %Menampilkan 20 urutan teratas, simpan ke ranked

set(handles.uitable2,'Data',ranked);            %menampilkan data pada ranked ke uitable2


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
