program Snake;

uses
  Forms,
  snakemain in 'snakemain.pas' {frmMain},
  Model.Snake in '..\..\Model\Model.Snake.pas',
  ViewModel.Snake in '..\..\ViewModel\ViewModel.Snake.pas';

{$R *.res}

//comments
begin
  ReportMemoryLeaksOnShutdown := (DebugHook<>0);
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
