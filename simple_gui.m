function sortie = simple_gui(varargin)
    
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @simple_gui_OpeningFcn, ...
                       'gui_OutputFcn',  @simple_gui_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [sortie{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
function simple_gui_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;

    guidata(hObject, handles);
    datas = struct();
    datas.nodes = ones(2, 3);
    datas.resolution = 1000;
    
    datas.mode         = handles.bg_editor.SelectedObject.String;
    datas.tangent_mode = handles.bg_tangents.SelectedObject.String;
    datas.tension      = get(handles.slider_tension, 'Value');
    
    
    datas.style_c1       = 'r';
    datas.style_c2       = 'b';
    datas.style_aitken   = 'g';
    datas.ctrl_symb      = '+';
    
    datas.draw_c1       = get(handles.cb_c1, 'Value');
    datas.draw_c2       = get(handles.cb_c2, 'Value');
    datas.draw_aitken   = get(handles.cb_aitken, 'Value');
    datas.draw_control  = get(handles.cb_control, 'Value');
    datas.draw_nodes    = get(handles.cb_nodes, 'Value');
    
    set(handles.cb_c1,       'ForegroundColor', datas.style_c1);
    set(handles.cb_c2,       'ForegroundColor', datas.style_c2);
    set(handles.cb_aitken,   'ForegroundColor', datas.style_aitken);
    
    handles.datas = datas;
    guidata(hObject, handles);

        
function on_update_datas(hObject, handles)
    guidata(hObject, handles);
    dessin(handles.datas, handles.axes_main, handles.axes_curvature);
    
% --- Outputs from this function are returned to the command line.
function sortie = simple_gui_OutputFcn(hObject, eventdata, handles) 
    sortie{1} = handles.output;
    dessin(handles.datas, handles.axes_main, handles.axes_curvature)

function bouton_c1(bouton, etape, parametre)
    parametre.datas.draw_c1 = get(bouton, 'Value');
    on_update_datas(bouton, parametre);

function bouton_c2(bouton, etape, parametres)
    parametres.datas.draw_c2 = get(bouton, 'Value');
    on_update_datas(bouton, parametres);

function bouton_neville(bouton, etape, parametre)
    parametre.datas.draw_aitken = get(bouton, 'Value');
    on_update_datas(bouton, parametre);

function dessin_noeuds(bouton, etape, parametre)
    parametre.datas.draw_nodes = get(bouton, 'Value');
    on_update_datas(bouton, parametre);

function sortir(bouton, etape, parametres)
    close

function modifier_c(curseur, etape, parametres)
    parametres.datas.tension = get(curseur, 'Value');
    on_update_datas(curseur, parametres);
    
function rein(bouton, etape, parametre)
    parametre.datas.nodes = [];
    on_update_datas(bouton, parametre);

function clik(bouton, etape, parametres)
    abcisse = etape.IntersectionPoint(1);
    ordonnee = etape.IntersectionPoint(2);
    m = etat_points(parametres.datas.nodes, parametres.datas.mode, abcisse, ordonnee);
    parametres.datas.nodes = m;
    on_update_datas(bouton, parametres);
    
function creer_c(curseur, etape, parametres)
       set(curseur,[.4 .5 .7]);
  
