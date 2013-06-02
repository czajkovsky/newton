unit main;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, nwtsys;
  var
    x: vector;
    n: Integer;

type
  TForm1 = class(TForm)
    inputLoadEntries: TButton;
    inputShowEntries: TStringGrid;
    inputEntries: TEdit;
    outputShowResults: TStringGrid;
    labelInitialValues: TLabel;
    labelComputedResults: TLabel;
    labelNumberOfVariables: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    inputShowEntriesInt: TStringGrid;
    outputShowResultsInt: TStringGrid;
    labelNumberOfIntervals: TLabel;
    inputLoadEntriesInt: TButton;
    labelInitialIntervals: TLabel;
    labelComputedIntervals: TLabel;
    inputEntriesInt: TEdit;
    inputCompute: TButton;
    inputComputeInt: TButton;
    GroupBox3: TGroupBox;
    inputMit: TEdit;
    Label1: TLabel;
    inputEps: TEdit;
    Label2: TLabel;
    GroupBox4: TGroupBox;
    outputIt: TEdit;
    outputMessage: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    procedure inputLoadEntriesClick(Sender: TObject);
    procedure inputLoadEntriesIntClick(Sender: TObject);
    procedure inputComputeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation


{$R *.dfm}

procedure showEntries(opt, count: Integer); far;
var i:Integer;
begin
  Form1.inputShowEntries.RowCount:=count;
  Form1.outputShowResults.RowCount:=count;
  Form1.inputShowEntries.Cells[0,0]:='xs';
  Form1.inputShowEntries.Cells[1,0]:='values';
  Form1.outputShowResults.Cells[0,0]:='xs';
  Form1.outputShowResults.Cells[1,0]:='results';
  for i:=1 to count do
    begin
      Form1.inputShowEntries.Cells[1,i]:='0';
      Form1.inputShowEntries.Cells[0,i]:='x'+IntToStr(i);
      Form1.outputShowResults.Cells[0,i]:='x'+IntToStr(i);
      Form1.outputShowResults.Cells[1,i]:='-';
    end
end;

procedure showEntriesInt(opt, count: Integer); far;
var i:Integer;
begin
  Form1.inputShowEntriesInt.RowCount:=count;
  Form1.outputShowResultsInt.RowCount:=count;
  Form1.inputShowEntriesInt.Cells[0,0]:='xs';
  Form1.inputShowEntriesInt.Cells[1,0]:='values.left';
  Form1.inputShowEntriesInt.Cells[2,0]:='values.right';
  Form1.outputShowResultsInt.Cells[0,0]:='xs';
  Form1.outputShowResultsInt.Cells[1,0]:='results.left';
  Form1.outputShowResultsInt.Cells[2,0]:='results.right';
  for i:=1 to count do
    begin
      Form1.inputShowEntriesInt.Cells[1,i]:='0';
      Form1.inputShowEntriesInt.Cells[2,i]:='0';
      Form1.inputShowEntriesInt.Cells[0,i]:='x'+IntToStr(i);
      Form1.outputShowResultsInt.Cells[1,i]:='-';
      Form1.outputShowResultsInt.Cells[2,i]:='-';
      Form1.outputShowResultsInt.Cells[0,i]:='x'+IntToStr(i);
    end
end;

procedure showResults(x: vector; opt, count: Integer); far;
var i:Integer;
begin
  for i:=1 to Form1.outputShowResults.rowcount do
    begin
      Form1.outputShowResults.Cells[1,i]:=FloatToStr(x[i]);
    end
end;

procedure TForm1.inputLoadEntriesClick(Sender: TObject);
begin
  try
    n:=strToInt(inputEntries.Text);
    showEntries(0, n+1);
  except
    on Exception : EConvertError do
      ShowMessage('Not an integer!');
  end;
end;

procedure TForm1.inputLoadEntriesIntClick(Sender: TObject);
begin
  try
    n:=strToInt(inputEntriesInt.Text);
    showEntriesInt(0, n+1);
  except
  end;
end;

procedure loadVector(x:vector);
var i: Integer;
begin
  for i:=1 to n do
    begin
      x[i]:=StrToFloat(Form1.inputShowEntries.Cells[1,i]);
    end
end;

procedure compute();
var
  it, st, mit:Integer;
  eps: Extended;
  x: vector;
begin
  SetLength(x, n+1);
  loadVector(x);
  eps:=StrToFloat(Form1.inputEps.Text);
  mit:=StrToInt(Form1.inputMit.Text);
  Newtonsystem(n, x, f1, df1, mit, eps, it, st);
  showResults(x,1,n+1);
  Form1.outputIt.Text:=IntToStr(it);
  Form1.outputMessage.Text:=IntToStr(st);
end;

procedure TForm1.inputComputeClick(Sender: TObject);
begin
  compute();
end;

end.
