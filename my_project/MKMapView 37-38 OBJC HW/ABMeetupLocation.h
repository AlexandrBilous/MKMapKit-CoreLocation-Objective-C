//
//  ABMeetupLocation.h
//  MKMapView 37-38 OBJC HW
//
//  Created by Marentilo on 18.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ABStudent.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABMeetupLocation : NSObject <MKAnnotation>

- (instancetype) initWithCoordinate:(CLLocationCoordinate2D) coordinate;


@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (strong, nonatomic) NSArray * radiusCircles;


- (void) setupTitileAndSubtitle;
- (NSDictionary*) devideStudentsAccordingToPath: (NSArray*) students;


@end

NS_ASSUME_NONNULL_END
