unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, nwtsys, IntervalArithmetic, Buttons;
  var
    x: vector;
    x_int: vector_int;
    n: Integer;
    dllHandler: cardinal;
    dllFX_int: fx_int;
    dllDX_int: dfx_int;
    dllFX: fx;
    dllDX: dfx;

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
    inputLoadDll: TButton;
    LoadDLLDialog: TOpenDialog;
    GroupBox5: TGroupBox;
    inputEntriesInt2: TEdit;
    inputLoadEntriesInt2: TButton;
    inputShowEntriesInt2: TStringGrid;
    Label5: TLabel;
    outputShowResultsInt2: TStringGrid;
    inputComputeInt2: TBitBtn;
    Label6: TLabel;
    procedure inputLoadEntriesClick(Sender: TObject);
    procedure inputLoadEntriesIntClick(Sender: TObject);
    procedure inputComputeClick(Sender: TObject);
    procedure inputComputeIntClick(Sender: TObject);
    procedure inputModeSelectChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure inputLoadDllClick(Sender: TObject);
    procedure inputLoadEntriesInt2Click(Sender: TObject);
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

procedure showEntriesInt2(count: Integer); far;
var i:Integer;
begin
  Form1.inputShowEntriesInt2.Visible:=true;
  Form1.inputComputeInt2.Visible:=true;
  Form1.outputShowResultsInt2.Visible:=true;
  Form1.inputShowEntriesInt2.RowCount:=count;
  Form1.outputShowResultsInt2.RowCount:=count;
  Form1.inputShowEntriesInt2.Cells[0,0]:='xs';
  Form1.inputShowEntriesInt2.Cells[1,0]:='values';
  Form1.outputShowResultsInt2.Cells[0,0]:='xs';
  Form1.outputShowResultsInt2.Cells[1,0]:='results.left';
  Form1.outputShowResultsInt2.Cells[2,0]:='results.right';
  for i:=1 to count do
    begin
      Form1.inputShowEntriesInt2.Cells[1,i]:='0';
      Form1.inputShowEntriesInt2.Cells[0,i]:='x'+IntToStr(i);
      Form1.outputShowResultsInt2.Cells[1,i]:='-';
      Form1.outputShowResultsInt2.Cells[2,i]:='-';
      Form1.outputShowResultsInt2.Cells[0,i]:='x'+IntToStr(i);
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

procedure showResultsInt2(x: vector_int; count: Integer); far;
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

procedure loadVectorInt2(x_int:vector_int);
var i: Integer;
begin
  for i:=1 to n do
    begin
      x_int[i]:=int_read(Form1.inputShowEntriesInt2.Cells[1,i]);
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
  Newtonsystem(n, x, dllFx, dllDX, mit, eps, it, st);
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
  Newtonsystem_int(n, x_int, dllFX_int, dllDX_int, mit, eps, it, st);
  showResultsInt(x_int,n+1);
  Form1.outputIt.Text:=IntToStr(it);
  Form1.outputMessage.Text:=IntToStr(st);
end;

procedure compute_int2();
var
  it, st, mit:Integer;
  eps: Extended;
  x_int: vector_int;
begin
  SetLength(x_int, n+1);
  loadVectorInt2(x_int);
  eps:=StrToFloat(Form1.inputEps.Text);
  mit:=StrToInt(Form1.inputMit.Text);
  Newtonsystem_int(n, x_int, dllFX_int, dllDX_int, mit, eps, it, st);
  showResultsInt2(x_int,n+1);
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
      GroupBox5.Visible:=false;
    end;
  if(inputModeSelect.Text = 'Classic') then
    begin
      GroupBox1.Visible:=true;
      GroupBox2.Visible:=false;
      GroupBox5.Visible:=false;
    end;
  if(inputModeSelect.Text = 'Interval2') then
    begin
      GroupBox1.Visible:=false;
      GroupBox2.Visible:=false;
      GroupBox5.Visible:=true;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  inputModeSelect.Items.Add('Interval');
  inputModeSelect.Items.Add('Interval2');
  inputModeSelect.Items.Add('Classic');
end;

procedure TForm1.inputLoadDllClick(Sender: TObject);

begin
    LoadDLLDialog := TOpenDialog.Create(self);
    LoadDLLDialog.InitialDir := GetCurrentDir;
    LoadDLLDialog.Options := [ofFileMustExist];
    LoadDLLDialog.Filter := 'Dynamically Linked Libraries|*.dll';

    if LoadDLLDialog.Execute then
        begin
            dllHandler := LoadLibrary(PAnsiChar(LoadDLLDialog.Filename));
            if ( dllHandler <> 0 ) then
                begin
                    @dllFX := GetProcAddress(dllHandler, 'f1');
                    @dllDX := GetProcAddress(dllHandler, 'df1');
                    @dllFX_int := GetProcAddress(dllHandler, 'f1_int');
                    @dllDX_int := GetProcAddress(dllHandler, 'df1_int');
                end
            else
                ShowMessage('Did not load file');
        end
    else
        ShowMessage('Loading file was cancelled');

    LoadDLLDialog.Free;

end;

procedure TForm1.inputLoadEntriesInt2Click(Sender: TObject);
begin
  n:=strToInt(inputEntriesInt2.Text);
  showEntriesInt2(n+1);
end;

end.
