unit uWidgetReader;

interface

uses
  System.SysUtils, uWidget, System.Classes, Vcl.Dialogs, uConstValue;

type
  TWidgetReader = class
  private
    procedure AddWidgetToList(SourceStr : string; WidgetList : TWidgetList;
                              WidgetType : string);
  public
    procedure LoadFileToList(const FileName: TFileName;
                              WidgetList : TWidgetList;
                              WidgetType : string);
  end;




implementation

uses
  uSubWidget;

procedure TWidgetReader.LoadFileToList(const FileName: TFileName;
                                      WidgetList : TwidgetList;
                                      WidgetType : string);
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
      AddWidgetToList(LineContent,WidgetList,WidgetType);
    end;
  finally
    FreeAndNil(Reader);
  end;
end;

procedure TWidgetReader.AddWidgetToList(SourceStr: string;
                                        WidgetList: TWidgetList;
                                        WidgetType : string);
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
  if WidgetType = REDWIDGET then
    Widget := TRedWidget.Create(id,description)
  else
    if WidgetType = BLUEWIDGET then
      Widget := TBlueWidget.Create(id,description);
  WidgetList.Add(Widget);
end;

end.
