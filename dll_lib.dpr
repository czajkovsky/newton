
library dll_lib;

uses
  IntervalArithmetic,
  SysUtils,
  Classes;
  type vector = array of extended;
  type vector1 = array of extended;
  type vector2 = array of integer;
  type vector3 = array of extended;

  type vector_int = array of interval;
  type vector1_int = array of interval;
  type vector2_int = array of integer;
  type vector3_int = array of interval;

{$R *.res}

function f(i,n:Integer; x: vector) : Extended; far;
begin
  case i of
    1: f:=3*x[1]-Cos(x[2]*x[3])-0.5;
    2: f:=Sqr(x[1])-81*Sqr(x[2]+0.1)+Sin(x[3])+1.06;
    3: f:=Exp(-x[1]*x[2])+20*x[3]+(10*Pi-3)/3;
  end
end;

procedure df (i, n: Integer; x: vector; var dfatx: vector); far;
begin
  case i of
    1: begin
      dfatx[1]:=3;
      dfatx[2]:=x[3]*Sin(x[2]*x[3]);
      dfatx[3]:=x[2]*Sin(x[2]*x[3])
    end;
    2: begin
      dfatx[1]:=2*x[1];
      dfatx[2]:=-162*(x[2]+0.1);
      dfatx[3]:=Cos(x[3])
    end;
    3: begin
      dfatx[1]:=-x[2]*Exp(-x[1]*x[2]);
      dfatx[2]:=-x[1]*Exp(-x[1]*x[2]);
      dfatx[3]:=20
    end
  end
end;

function f1(i,n:Integer; x: vector) : Extended; far;
begin
  case i of

    1: f1:=Sqr(x[1])+8*x[2]-16;
    2: f1:=x[1]-Exp(x[2]);
  end
end;

procedure df1(i, n: Integer; x: vector; var dfatx: vector); far;
begin
  case i of
    1: begin
        dfatx[1]:=2*x[1];
        dfatx[2]:=8
      end;
    2: begin
        dfatx[1]:=1;
        dfatx[2]:=-Exp(x[2])
      end;
    end
end;

function f1_int(i,n:Integer; x: vector_int) : Interval; far;
var
  res: Interval;
  st: Integer;
begin
  case i of
    1: begin
      res:=isqr(x[1],st);
      res:=iadd(res,imul(make_ia(8),x[2]));
      res:=isub(res,make_ia(16));
      f1_int:=res;
    end;
    2: f1_int:=isub(x[1],iexp(x[2],st));
  end
end;

procedure df1_int(i, n: Integer; x: vector_int; var dfatx: vector_int); far;
var st: Integer;
begin
  case i of
    1: begin
        dfatx[1]:=imul(make_ia(2),x[1]);
        dfatx[2]:=make_ia(8);
      end;
    2: begin
        dfatx[1]:=make_ia(1);
        dfatx[2]:=imul(make_ia(-1),iexp(x[2],st));
      end;
    end
end;

exports
  df1_int, f1_int, df1, f1;

begin
end.
 