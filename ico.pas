unit ico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzTabs, ExtCtrls, XP_Form, WinXP, XiButton, RzShellDialogs,
  ExtDlgs, StdCtrls, RzLstBox,inifiles, RzBHints, Mask, RzEdit, RzCmboBx,ShellAPI,
  glLabel,ShlObj, glBevel;

type
  TForm1 = class(TForm)
    tfXPForm1: TtfXPForm;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    WinXP1: TWinXP;
    ImageIcon: TImage;
    XiButton1: TXiButton;
    RzOpenDialog1: TRzOpenDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    XiButton2: TXiButton;
    RzRankListBox1: TRzRankListBox;
    XiButton3: TXiButton;
    RzBalloonHints1: TRzBalloonHints;
    RzMemo1: TRzMemo;
    XiButton4: TXiButton;
    XiButton6: TXiButton;
    OpenPictureDialog2: TOpenPictureDialog;
    RzComboBox1: TRzComboBox;
    RzComboBox2: TRzComboBox;
    glLabel1: TglLabel;
    glLabel2: TglLabel;
    Image2: TImage;
    glLabel3: TglLabel;
    Timer1: TTimer;
    TabSheet3: TRzTabSheet;
    XiButton5: TXiButton;
    SaveDialogIcon: TSaveDialog;
    Edit1: TEdit;
    glBevel1: TglBevel;
    glLabel4: TglLabel;
    procedure XiButton1Click(Sender: TObject);
    procedure XiButton2Click(Sender: TObject);
    procedure XiButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzRankListBox1DblClick(Sender: TObject);
    procedure RzComboBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure XiButton4Click(Sender: TObject);
    procedure XiButton6Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure glLabel3Click(Sender: TObject);
    procedure XiButton5Click(Sender: TObject);
    procedure LoadIconFromFile;
    procedure FormActivate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  st,st1,st2,pp,pp1:String;
  ini:TIniFile;
  sm:Integer;
//  str:TextFile;
   FormExtractIcon: TForm;
   _WD:String;
    wd: array [0..max_path] of char;
implementation

//uses ComObj, RTLConsts, SysConst, ComConst,MessDlgs;

{$R *.dfm}

var
  Bitmap   : TBitmap;
  IconSave : TIcon;
  FullDir  : String;
  IconIndex: Word;


procedure TForm1.LoadIconFromFile;
var
  Pch: array[0..256] of Char;
  IconExtr: HIcon;
begin
  IconIndex :=StrToInt(Edit1.Text);
  FullDir := OpenPictureDialog1.FileName;
  StrPCopy(Pch,FullDir);
  IconExtr := ExtractAssociatedIcon(HInstance,Pch,IconIndex);
  IconSave.Handle := IconExtr;
  Bitmap.Width := IconSave.Width;
  Bitmap.Height := IconSave.Height;
  Bitmap.Canvas.Draw(0, 0, IconSave);
  ImageIcon.Picture.Icon := IconSave;
  SaveDialogIcon.InitialDir := ExtractFilePath(FullDir);
  SaveDialogIcon.FileName := '';
end;



procedure TForm1.XiButton1Click(Sender: TObject);
begin
if openPictureDialog1.Execute then
 //begin
 LoadIconFromFile;
 { st:=OpenPictureDialog1.FileName;
  st1:=OpenPictureDialog1.InitialDir;
  ImageIcon.Picture.LoadFromFile(st);}
 //end;
 //Label1.Caption:=st1;
end;



procedure TForm1.XiButton3Click(Sender: TObject);
begin
 if RzOpenDialog1.Execute=true then
   begin
    st1:=RzOpenDialog1.FileName;
    RzRankListBox1.Items.Text:=st1;
   end;

end;



procedure TForm1.FormCreate(Sender: TObject);
begin
st:='';
st1:='';
sm:=0;
 GetWindowsDirectory(wd,max_path);
 _wd:= strpas(wd)+'\';
 if (FileExists(_WD+'Рододендрон.bmp')) then
   begin
    Image2.Picture.LoadFromFile(_WD+'Рододендрон.bmp');
    st2:=_WD+'Рододендрон.bmp';
   end  else ;   //не чего не делаем!!!
end;

procedure TForm1.XiButton2Click(Sender: TObject);
var
str:TextFile;
i:Integer;
begin
//ini:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'autoran.inf');
// ini.WriteString('ZZZ','=',st);
// pp:=ExpandFileName(st);
// pp1:=ExpandFileName(st1);

 IconSave.SaveToFile(ExtractFilePath(Application.ExeName)+SaveDialogIcon.FileName+'Loh.ico');

 //copyfile(pchar(st),pchar(ExtractFilePath(Application.ExeName)+ExtractFileName(st){+'SV.dll'}),true);
 CopyFile(pchar(st1),pchar(ExtractFilePath(Application.ExeName)+ExtractFileName(st1)),true);

