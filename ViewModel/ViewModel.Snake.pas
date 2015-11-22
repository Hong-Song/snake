unit ViewModel.Snake;

interface

uses Model.Snake, Classes, Graphics, Sysutils, ExtCtrls, Types, Contnrs, Generics.Collections;


type
  TSnakeLendthChangeEvent = procedure of Object;

  TSnakeViewModel = class
  private
    FSnake: TSnake;
    FSnakeLenght: Integer;

    FOnSnakeLengthChange: TSnakeLendthChangeEvent;

    procedure SetSnakeLength(const Value: Integer);
    procedure SnakeLengthChange;
  public
    property SnakeLength: Integer read FSnakeLenght write SetSnakeLength;
    property OnSnakeLengthChange: TSnakeLendthChangeEvent read FOnSnakeLengthChange write FOnSnakeLengthChange;

    constructor Cretae(const x, y, r, t: Integer; const clrSquare, clrBack, clrFood: TColor; img: TImage);
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

{ TSnakeViewModel }

procedure TSnakeViewModel.Continue;
begin
  FSnake.Continue;
end;

constructor TSnakeViewModel.Cretae(const x, y, r, t: Integer; const clrSquare,
  clrBack, clrFood: TColor; img: TImage);
begin
  FSnake := TSnake.Create(x, y, r, t, clrSquare, clrBack, clrFood, img);
  FSnake.OnSnakeLengthChange := SnakeLengthChange;
end;

destructor TSnakeViewModel.Destroy;
begin
  FSnake.Free;
  inherited Destroy;
end;

procedure TSnakeViewModel.SetSnakeLength(const Value: Integer);
begin
  FSnakeLenght := Value;
  if Assigned(FOnSnakeLengthChange) then
    FOnSnakeLengthChange;
end;

procedure TSnakeViewModel.SnakeLengthChange;
begin
  SetSnakeLength(FSnake.SnakeLength);
end;

procedure TSnakeViewModel.Pause;
begin
  FSnake.Pause;
end;

procedure TSnakeViewModel.Start;
begin
  FSnake.Start;
end;

procedure TSnakeViewModel.TurnDown;
begin
  FSnake.TurnDown;
end;

procedure TSnakeViewModel.TurnLeft;
begin
  FSnake.TurnLeft;
end;

procedure TSnakeViewModel.TurnRight;
begin
  FSnake.TurnRight;
end;

procedure TSnakeViewModel.TurnUp;
begin
  FSnake.TurnUp;
end;

end.
