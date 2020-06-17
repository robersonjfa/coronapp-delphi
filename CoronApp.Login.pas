unit CoronApp.Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls,
  FMX.DialogService;

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
{$R *.LgXhdpiPh.fmx ANDROID}

uses CoronApp.Registro, CoronApp.Dados, CoronApp.Principal;

procedure TFrmLogin.BtnLoginClick(Sender: TObject);
begin
  with DtmDados do
  begin
    FDLoginQuery.Close;
    FDLoginQuery.ParamByName('email').AsString := EdtEmail.Text;
    FDLoginQuery.ParamByName('senha').AsString := EdtSenha.Text;
    FDLoginQuery.Open();
    if (FDLoginQuery.RecordCount > 0) then
    begin
      if Not Assigned(FrmPrincipal) then
        FrmPrincipal := TFrmPrincipal.Create(nil);
      FrmPrincipal.show;
      Application.MainForm := FrmPrincipal;
      Self.Close;
    end
    else
    begin
      TDialogService.MessageDialog('Usuário e/ou senha inválidos!',
        TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0, nil);
      EdtEmail.Text := '';
      EdtSenha.Text := '';
      EdtEmail.SetFocus;
    end;
  end;

end;

procedure TFrmLogin.BtnRegistroClick(Sender: TObject);
begin
  if not Assigned(FrmRegistro) then
    FrmRegistro := TFrmRegistro.Create(nil);
  FrmRegistro.show;
end;

end.
