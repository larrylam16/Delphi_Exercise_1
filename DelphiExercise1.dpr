program DelphiExercise1;

uses
  Vcl.Forms,
  uWidgetForm in 'uWidgetForm.pas' {WidgetReader},
  uWidget in 'uWidget.pas',
  uWidgetReader in 'uWidgetReader.pas',
  uSubWidget in 'uSubWidget.pas',
  uConstValue in 'uConstValue.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TWidgetForm, WidgetForm);
  Application.Run;
end.
