unit uWidgetReader;

interface

uses
  System.SysUtils, uWidget, System.Classes, Vcl.Dialogs, uConstValue;

type
  TWidgetReader = class
  private
    procedure AddWidgetToList(SourceStr : string; WidgetList : TWidgetList;
                              WidgetClass : TWidgetClass);
  public
    procedure LoadFileToList(const FileName: TFileName;
                              WidgetList : TWidgetList;
                              WidgetClass : TWidgetClass);
  end;


implementation


procedure TWidgetReader.LoadFileToList(const FileName: TFileName;
                                      WidgetList : TwidgetList;
                                      WidgetClass : TWidgetClass);
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
      AddWidgetToList(LineContent,WidgetList,WidgetClass);
    end;
  finally
    FreeAndNil(Reader);
  end;
end;

procedure TWidgetReader.AddWidgetToList(SourceStr: string;
                                        WidgetList: TWidgetList;
                                        WidgetClass : TWidgetClass);
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
  Widget := WidgetClass.Create(id,description);
  WidgetList.Add(Widget);
end;

end.
