unit uWidget;

interface

uses
  SysUtils, Classes, Generics.Collections, Generics.Defaults, uConstValue;

type
  TWidget = class
  private
    FId : Integer;
    FDescription : string;
    FSize : Integer;
    function GetAsString : string;
  public
    property Id : Integer read FId;
    property Description : string read FDescription write FDescription;
    property AsString : string read GetAsString;
    property Size : Integer read FSize write FSize;
    Constructor Create(AId: Integer; ADescription: string); virtual;
    function GetColor : string; virtual; abstract;
    property Color : string read GetColor;

  end;

  TWidgetList = class
  private
    FItems : TObjectList<TWidget>;
    function GetItems(Index : Integer) : TWidget;
    procedure SetItems(Index : Integer; const Value : TWidget);
  public
    property Items[Index : Integer] : TWidget read GetItems write SetItems;
    function Add(Widget : TWidget): Integer;
    function Count() : Integer;
    procedure SortById;
    constructor Create;
    destructor Destroy; override;
  end;


implementation

uses Math;


Constructor TWidget.Create(AId: Integer; ADescription: string);
begin
  inherited Create;
  FId := AId;
  FDescription := ADescription;
  FSize := 0;
end;


function TWidget.GetAsString: string;
begin
  Result := 'Id: ' + IntToStr(FId) + ', Description: ' +
                   FDescription + ', Color: ' + GetColor +
                   ', Size: ' + IntToStr(FSize);
end;

function TWidgetList.Add(Widget: TWidget) : Integer;
begin
  Result := FItems.Add(Widget);
end;

function TWidgetList.Count : Integer;
begin
  Result := FItems.Count;
end;

constructor TWidgetList.Create;
begin
  inherited;
  FItems := TObjectList<TWidget>.Create;
end;

function TWidgetList.GetItems(Index: Integer) : TWidget;
begin
  Result := TWidget(FItems[Index]);
end;

procedure TWidgetList.SetItems(Index: Integer; const Value : TWidget);
begin
  FItems[Index] := Value;
end;


procedure TWidgetList.SortById;
begin
  FItems.Sort(TComparer<TWidget>.Construct(
    function(const L, R: TWidget) : Integer
    begin
       Result := CompareValue(L.FId, R.FId);
    end
  ));
end;

destructor TWidgetList.Destroy;
begin
  FItems.Free;
  inherited;
end;



end.
