unit SnakeMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Rtti, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Objects,
  ViewModel.Snake, Vcl.Graphics;

type
  TForm1 = class(TForm)
    btnStart: TSpeedButton;
    btnPause: TSpeedButton;
    btnContinue: TSpeedButton;
    Image1: TImage;
    lblLength: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
    procedure btnContinueClick(Sender: TObject);
  private
    { Private declarations }
    FSnakeViewModel: TSnakeViewModel;
    procedure SnakeLengthChange;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.btnContinueClick(Sender: TObject);
begin
  FSnakeViewModel.Continue;
end;

procedure TForm1.btnPauseClick(Sender: TObject);
begin
  FSnakeViewModel.Pause;
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  FSnakeViewModel.Start;
end;

procedure TForm1.FormCreate(Sender: TObject);
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

procedure TForm1.SnakeLengthChange;
begin
  lblLength.Text := IntToStr(FSnakeViewModel.SnakeLength);
end;

end.
