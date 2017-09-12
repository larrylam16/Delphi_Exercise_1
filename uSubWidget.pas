unit uSubWidget;

interface

uses
  SysUtils, Classes, Generics.Collections, Generics.Defaults, uWidget;

const
  BLUE : string = 'blue';
  RED : string = 'red';

type
  TRedWidget = class(TWidget)
  private
  public
    Constructor Create(AId: Integer; ADescription: string); override;
    function GetColor : string; override;
  end;

  TBlueWidget = class(TWidget)
  private
  public
  Constructor Create(AId: Integer; ADescription: string); override;
    function GetColor : string; override;
  end;

implementation

  Constructor TRedWidget.Create(AId: Integer; ADescription: string);
    begin
      inherited Create(AId,ADescription);
      Size := 0;
    end;
  function TRedWidget.GetColor : string;
  begin
    Result := BLUE;
  end;

  Constructor TBlueWidget.Create(AId: Integer; ADescription: string);
    begin
      inherited Create(AId,ADescription);
      Size := 2;
    end;
  function TBlueWidget.GetColor : string;
  begin
    Result := RED;
  end;

end.
