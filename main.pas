{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
unit main;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, nwtsys, IntervalArithmetic;
  var
    x: vector;
    x_int: vector_int;
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
    inputModeSelect: TComboBox;
    procedure inputLoadEntriesClick(Sender: TObject);
    procedure inputLoadEntriesIntClick(Sender: TObject);
    procedure inputComputeClick(Sender: TObject);
    procedure inputComputeIntClick(Sender: TObject);
    procedure inputModeSelectChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation


{$R *.dfm}

procedure showEntries(count: Integer); far;
var i:Integer;
begin
  Form1.inputShowEntries.Visible:=true;
  Form1.outputShowResults.Visible:=true;
  Form1.inputCompute.Visible:=true;
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

procedure showEntriesInt(count: Integer); far;
var i:Integer;
begin
  Form1.inputShowEntriesInt.Visible:=true;
  Form1.inputComputeInt.Visible:=true;
  Form1.outputShowResultsInt.Visible:=true;
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

procedure showResults(x: vector; count: Integer); far;
var i:Integer;
begin
  for i:=1 to Form1.outputShowResults.rowcount-1 do
    begin
      Form1.outputShowResults.Cells[1,i]:=FloatToStrF(x[i], ffExponent, 17, 4);
    end
end;

procedure showResultsInt(x: vector_int; count: Integer); far;
var i:Integer;
begin
  for i:=1 to count-1 do
    begin
      Form1.outputShowResultsInt.Cells[1,i]:=FloatToStrF(x[i].a, ffExponent, 17, 4);
      Form1.outputShowResultsInt.Cells[2,i]:=FloatToStrF(x[i].b, ffExponent, 17, 4);
    end
end;

procedure TForm1.inputLoadEntriesClick(Sender: TObject);
begin
  try
    n:=strToInt(inputEntries.Text);
    showEntries(n+1);
  except
    on Exception : EConvertError do
      ShowMessage('Not an integer!');
  end;
end;

procedure TForm1.inputLoadEntriesIntClick(Sender: TObject);
begin
  try
    n:=strToInt(inputEntriesInt.Text);
    showEntriesInt(n+1);
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

procedure loadVectorInt(x_int:vector_int);
var i: Integer;
begin
  for i:=1 to n do
    begin
      x_int[i].a:=left_read(Form1.inputShowEntriesInt.Cells[1,i]);
      x_int[i].b:=right_read(Form1.inputShowEntriesInt.Cells[2,i]);
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
  Newtonsystem(n, x, f, df, mit, eps, it, st);
  showResults(x, n+1);
  Form1.outputIt.Text:=IntToStr(it);
  Form1.outputMessage.Text:=IntToStr(st);
end;

procedure compute_int();
var
  it, st, mit:Integer;
  eps: Extended;
  x_int: vector_int;
begin
  SetLength(x_int, n+1);
  loadVectorInt(x_int);
  eps:=StrToFloat(Form1.inputEps.Text);
  mit:=StrToInt(Form1.inputMit.Text);
  Newtonsystem_int(n, x_int, f1_int, df1_int, mit, eps, it, st);
  showResultsInt(x_int,n+1);
  Form1.outputIt.Text:=IntToStr(it);
  Form1.outputMessage.Text:=IntToStr(st);
end;

procedure TForm1.inputComputeClick(Sender: TObject);
begin
  compute();
end;

procedure TForm1.inputComputeIntClick(Sender: TObject);
begin
  compute_int();
end;

procedure TForm1.inputModeSelectChange(Sender: TObject);
begin
  if(inputModeSelect.Text = 'Interval') then
    begin
      GroupBox2.Visible:=true;
      GroupBox1.Visible:=false;
    end;
  if(inputModeSelect.Text = 'Classic') then
    begin
      GroupBox1.Visible:=true;
      GroupBox2.Visible:=false;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  inputModeSelect.Items.Add('Interval');
  inputModeSelect.Items.Add('Classic');
end;

end.
