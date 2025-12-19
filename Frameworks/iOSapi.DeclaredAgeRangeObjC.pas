
unit iOSapi.DeclaredAgeRangeObjC;

interface

uses
  Macapi.ObjectiveC, Macapi.CoreFoundation, iOSapi.CocoaTypes, iOSapi.Foundation, iOSapi.UIKit;

type
  DeclaredAgeRangeResponseWrapper = interface;
  DeclaredAgeRangeObjCWrapper = interface;

  TDeclaredAgeRangeObjCWrapperBlockMethod1 = procedure(response: NSObject; error: NSError) of object;

  DeclaredAgeRangeResponseWrapperClass = interface(NSObjectClass)
    ['{0505AB68-496D-4362-9542-2E3D09A10745}']
  end;

  DeclaredAgeRangeResponseWrapper = interface(NSObject)
    ['{71253D27-EE45-4B30-99A0-56318E66F93A}']
    function ageRangeDeclaration: NSInteger; cdecl;
    function communicationLimits: Boolean; cdecl;
    function isEligibleForAgeFeatures: Boolean; cdecl;
    function lowerBound: NSInteger; cdecl;
    function resultCode: NSInteger; cdecl;
    procedure setAgeRangeDeclaration(ageRangeDeclaration: NSInteger); cdecl;
    procedure setCommunicationLimits(communicationLimits: Boolean); cdecl;
    procedure setIsEligibleForAgeFeatures(isEligibleForAgeFeatures: Boolean); cdecl;
    procedure setLowerBound(lowerBound: NSInteger); cdecl;
    procedure setResultCode(resultCode: NSInteger); cdecl;
    procedure setSharingDeclined(sharingDeclined: Boolean); cdecl;
    procedure setSignificantAppChangeApprovalRequired(significantAppChangeApprovalRequired: Boolean); cdecl;
    procedure setUpperBound(upperBound: NSInteger); cdecl;
    function sharingDeclined: Boolean; cdecl;
    function significantAppChangeApprovalRequired: Boolean; cdecl;
    function upperBound: NSInteger; cdecl;
  end;
  TDeclaredAgeRangeResponseWrapper = class(TOCGenericImport<DeclaredAgeRangeResponseWrapperClass, DeclaredAgeRangeResponseWrapper>) end;

  DeclaredAgeRangeObjCWrapperClass = interface(NSObjectClass)
    ['{93CD1503-6A5D-430C-9B1D-73DFD68A704A}']
    {class} procedure fetchAgeRangeWithMinimumAge(minimumAge: NSInteger; maximumAge: NSInteger; viewController: UIViewController; completion: TDeclaredAgeRangeObjCWrapperBlockMethod1); cdecl;
  end;

  DeclaredAgeRangeObjCWrapper = interface(NSObject)
    ['{D67338FE-D6F2-4C33-905E-E317A5C7CDED}']
  end;
  TDeclaredAgeRangeObjCWrapper = class(TOCGenericImport<DeclaredAgeRangeObjCWrapperClass, DeclaredAgeRangeObjCWrapper>) end;

implementation

procedure DeclaredAgeRangeObjC; cdecl; external framework 'DeclaredAgeRangeObjC';

end.