//
//  ABMeetupLocation.m
//  MKMapView 37-38 OBJC HW
//
//  Created by Marentilo on 18.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import "ABMeetupLocation.h"

@implementation ABMeetupLocation

- (instancetype) initWithCoordinate:(CLLocationCoordinate2D) coordinate {
    self = [super init];
    if (self) {
        self.coordinate = coordinate;
    }
    return self;
}

- (NSDictionary*) devideStudentsAccordingToPath: (NSArray*) students  {
    
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    NSMutableArray * lowPath = [NSMutableArray array];
    NSMutableArray * mediumPath = [NSMutableArray array];
    NSMutableArray * largePath = [NSMutableArray array];
    NSMutableArray * tooLargePath = [NSMutableArray array];
    
    CLLocation * location = [[CLLocation alloc] initWithLatitude:_coordinate.latitude longitude:_coordinate.longitude];
    
    for (ABStudent * item in students) {
        
        CLLocation * itemLocation = [[CLLocation alloc] initWithLatitude: item.coordinate.latitude longitude:item.coordinate.longitude];
        CLLocationDistance distance = [location distanceFromLocation: itemLocation];
        
        item.distance = distance;
        
        if (distance <= 1000) {
            [lowPath addObject:item];
        } else if (distance > 1000 && distance <= 5000) {
            [mediumPath addObject:item];
        } else if (distance < 10000){
            [largePath addObject:item];
        } else {
            [tooLargePath addObject:item];
        }
                
    }
    
    [dictionary setObject:lowPath forKey:@"1000"];
    [dictionary setObject:mediumPath forKey:@"5000"];
    [dictionary setObject:largePath forKey:@"10000"];
    [dictionary setObject:tooLargePath forKey:@"10000+"];
    
    NSLog(@"%@", [dictionary description]);
    
    return dictionary;
}




- (void) setupTitileAndSubtitle {
    CLLocation * clLocation = [[CLLocation alloc] initWithLatitude:_coordinate.latitude longitude:_coordinate.longitude];
     CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:clLocation completionHandler:^(NSArray<CLPlacemark *> * placemarks, NSError * error) {
        NSString* message = nil;
        if (error) {
            message = [error localizedDescription];
        } else {
            if (placemarks.count > 0) {
                CLPlacemark * mark = [placemarks lastObject];
                self.title = [NSString stringWithFormat:@"%@, %@, %@", mark.ISOcountryCode ,mark.country, mark.locality];
                self.subtitle = [NSString stringWithFormat:@"%@, %@", mark.thoroughfare, mark.subThoroughfare];
                message = [mark.addressDictionary description];
            } else {
                message = @"No Placemarks found!";
            }
        }
        NSLog(@"message");
    }];
}

@end
