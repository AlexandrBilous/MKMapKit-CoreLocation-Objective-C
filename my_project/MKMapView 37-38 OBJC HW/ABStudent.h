//
//  ABStudent.h
//  MKMapView 37-38 OBJC HW
//
//  Created by Marentilo on 18.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    ABStudentSexMale,
    ABStudentSexFamale
} ABStudentSex;

@interface ABStudent : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (assign, nonatomic) CLLocationDistance distance;

@property (strong, nonatomic) NSString * firstName;
@property (strong, nonatomic) NSString * lastName;
@property (strong, nonatomic) NSDate * dateOfBirth;
@property (assign, nonatomic) ABStudentSex sex;

@property (strong, nonatomic) NSString * countryCode;
@property (strong, nonatomic) NSString * country;
@property (strong, nonatomic) NSString * street;
@property (strong, nonatomic) NSString * city;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (void) setupRandomSettingsForStudent;
- (NSString*) dayOfBirth;

@end

NS_ASSUME_NONNULL_END
