unit CoronApp.Registro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Objects, FMX.Controls.Presentation, System.Actions,
  FMX.ActnList, FMX.StdActns, System.Permissions, FMX.MediaLibrary.Actions,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.Layouts,
  FMX.ListBox;

type
  TFrmRegistro = class(TForm)
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Panel1: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    ImgFoto: TImage;
    EdtNome: TEdit;
    EdtEmail: TEdit;
    EdtSenha: TEdit;
    BtnSalvar: TButton;
    ActionList1: TActionList;
    WindowClose1: TWindowClose;
    TakeFotoFromCameraAction: TTakePhotoFromCameraAction;
    TakeFotoFromLibraryAction: TTakePhotoFromLibraryAction;
    ListBox1: TListBox;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure TakeFotoFromCameraActionDidFinishTaking(Image: TBitmap);
    procedure TakeFotoFromLibraryActionDidFinishTaking(Image: TBitmap);
    procedure BtnSalvarClick(Sender: TObject);
  private
    { Private declarations }
{$IFDEF ANDROID}
    PermissaoCamera, PermissaoReadStorage, PermissaoWriteStorage: string;
    procedure TakePicturePermissionRequestResult(Sender: TObject;
      const APermissions: TArray<string>;
      const AGrantResults: TArray<TPermissionStatus>);
    procedure DisplayMessageCamera(Sender: TObject;
      const APermissions: TArray<string>; const APostProc: TProc);
    procedure LibraryPermissionRequestResult(Sender: TObject;
      const APermissions: TArray<string>;
      const AGrantResults: TArray<TPermissionStatus>);
    procedure DisplayMessageLibrary(Sender: TObject;
      const APermissions: TArray<string>; const APostProc: TProc);
{$ENDIF}
  public
    { Public declarations }
  end;

var
  FrmRegistro: TFrmRegistro;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

uses
  FMX.DialogService
{$IFDEF ANDROID}
    , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os,
  CoronApp.Dados;
{$ENDIF}
{$IFDEF ANDROID}

procedure TFrmRegistro.TakeFotoFromCameraActionDidFinishTaking(Image: TBitmap);
begin
  ImgFoto.Bitmap.Assign(Image);
end;

procedure TFrmRegistro.TakeFotoFromLibraryActionDidFinishTaking(Image: TBitmap);
begin
  ImgFoto.Bitmap.Assign(Image);
end;

procedure TFrmRegistro.TakePicturePermissionRequestResult(Sender: TObject;
  const APermissions: TArray<string>;
  const AGrantResults: TArray<TPermissionStatus>);
begin
  // 3 Permissoes: CAMERA, READ_EXTERNAL_STORAGE e WRITE_EXTERNAL_STORAGE
  if (Length(AGrantResults) = 3) and
    (AGrantResults[0] = TPermissionStatus.Granted) and
    (AGrantResults[1] = TPermissionStatus.Granted) and
    (AGrantResults[2] = TPermissionStatus.Granted) then
    TakeFotoFromCameraAction.Execute
  else
    TDialogService.ShowMessage('Você não tem permissão para tirar fotos');
end;

procedure TFrmRegistro.LibraryPermissionRequestResult(Sender: TObject;
  const APermissions: TArray<string>;
  const AGrantResults: TArray<TPermissionStatus>);
begin
  // 2 Permissoes: READ_EXTERNAL_STORAGE e WRITE_EXTERNAL_STORAGE

  if (Length(AGrantResults) = 2) and
    (AGrantResults[0] = TPermissionStatus.Granted) and
    (AGrantResults[1] = TPermissionStatus.Granted) then
    TakeFotoFromLibraryAction.Execute
  else
    TDialogService.ShowMessage('Você não tem permissão para acessar as fotos');
end;

procedure TFrmRegistro.SpeedButton2Click(Sender: TObject);
begin
{$IFDEF ANDROID}
  PermissionsService.RequestPermissions([PermissaoCamera, PermissaoReadStorage,
    PermissaoWriteStorage], TakePicturePermissionRequestResult,
    DisplayMessageCamera);
{$ENDIF}
{$IFDEF IOS}
  ActPhotoFromCamera.Execute;
{$ENDIF}
end;

procedure TFrmRegistro.SpeedButton3Click(Sender: TObject);
begin
{$IFDEF ANDROID}
  PermissionsService.RequestPermissions([PermissaoReadStorage,
    PermissaoWriteStorage], LibraryPermissionRequestResult,
    DisplayMessageLibrary);
{$ENDIF}
{$IFDEF IOS}
  ActPhotoFromLibrary.Execute;
{$ENDIF}
end;

procedure TFrmRegistro.BtnSalvarClick(Sender: TObject);
begin
  with DtmDados do
  begin
    FDRegistroInsert.ParamByName('nome').AsString := EdtNome.Text;
    FDRegistroInsert.ParamByName('email').AsString := EdtEmail.Text;
    FDRegistroInsert.ParamByName('senha').AsString := EdtSenha.Text;
    // executar o insert
    FDRegistroInsert.ExecSQL;
    FDRegistroQuery.Close;
    FDRegistroQuery.Open();
  end;
end;

procedure TFrmRegistro.DisplayMessageCamera(Sender: TObject;
  const APermissions: TArray<string>; const APostProc: TProc);
begin
  TDialogService.ShowMessage
    ('O app precisa acessar a câmera e as fotos do seu dispositivo',
    procedure(const AResult: TModalResult)
    begin
      APostProc;
    end);
end;

procedure TFrmRegistro.DisplayMessageLibrary(Sender: TObject;
const APermissions: TArray<string>; const APostProc: TProc);
begin
  TDialogService.ShowMessage
    ('O app precisa acessar as fotos do seu dispositivo',
    procedure(const AResult: TModalResult)
    begin
      APostProc;
    end);
end;

procedure TFrmRegistro.FormActivate(Sender: TObject);
begin
{$IFDEF ANDROID}
  PermissaoCamera := JStringToString(TJManifest_permission.JavaClass.CAMERA);
  PermissaoReadStorage := JStringToString
    (TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
  PermissaoWriteStorage := JStringToString
    (TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
{$ENDIF}
end;

{$ENDIF}

end.
