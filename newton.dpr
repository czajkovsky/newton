program newton;

uses
  Forms,
  main in 'main.pas' {Form1},
  nwtnpas in 'nwtnpas.pas',
  IntervalArithmetic in 'intervalarithmetic.pas',
  nwtsys in 'nwtsys.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
