unit snakemain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ViewModel.Snake,
  Buttons;

type
  TfrmMain = class(TForm)
    Image1: TImage;
    btnStart: TSpeedButton;
    btnPause: TSpeedButton;
    btnContinue: TSpeedButton;
    lblLength: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
    procedure btnContinueClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FSnakeViewModel: TSnakeViewModel;
    procedure SnakeLengthChange;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnContinueClick(Sender: TObject);
begin
  FSnakeViewModel.Continue;
end;

procedure TfrmMain.btnPauseClick(Sender: TObject);
begin
  FSnakeViewModel.Pause;
end;

procedure TfrmMain.btnStartClick(Sender: TObject);
begin
  FSnakeViewModel.Start;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FSnakeViewModel.Free;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
const
  cn_Width = 30;
  cn_Height = 25;
  cn_RectPix = 20;
  cn_TimeInterval = 100;
  cn_ColorSquare = clBlue;
  cn_ColorBack = clBlack;
  cn_ColorFood = clRed;
begin
  Self.Width := cn_Width * cn_RectPix + 40;
  Self.Height := cn_Height * cn_RectPix + 80;
  Image1.Width := cn_Width * cn_RectPix;
  Image1.Height := cn_Height * cn_RectPix;
  FSnakeViewModel := TSnakeViewModel.Cretae(cn_Width, cn_Height, cn_RectPix,
                           cn_TimeInterval, cn_ColorSquare, cn_ColorBack, cn_ColorFood, Image1);
  FSnakeViewModel.OnSnakeLengthChange := SnakeLengthChange;
end;

procedure TfrmMain.SnakeLengthChange;
begin
  lblLength.Caption := IntToStr(FSnakeViewModel.SnakeLength);
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F2: FSnakeViewModel.Start;
    VK_Up: FSnakeViewModel.TurnUp;
    VK_Down: FSnakeViewModel.TurnDown;
    VK_Left: FSnakeViewModel.TurnLeft;
    VK_Right: FSnakeViewModel.TurnRight;
  end;
end;


end.