AssignFile(str,pchar(ExtractFilePath(Application.ExeName))+'Autorun.inf');
Rewrite(str);
Writeln(str,'[Autorun]');
Writeln(str,'Open='+ExtractFileName(st1));
Writeln(str,'Icon='+ExtractFileName(st)+',0');
CloseFile(str);
end;


procedure TForm1.RzRankListBox1DblClick(Sender: TObject);
var
mes:Integer;
begin
mes:=MessageDlg('хотите чтобы файл  '+ExtractFileName(st1)+'  загружался???',mtConfirmation,[mbYes,mbNo],0);
if mes=mrNo then begin
                if RzOpenDialog1.Execute=true then
                   RzRankListBox1.Items.Text:=RzOpenDialog1.FileName;
                 end;
//MessageBeep(CM_SYSFONTCHANGED);
end;

procedure TForm1.RzComboBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{RzComboBox1.Items.Add(rzComboBox1.Text);
ShellExecute(handle, 'open', PChar(rzComboBox1.Text), nil, nil, SW_ShowNormal);
rzComboBox1.Items.SaveToFile('combobox.txt');}

end;

procedure TForm1.RzComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
   //if RzComboBox1.Items.Text=
end;

procedure TForm1.XiButton4Click(Sender: TObject);
var
bmp:TBitmap;
begin
 if OpenPictureDialog2.Execute=true then
   begin
   st2:=OpenPictureDialog2.FileName;
   Image2.Picture.LoadFromFile(st2);
   end;
end;

procedure TForm1.XiButton6Click(Sender: TObject);
var
str:TextFile;
i,ii:Integer;

//sa:String;
begin
   //p:= expandfilename(paramstr(0));


   DeleteFile(pchar(_WD+'system'+'\'+'Oeminfo.ini'));
   DeleteFile(pchar(_WD+'system'+'\'+'oemlogo.bmp'));

 CopyFile(pchar(st2),pchar(_WD+'system'+'\'+'oemlogo.bmp'),true);
 AssignFile(str,pchar(ExtractFilePath(Application.ExeName))+'Oeminfo.ini');
Rewrite(str);
Writeln(str,'[General]');
Writeln(str,'Manufacturer=',RzComboBox1.Text);
Writeln(str,'Model=',RzComboBox2.Text);
writeln(str,'[Support Information]');
 for i:=0 to RzMemo1.Line do begin
Writeln(str,'Line',i+1,'=',rzmemo1.Lines.Strings[i]);
                             end;
CloseFile(str);

CopyFile(pchar(ExtractFilePath(Application.ExeName)+'Oeminfo.ini'),pchar(_WD+'system'+'\'+'Oeminfo.ini'),True);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
sm:=sm+1;
if Odd(sm)=True then
                  begin
                   glLabel3.Colors.Shadow:=clRed;
                   glLabel3.Font.Size:=10;
                  end
                   else begin
                    glLabel3.Colors.Shadow:=clBlue;
                    glLabel3.Font.Size:=8;
                        end;

if (sm mod 1)=0 then begin
RzPageControl1.TextColors.Selected:=clBlue;
                     end;
if (sm mod 2)=0 then begin
RzPageControl1.TextColors.Selected:=clFuchsia;
                     end;
if (sm mod 3)=0 then begin
RzPageControl1.TextColors.Selected:=clGreen;
                     end;

//glLabel3.Font.Size:=20;
//glLabel3.Caption:= SHGetSpecialFolderPath(0,pchar(CSIDL_DESKTOP),CSIDL_DESKTOP,True);;// IntToStr(sm);//TimeToStr(MDITILE_HORIZONTAL);
end;

procedure TForm1.glLabel3Click(Sender: TObject);
begin
 WinExec('rundll32 shell32,Control_RunDLL sysdm.cpl',0);
end;

procedure TForm1.XiButton5Click(Sender: TObject);
var
_WD:String;
wd: array [0..max_path] of char;
begin
WinExec('calc',0);

end;

procedure TForm1.FormActivate(Sender: TObject);
begin

  IconSave := TIcon.Create;
  Bitmap := TBitmap.Create;

end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if not (Key in ['0'..'9',#8]) then
    key := #0;

end;

end.

