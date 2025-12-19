program DeclaredAgeRangeDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Main in 'View.Main.pas' {Form1},
  iOSapi.DeclaredAgeRangeObjC in 'Frameworks\iOSapi.DeclaredAgeRangeObjC.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
