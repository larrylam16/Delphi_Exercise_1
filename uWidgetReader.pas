unit uWidgetReader;

interface

uses
  System.SysUtils, uWidget, System.Classes, Vcl.Dialogs;

type
  TWidgetReader = class
  private
    procedure AddWidgetToList(SourceStr : string; WidgetList : TWidgetList);
  public
    procedure LoadFileToList(const FileName: TFileName;
                              WidgetList : TWidgetList);
  end;


const
  TAB : char = #9;

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
  finally
    FreeAndNil(Reader);
  end;
end;

procedure TWidgetReader.AddWidgetToList(SourceStr: string; WidgetList: TWidgetList);
var
  Description : string;
  Id : Integer;
  TabPosition : Integer;
  StrLength : Integer;
  Widget : TWidget;
begin
  StrLength := Length(SourceStr);
  TabPosition := Pos(TAB,SourceStr);
  Id := StrToInt(Copy(SourceStr,0,tabPosition-1));
  Description := Copy(SourceStr,tabPosition+1,StrLength - tabPosition);
  Widget := TWidget.Create(id,description);
  WidgetList.Add(Widget);
end;

end.
