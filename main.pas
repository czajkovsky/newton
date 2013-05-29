unit main;

interface
  

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids;
  const
    size = 20;
  type
    arr = array [1..size] of extended;
    arr_int = array [1..size] of integer;
  var
    x: arr;
    dfatx: arr;

type
  TForm1 = class(TForm)
    inputLoadEntries: TButton;
    inputShowEntries: TStringGrid;
    inputEntries: TEdit;
    procedure inputLoadEntriesClick(Sender: TObject);
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

function f1(i,n:Integer) : Extended; far;
begin
  case i of
    1: f1:=Sqr(x[1])+8*x[2]-16;
    2: f1:=x[1]-Exp(x[2]);
  end
end;

procedure df1 (i, n: Integer); far;
begin
  case i of
    1: begin
      dfatx[1]:=2*x[1];
      dfatx[2]:=8;
    end;
    2: begin
      dfatx[1]:=1;
      dfatx[2]:=-Exp(x[2]);
    end;
  end;
end;

procedure showEntries(opt: Integer); far;
var i,count:Integer;
begin
  count:= Form1.inputShowEntries.RowCount-1;
  Form1.inputShowEntries.Cells[0,0]:='xs';
  Form1.inputShowEntries.Cells[1,0]:='values';
  for i:=1 to count do
    begin
      Form1.inputShowEntries.Cells[1,i]:='0';
      Form1.inputShowEntries.Cells[0,i]:='x'+IntToStr(i);
    end
end;



procedure Newtonsystem (
  n: Integer;
  mit: Integer;
  eps: Extended;
  var it,st : Integer);

var i,j,jh,k,kh,l,lh,n1,p,q,rh : Integer;
    max,s: Extended;
    cond: Boolean;
    a, b, x1: arr;
    r: arr_int;
begin
  if (n<1) or (mit<1)
    then st:=1
    else begin
      st:=0;
      it:=0;
      n1:=n+1;
      repeat
        it:=it+1;
        if it>mit
          then begin
            st:=3;
            it:=it-1
          end
          else begin
            p:=n1;
            for i:=1 to n1 do
              r[i]:=0;
            k:=0;
            repeat
              k:=k+1;
              df (k,n);
              for i:=1 to n do
                a[i]:=dfatx[i];
              s:=-f(k,n);
              for i:=1 to n do
                s:=s+dfatx[i]*x[i];
              a[n1]:=s;
              for i:=1 to n do
                begin
                  rh:=r[i];
                    if rh<>0
                      then b[rh]:=a[i]
                end;
              kh:=k-1;
              l:=0;
              max:=0;
              for j:=1 to n1 do
                if r[j]=0
                  then begin
                    s:=a[j];
                    l:=l+1;
                    q:=l;
                    for i:=1 to kh do
                      begin
                        s:=s-b[i]*x1[q];
                        q:=q+p
                      end;
                    a[l]:=s;
                    s:=abs(s);
                    if (j<n1) and (s>max)
                      then begin
                        max:=s;
                        jh:=j;
                        lh:=l
                      end
                    end;
                    if max=0
                      then st:=2
                      else begin
                        max:=1/a[lh];
                        r[jh]:=k;
                        for i:=1 to p do
                          a[i]:=max*a[i];
                        jh:=0;
                        q:=0;
                        for j:=1 to kh do
                          begin
                            s:=x1[q+lh];
                            for i:=1 to p do
                              if i<>lh
                                then begin
                                  jh:=jh+1;
                                  x1[jh]:=x1[q+i]-s*a[i]
                                end;
                            q:=q+p
                          end;
                        for i:=1 to p do
                          if i<>lh
                            then begin
                              jh:=jh+1;
                              x1[jh]:=a[i]
                            end;
                        p:=p-1
                      end
            until (k=n) or (st=2);
            if st=0
              then begin
                for k:=1 to n do
                  begin
                    rh:=r[k];
                    if rh<>k
                      then begin
                        s:=x1[k];
                        x1[k]:=x1[rh];
                        i:=r[rh];
                        while i<>k do
                          begin
                            x1[rh]:=x1[i];
                            r[rh]:=rh;
                            rh:=i;
                            i:=r[rh]
                          end;
                        x1[rh]:=s;
                        r[rh]:=rh
                      end
                  end;
                cond:=true;
                i:=0;
                repeat
                  i:=i+1;
                  max:=abs(x[i]);
                  s:=abs(x1[i]);
                  if max<s
                    then max:=s;
                  if max<>0
                    then if abs(x[i]-x1[i])/max>=eps
                      then cond:=false
                until (i=n) or not cond;
                  for i:=1 to n do
                    x[i]:=x1[i]
                  end
                  end
      until (st<>0) or cond
    end
end;







procedure TForm1.inputLoadEntriesClick(Sender: TObject);
var
  res: extended;
  it,st,i: integer;
begin
  inputShowEntries.RowCount:=strToInt(inputEntries.Text)+1; //to-do try except
  showEntries(0);
end;





end.
