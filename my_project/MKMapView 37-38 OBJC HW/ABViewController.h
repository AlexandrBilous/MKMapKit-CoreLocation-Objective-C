//
//  ABViewController.h
//  MKMapView 37-38 OBJC HW
//
//  Created by Marentilo on 18.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ABStudent.h"
#import "ABMeetupLocation.h"
#import "ABMeetupViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) MKMapView * map;
@property (strong, nonatomic) CLLocationManager * locationManager;
@property (strong, nonatomic) CLLocation * location;
@property (strong, nonatomic) NSArray * students;
@property (strong, nonatomic) ABMeetupLocation * meetup;

@property (strong, nonatomic) NSDictionary * dividedStudens;
@property (strong, nonatomic) UIView * infoView;
@property (weak, nonatomic) UILabel * lowPathLabel;
@property (weak, nonatomic) UILabel * mediumPathLabel;
@property (weak, nonatomic) UILabel * largePathLabel;
@property (weak, nonatomic) UILabel * tooLargePathLabel;
@property (strong, nonatomic) NSArray * randomStudents;


@end

NS_ASSUME_NONNULL_END
