//
//  DeclaredAgeRangeObjCWrapper.h
//  DeclaredAgeRangeObjC
//
//  Created by Chris Pimlott on 18/12/2025.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeclaredAgeRangeResponseWrapper : NSObject
@property (nonatomic) NSInteger resultCode;
@property (nonatomic) BOOL sharingDeclined;
@property (nonatomic) NSInteger lowerBound;
@property (nonatomic) NSInteger upperBound;
@property (nonatomic) NSInteger ageRangeDeclaration;
@property (nonatomic) BOOL communicationLimits;
@property (nonatomic) BOOL significantAppChangeApprovalRequired;
@property (nonatomic) BOOL isEligibleForAgeFeatures;
- (nonnull instancetype)init;
@end

API_AVAILABLE(ios(26.0))
@interface DeclaredAgeRangeObjCWrapper : NSObject

+ (void)fetchAgeRangeWithMinimumAge:(NSInteger)minimumAge
                        maximumAge:(NSInteger)maximumAge
                     viewController:(UIViewController *)vc
                         completion:(void (^)(NSObject* _Nullable response, NSError* _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
