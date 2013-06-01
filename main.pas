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
    outputShowResults: TStringGrid;
    labelInitialValues: TLabel;
    labelComputedResults: TLabel;
    labelNumberOfVariables: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    inputShowEntriesInt: TStringGrid;
    inputShowResultsInt: TStringGrid;
    labelNumberOfIntervals: TLabel;
    inputLoadEntriesInt: TButton;
    labelInitialIntervals: TLabel;
    labelComputedIntervals: TLabel;
    inputEntriesInt: TEdit;
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

procedure showResults(opt: Integer); far;
var i,count:Integer;
begin
  count:= Form1.outputShowResults.RowCount-1;
  Form1.outputShowResults.Cells[0,0]:='xs';
  Form1.outputShowResults.Cells[1,0]:='results';
  for i:=1 to count do
    begin
      if opt=0 then
        Form1.outputShowResults.Cells[1,i]:='-';
      Form1.outputShowResults.Cells[0,i]:='x'+IntToStr(i);
    end
end;

procedure showResultsInt(opt: Integer); far;
var i,count:Integer;
begin
  count:= Form1.outputShowResultsInt.RowCount-1;
  Form1.outputShowResultsInt.Cells[0,0]:='xs';
  Form1.outputShowResultsInt.Cells[1,0]:='results.left';
  Form1.outputShowResultsInt.Cells[2,0]:='results.right';
  for i:=1 to count do
    begin
      if opt=0 then
        begin
          Form1.outputShowResultsInt.Cells[1,i]:='-';
          Form1.outputShowResultsInt.Cells[2,i]:='-';
        end;
      Form1.outputShowResultsInt.Cells[0,i]:='x'+IntToStr(i);
    end
end;

procedure TForm1.inputLoadEntriesClick(Sender: TObject);
var
  res: extended;
  it,st,i, n: integer;
begin
  try
    n:=strToInt(inputEntries.Text)+1; //to-do try except
    inputShowEntries.RowCount:=n;
    outputShowResults.RowCount:=n;
    showEntries(0);
    showResults(0);
  except
    on Exception : EConvertError do
      ShowMessage('Not an integer!');
  end;
end;

end.
