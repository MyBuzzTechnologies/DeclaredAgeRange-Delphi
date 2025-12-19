unit View.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Skia, FMX.Edit, FMX.EditBox, FMX.NumberBox, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Layouts, FMX.Skia,
  iOSapi.Foundation,
  iOSapi.DeclaredAgeRangeObjC, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TForm1 = class(TForm)
    SkLabel1: TSkLabel;
    Layout1: TLayout;
    btnCheck: TButton;
    Layout2: TLayout;
    SkLabel2: TSkLabel;
    editMinAge: TNumberBox;
    MemoLog: TMemo;
    procedure btnCheckClick(Sender: TObject);
  private
    function  DeclaredAgeDeclarations(const AValue: Integer): String;
    procedure FetchAgeRangeCompletionHandler(response: NSObject; error: NSError);
    procedure LogMsg(const msg: String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  DW.iOSapi.Helpers, iOSapi.Helpers, Macapi.Helpers;

{$R *.fmx}

procedure TForm1.btnCheckClick(Sender: TObject);
begin
  MemoLog.Lines.Clear;
  if TOSVersion.Check(26) then
  begin
    TDeclaredAgeRangeObjCWrapper.OCClass.fetchAgeRangeWithMinimumAge(
      Trunc(editMinAge.Value),
      Trunc(editMinAge.Value),
      TiOSHelperEx.SharedApplication.keyWindow.rootViewController,
      FetchAgeRangeCompletionHandler
    );
  end
  else
    LogMsg('Not support. Requires iOS 26.0+');
end;

function TForm1.DeclaredAgeDeclarations(const AValue: Integer): String;
begin
  case AValue of
  0: Result:='None';
  1: Result:='SelfDeclared';
  2: Result:='GuardianDeclared';
  3: Result:='CheckByOtherMethod';
  4: Result:='guardianCheckedByOtherMethod';
  5: Result:='governmentIDChecked';
  6: Result:='guardianGovernmentIDChecked';
  7: Result:='paymentChecked';
  8: Result:='guardianPaymentChecked';
  else
    Result:='None';
  end;
end;

procedure TForm1.FetchAgeRangeCompletionHandler(response: NSObject; error: NSError);
  var
    resp: DeclaredAgeRangeResponseWrapper;
begin
  if (error <> nil) then
    LogMsg(NSStrToStr(error.localizedDescription))
  else
  begin
    try
      LogMsg('Response Received');
      resp:=TDeclaredAgeRangeResponseWrapper.Wrap(response);
      LogMsg('ResultCode: '+resp.resultCode.ToString);
      LogMsg('EligibleForAgeFeatures='+resp.isEligibleForAgeFeatures.ToString);
      LogMsg('Lower Age: '+resp.lowerBound.ToString);
      LogMsg('Upper Age: '+resp.upperBound.ToString);
      LogMsg('Declaration: '+DeclaredAgeDeclarations(resp.ageRangeDeclaration));
      LogMsg('CommsLimits: '+resp.communicationLimits.ToString);
      LogMsg('SignificantChangeApprovalRequired: '+resp.significantAppChangeApprovalRequired.ToString);
      LogMsg('SharingDeclined: '+resp.sharingDeclined.ToString);
    except
      on E: Exception do
        LogMsg(E.Message);
    end;
  end;
end;

procedure TForm1.LogMsg(const msg: String);
begin
  MemoLog.Lines.Add(msg);
end;

end.
