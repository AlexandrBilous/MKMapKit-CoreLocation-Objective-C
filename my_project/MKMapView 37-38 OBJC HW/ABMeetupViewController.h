//
//  ABMeetupViewController.h
//  MKMapView 37-38 OBJC HW
//
//  Created by Marentilo on 19.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ABMeetupViewController : UITableViewController

- (instancetype)initWithLocation: (CLLocation*) location andUsersCount: (NSInteger) usersCount;


@property (strong, nonatomic) CLLocation* location;
@property (strong, nonatomic) CLGeocoder * geocoder;
@property (strong, nonatomic) CLPlacemark * placemark;
@property (strong, nonatomic) NSArray * tableViewSource;
@property (assign, nonatomic) NSInteger usersCount;

@property (strong, nonatomic) NSString * neearestPoint;
@property (strong, nonatomic) NSString * country;
@property (strong, nonatomic) NSString * street;
@property (strong, nonatomic) NSString * city;


@end


