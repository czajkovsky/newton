program newton;

uses
  Forms,
  main in 'main.pas' {Form1},
  nwtnpas in 'nwtnpas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
