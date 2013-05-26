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
    dfatx: a = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0);


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
    2: f:=Sqr(x[1])-81*Sqr(x[2]+0.1)+Sin(x[3])+1.06;
    3: f:=Exp(-x[1]*x[2])+20*x[3]+(10*Pi-3)/3;
  end
end;

procedure df (i, n: Integer); far;
begin
  case i of
    1: begin
      dfatx[1]:=3;
      dfatx[2]:=x[3]*Sin(x[2]*x[3]);
      dfatx[3]:=x[2]*Sin(x[2]*x[3]);
    end
  end
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  x[1]=StrToFloat(Edit1.text);
  ShowMessage (FloatToStr(f(1,5)));
end;

end.