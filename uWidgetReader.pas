unit uWidgetReader;

interface

uses
  System.SysUtils, uWidget, System.Classes, Vcl.Dialogs;

type
  TWidgetReader = class
    procedure LoadFileToList(const FileName: TFileName;
                              WidgetList : TWidgetList);
    procedure AddWidgetToList(SourceStr : string; WidgetList : TWidgetList);
  end;

implementation

procedure TWidgetReader.LoadFileToList(const FileName: TFileName;
                                      WidgetList : TwidgetList);
var
  Reader : TStreamReader;
  LineContent : string;
begin
  Reader := TStreamReader.Create(
            FileName,
            TEncoding.UTF8);
  try
    while not(Reader.EndOfStream) do
    begin
      LineContent := Reader.ReadLine;
      AddWidgetToList(LineContent,WidgetList);
    end;
  except
    on E : Exception do
      ShowMessage ('Exception Message = ' + E.Message);
  end;
  Reader.Free;
end;

procedure TWidgetReader.AddWidgetToList(SourceStr: string; WidgetList: TWidgetList);
var
  description : string;
  id : Integer;
  tabPosition : Integer;
  StrLength : Integer;
  Widget : TWidget;
begin
  StrLength := Length(SourceStr);
  tabPosition := Pos(#9,SourceStr);
  id := StrToInt(Copy(SourceStr,0,tabPosition-1));
  description := Copy(SourceStr,tabPosition+1,StrLength - tabPosition);
  Widget := TWidget.Create(id,description);
  WidgetList.Add(Widget);
end;

end.
