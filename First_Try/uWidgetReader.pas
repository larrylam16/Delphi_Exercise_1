unit uWidgetReader;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uWidget;

type
  TWidgetReader = class(TForm)
    DisplayMemo: TMemo;
    OpenFileButton: TButton;
    procedure OpenFileButtonClick(Sender: TObject);
    function LoadFileToStr(const FileName: TFileName): AnsiString;
    procedure DisplayResult(WidgetList : TWidgetList; DisplayMemo : TMemo);
    procedure ListCreate(FileContent : string);
  end;

var
  WidgetReader: TWidgetReader;
  WidgetList : TWidgetList;

implementation

{$R *.dfm}

function TWidgetReader.LoadFileToStr(const FileName: TFileName) : AnsiString;
var
  FileStream : TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    if FileStream.Size > 0 then
    begin
      SetLength(Result, FileStream.Size);
      FileStream.Read(Pointer(Result)^, FileStream.Size);
    end;
  finally
    FileStream.Free;
  end;
end;

procedure TwidgetReader.ListCreate(FileContent: string);
var
  Widget : TWidget;
  StrLength : Integer;
  i : Integer;
  ch : char;
  buffer : string;
  flag : boolean; //true for Id; false for Description;
  id : integer;
begin
  StrLength := Length(FileContent);
  id := 0;
  buffer := '';
  ch := ' ';
  i := 0;
  flag := true;
  WidgetList := TWidgetList.Create;
  while i <= StrLength do
  begin
    if ch = #9 then
      begin
        if flag then
        begin
          id := StrToInt(buffer);
          buffer := '';
          ch := ' ';
          flag := false;
        end
        else
        begin
          Widget := TWidget.Create(id,buffer);
          WidgetList.Add(Widget);
          buffer :='';
          ch := ' ';
          flag := true;
        end;

      end
      else
      begin
        ch := FileContent[i];
        if (ch <> #0) and (ch <> #9)  then
          buffer := buffer + ch;
        inc(i);
      end;
    end;
  Widget := TWidget.Create(id,buffer);
  WidgetList.Add(Widget);
end;
procedure TWidgetReader.OpenFileButtonClick(Sender: TObject);
var
  OpenFile : TOpenDialog;
  FileContent : string;
begin
  OpenFile := TOpenDialog.Create(self);
  OpenFile.InitialDir := GetCurrentDir;
  OpenFile.Options := [ofFileMustExist];
  if not OpenFile.Execute then
    ShowMessage('Open file was cancelled')
  else
  begin
    FileContent := string(LoadFileToStr(OpenFile.Files[0]));
    DisplayMemo.Text :='';
    ListCreate(FileContent);
    DisplayResult(WidgetList, DisplayMemo);
  end;
  OpenFile.Free;
end;

procedure TWidgetReader.DisplayResult(WidgetList : TWidgetList; DisplayMemo : TMemo);
var
  count : Integer;
  i : Integer;
  widget : TWidget;
begin
  WidgetList.SortById;
  count := WidgetList.Count;
  for i := 0 to count - 1 do
  begin
    widget := WidgetList.Items[i];
    DisplayMemo.Text := DisplayMemo.Text + widget.AsString;
  end;
  for i := count - 1 to 0 do
  begin
    widget := WidgetList.Items[i];
    widget.Free;
  end;
  WidgetList.Free;
end;

end.
