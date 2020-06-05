unit CoronApp.Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.StdCtrls, FMX.Controls.Presentation, FMX.MultiView,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.TabControl;

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
    procedure ListBoxItem2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses CoronApp.Registro;
{$R *.LgXhdpiPh.fmx ANDROID}

procedure TFrmPrincipal.ListBoxItem2Click(Sender: TObject);
begin
  if not Assigned(FrmRegistro) then
    FrmRegistro := TFrmRegistro.Create(self); // crie o form
  FrmRegistro.Show;
end;

end.
