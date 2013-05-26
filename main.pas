unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
  const
    size = 10;
  type
    a = array [1..size] of extended;
  var
    x: a = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0);


type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function f(i,n:Integer) : Extended; far;
begin
  case i of
    1: f:=3*x[1]-Cos(x[2]*x[3])-0.5;
  end
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage (FloatToStr(f(1,5)));
end;

end.
