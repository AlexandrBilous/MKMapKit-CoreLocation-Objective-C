//
//  ABStudentViewController.h
//  MKMapView 37-38 OBJC HW
//
//  Created by Marentilo on 18.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABStudent.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABStudentViewController : UIViewController <UITableViewDataSource>

- (instancetype)initWithStudent: (ABStudent*) student;

@property (strong, nonatomic) ABStudent * student;
@property (strong, nonatomic) CLGeocoder * geocoder;
@property (strong, nonatomic) CLPlacemark * placemark;



@end

NS_ASSUME_NONNULL_END
