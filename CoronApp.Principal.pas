unit CoronApp.Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.Generics.Collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.StdCtrls, FMX.Controls.Presentation, FMX.MultiView,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.TabControl, REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  REST.Response.Adapter, REST.Client, Data.Bind.ObjectScope, FMX.Gestures,
  FMX.DialogService;

type
  TFrmPrincipal = class(TForm)
    MultiView1: TMultiView;
    Panel1: TPanel;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem2: TListBoxItem;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    LsvNoticia: TListView;
    LsbSintomas: TListBox;
    ListBoxHeader1: TListBoxHeader;
    Label2: TLabel;
    Label3: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    GestureManager1: TGestureManager;
    procedure ListBoxItem2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LsbSintomasGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure LsvNoticiaItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;
  Sintomas: TDictionary<String, integer>;

implementation

{$R *.fmx}

uses CoronApp.Registro, CoronApp.Detalhe;
{$R *.LgXhdpiPh.fmx ANDROID}

procedure TFrmPrincipal.FormCreate(Sender: TObject);
var
  sintoma: String;
begin
  // criando o meu dicionário de sintomas
  Sintomas := TDictionary<String, integer>.Create;
  Sintomas.Add('Vômito', 5);
  Sintomas.Add('Diarréia', 5);
  Sintomas.Add('Febre', 15);
  Sintomas.Add('Dor no Corpo', 15);
  Sintomas.Add('Dor de Cabeça', 15);
  Sintomas.Add('Cansaço', 15);
  Sintomas.Add('Falta de Ar', 30);
  for sintoma in Sintomas.Keys do
    LsbSintomas.Items.Add(sintoma);
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  RESTClient1.Params.ParameterByName('from').Value := '2020-06-16';
  RESTClient1.Params.ParameterByName('to').Value := '2020-06-16';
  RESTRequest1.Execute;
end;

procedure TFrmPrincipal.ListBoxItem2Click(Sender: TObject);
begin
  if not Assigned(FrmRegistro) then
    FrmRegistro := TFrmRegistro.Create(self); // crie o form
  FrmRegistro.Show;
end;

procedure TFrmPrincipal.LsbSintomasGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
  I, Percentual, Total: integer;
begin
  if (EventInfo.GestureID = sgiChevronUp) then
    LsbSintomas.ClearSelection; // limpa a seleção

  if (EventInfo.GestureID = sgiCheck) then
  begin
    Total := 0;
    for I := 0 to LsbSintomas.Items.Count - 1 do
    begin
      if (LsbSintomas.ListItems[I].IsSelected and
        Sintomas.TryGetValue(LsbSintomas.ListItems[I].Text, Percentual)) then
        Total := Total + Percentual;
    end;
    TDialogService.MessageDialog('Você tem ' + IntToStr(Total) +
      '% de chance de ter coronavírus!', TMsgDlgType.mtInformation,
      [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0, nil);
  end;

end;

procedure TFrmPrincipal.LsvNoticiaItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  if (not Assigned(FrmDetalhe)) then
    FrmDetalhe := TFrmDetalhe.Create(nil);
  FrmDetalhe.Show;
end;

end.
