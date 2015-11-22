unit Model.Snake;

interface

uses Classes, Graphics, Sysutils, ExtCtrls, Types, Contnrs, Generics.Collections;

type

  TGameStatus = (gsRuning, gsGameOver);

  TSnakeLendthChangeEvent = procedure of Object;

  TSnake = class
  private
    FWidth: Integer;  //the count of square not pixels
    FHeight: Integer;
    FRectPix: Integer;
    FclrSquare: TColor;
    FclrBack: TColor;
    FclrFood: TColor;
    FImage: TImage;

    FSnakePoints: TList<TPoint>;
    FFoodPoint: TPoint;
    FMoveDirection: Char;
    FQueueKeys: TQueue<Char>;
    FTimer: TTimer;

    FStatus: TGameStatus;
    FSnakeLenght: Integer;
    FOnSnakeLengthChange: TSnakeLendthChangeEvent;

    procedure OnTimer(Sender: TObject);
    procedure SetSnakeLength(const Value: Integer);
    procedure SnakePointsNotify(Sender: TObject; const Item: TPoint; Action: TCollectionNotification);

    procedure DrawSquare(pt: TPoint; clr: TColor);
    procedure DrawFood;
    procedure Move;
    procedure Move2Next(const P: TPoint);

  protected
  public
    property SnakeLength: Integer read FSnakeLenght write SetSnakeLength;
    property OnSnakeLengthChange: TSnakeLendthChangeEvent read FOnSnakeLengthChange write FOnSnakeLengthChange;
    constructor Create(const x, y, r, t: Integer; const clrSquare, clrBack, clrFood: TColor; img: TImage);
    destructor Destroy; override;

    procedure Start;
    procedure Pause;
    procedure Continue;
    procedure TurnLeft;
    procedure TurnRight;
    procedure TurnUp;
    procedure TurnDown;
  end;

implementation

const
  cn_initCount = 16;
  cn_maxQueueCount = 5;


constructor TSnake.Create(const x, y, r, t: Integer; const clrSquare, clrBack, clrFood: TColor; img: TImage);
begin
  FWidth := x;
  FHeight := y;
  FRectPix := r;
  FclrSquare := clrSquare;
  FclrBack := clrBack;
  FclrFood := clrFood;
  FImage := img;

  FQueueKeys := TQueue<Char>.Create;

  FSnakeLenght := 0;
  FSnakePoints := TList<TPoint>.Create;
  FSnakePoints.OnNotify := SnakePointsNotify;

  FTimer := TTimer.Create(nil);
  FTimer.Enabled := False;
  FTimer.Interval := t;
  FTimer.OnTimer := OnTimer;
end;

destructor TSnake.Destroy;
begin
  FreeAndNil(FQueueKeys);
  FreeAndNil(FTimer);
  FSnakePoints.OnNotify := nil;
  FreeAndNil(FSnakePoints);
  inherited Destroy;
end;

procedure TSnake.SetSnakeLength(const Value: Integer);
begin
  FSnakeLenght := Value;
  if Assigned(FOnSnakeLengthChange) then
    FOnSnakeLengthChange;
end;

procedure TSnake.SnakePointsNotify(Sender: TObject; const Item: TPoint; Action: TCollectionNotification);
begin
  if (Action = cnAdded) and (FSnakeLenght <> FSnakePoints.Count) then
    SetSnakeLength(FSnakePoints.Count);
end;

procedure TSnake.Start;
var
  i: Integer;
  pt: TPoint;
begin
  FImage.Canvas.Brush.Color := FclrBack;
  FImage.Canvas.FillRect(Rect(0, 0, FImage.Width, FImage.Height));
  FSnakePoints.Clear;
  for i := 0 to cn_initCount - 1 do
  begin
    pt.X := i + (FWidth - cn_initCount) div 2;
    pt.Y := 10;
    FSnakePoints.Add(pt);
  end;
  for i := 0 to FSnakePoints.Count - 1 do
    DrawSquare(FSnakePoints[i], FclrSquare);

  DrawFood;
  FqueueKeys.Clear;
  FqueueKeys.Enqueue('R');
  FStatus := gsRuning;

  FTimer.Enabled := True;
