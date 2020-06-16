unit CoronApp.Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls;

type
  TFrmLogin = class(TForm)
    Panel1: TPanel;
    EdtEmail: TEdit;
    EdtSenha: TEdit;
    BtnLogin: TSpeedButton;
    BtnRegistro: TSpeedButton;
    procedure BtnRegistroClick(Sender: TObject);
    procedure BtnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

uses CoronApp.Registro, CoronApp.Dados, CoronApp.Principal;
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPad.fmx IOS}

procedure TFrmLogin.BtnLoginClick(Sender: TObject);
begin
  if Not Assigned(FrmPrincipal) then
    FrmPrincipal := TFrmPrincipal.Create(nil);
  FrmPrincipal.show;
  Application.MainForm := FrmPrincipal;
  Self.Close;
end;

procedure TFrmLogin.BtnRegistroClick(Sender: TObject);
begin
  if not Assigned(FrmRegistro) then
    FrmRegistro := TFrmRegistro.Create(nil);
  FrmRegistro.show;
end;

end.
