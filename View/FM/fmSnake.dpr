program fmSnake;

uses
  FMX.Forms,
  SnakeMain in 'SnakeMain.pas' {Form1},
  ViewModel.Snake in '..\..\ViewModel\ViewModel.Snake.pas',
  Model.Snake in '..\..\Model\Model.Snake.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
