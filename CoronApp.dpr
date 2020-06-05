program CoronApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  CoronApp.Principal in 'CoronApp.Principal.pas' {FrmPrincipal},
  CoronApp.Registro in 'CoronApp.Registro.pas' {FrmRegistro},
  CoronApp.Dados in 'CoronApp.Dados.pas' {DtmDados: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDtmDados, DtmDados);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
