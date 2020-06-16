program CoronApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  CoronApp.Principal in 'CoronApp.Principal.pas' {FrmPrincipal},
  CoronApp.Registro in 'CoronApp.Registro.pas' {FrmRegistro},
  CoronApp.Dados in 'CoronApp.Dados.pas' {DtmDados: TDataModule},
  CoronApp.Login in 'CoronApp.Login.pas' {FrmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDtmDados, DtmDados);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;
end.