end;

procedure TSnake.DrawSquare(pt: TPoint; clr: TColor);
begin
  FImage.Canvas.Brush.Color := clr;
  FImage.Canvas.FillRect(Rect(pt.X * FRectPix, pt.Y * FRectPix,
                              pt.X * FRectPix + FRectPix - 1,
                              pt.Y * FRectPix + FRectPix - 1));
end;

procedure TSnake.DrawFood;
begin
  Randomize;
  while True do
  begin
    FFoodPoint.X := Random(FWidth);
    FFoodPoint.Y := Random(FHeight);
    if FSnakePoints.IndexOf(FFoodPoint) < 0 then Break;
  end;
  DrawSquare(FFoodPoint, FclrFood);
end;

procedure TSnake.OnTimer(Sender: TObject);
begin
  Move;
end;

procedure TSnake.Move;
var
  NextP: TPoint;
begin
  NextP := FSnakePoints[FSnakePoints.Count - 1];
  if FQueueKeys.Count > 0 then
    FMoveDirection := FQueueKeys.Dequeue;
  case FMoveDirection of
    'R': NextP.X := NextP.X + 1;
    'L': NextP.X := NextP.X - 1;
    'U': NextP.Y := NextP.Y - 1;
    'D': NextP.Y := NextP.Y + 1;
  end;
  //if NextP <> FSnakePoints[FSnakePoints.Count - 1] then
  if (NextP.X <> FSnakePoints[FSnakePoints.Count - 1].X) or
     (NextP.Y <> FSnakePoints[FSnakePoints.Count - 1].Y) then
    Move2Next(NextP);
end;

procedure TSnake.Move2Next(const P: TPoint);
var
  LastP: TPoint;
begin
  if (P.X >= 0) and (P.Y >= 0) and (P.X < FWidth) and
     (P.Y < FHeight) and (FSnakePoints.IndexOf(p) = -1) then
  begin
    //if P = FFoodPoint then
    if (P.X = FFoodPoint.X) and (P.Y = FFoodPoint.Y) then
    begin
      DrawFood;
    end else begin
      LastP := FSnakePoints[0];
      FSnakePoints.Delete(0);
      DrawSquare(LastP, FclrBack);
    end;
    FSnakePoints.Add(P);
    DrawSquare(P, FclrSquare);
  end else begin
    FStatus := gsGameOver;
    FTimer.Enabled := False;
    FImage.Canvas.Brush.Color := clWhite;
    FImage.Canvas.Font.Size := 22;
    FImage.Canvas.TextOut(FRectPix * (FWidth - 25) div 2,
                          FRectPix * (FHeight - 20) div 2, 'Game Over');
  end;
end;

procedure TSnake.TurnDown;
begin
  if (FMoveDirection <> 'U') and (FQueueKeys.Count < cn_maxQueueCount) then
    FQueueKeys.Enqueue('D');
end;

procedure TSnake.TurnLeft;
begin
  if (FMoveDirection <> 'R') and (FQueueKeys.Count < cn_maxQueueCount) then
    FQueueKeys.Enqueue('L');
end;

procedure TSnake.TurnRight;
begin
  if (FMoveDirection <> 'L') and (FQueueKeys.Count < cn_maxQueueCount) then
    FQueueKeys.Enqueue('R');
end;

procedure TSnake.TurnUp;
begin
  if (FMoveDirection <> 'D') and (FQueueKeys.Count < cn_maxQueueCount) then
    FQueueKeys.Enqueue('U');
end;

procedure TSnake.Pause;
begin
  FTimer.Enabled := False;
end;

procedure TSnake.Continue;
begin
  if FStatus <> gsGameOver then
    FTimer.Enabled := True;
end;



end.
