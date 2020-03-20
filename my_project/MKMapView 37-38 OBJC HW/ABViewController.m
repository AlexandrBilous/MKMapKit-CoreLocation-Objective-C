//
//  ABViewController.m
//  MKMapView 37-38 OBJC HW
//
//  Created by Marentilo on 18.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import "ABViewController.h"
#import "ABStudentViewController.h"
#import "UIView+MKAnnotationView.h"

@interface ABViewController ()


@end

@implementation ABViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void) setupView {
    self.navigationItem.title = @"MapKit";
    
    UIBarButtonItem * addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action: @selector(addButtonPressed:)];
    
    UIBarButtonItem * zoomButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(zoomButtonPressed:)];
    
    self.navigationItem.rightBarButtonItems = @[zoomButton, addButton];
    
    UIBarButtonItem * meetupButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action: @selector(meetupButtonPressed:)];
    UIBarButtonItem * pathButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action: @selector(pathButtonPressed:)];
    
    UIBarButtonItem * refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonPressed:)];
    self.navigationItem.leftBarButtonItems = @[meetupButton, pathButton, refreshItem];

    
    [self createStatusView];
    [self loadLocation];
    [self loadMap];
    [self createStudents];
}

- (void) createStatusView {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(20, 80, 310, 210)];
    
    view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.7];
    UILabel * label1 = [[UILabel alloc] initWithFrame: CGRectMake(10, 10, 280, 50)];
    label1.text = @"Count of students in 1000 radius:";
    UILabel * label2 = [[UILabel alloc] initWithFrame: CGRectMake(10, 60, 280, 50)];
    label2.text = @"Count of students in 5000 radius:";
    UILabel * label3 = [[UILabel alloc] initWithFrame: CGRectMake(10, 110, 280, 50)];
    label3.text = @"Count of students in <10000 radius:";
    
    UILabel * label7 = [[UILabel alloc] initWithFrame: CGRectMake(10, 160, 280, 50)];
    label7.text = @"Count of students in 10000+ radius:";
    
    UILabel * label4 = [[UILabel alloc] initWithFrame: CGRectMake(290, 10, 20, 50)];
    label4.text = @"0";
    UILabel * label5 = [[UILabel alloc] initWithFrame: CGRectMake(290, 60, 20, 50)];
    label5.text = @"0";
    UILabel * label6 = [[UILabel alloc] initWithFrame: CGRectMake(290, 110, 20, 50)];
    label6.text = @"0";
    UILabel * label8 = [[UILabel alloc] initWithFrame: CGRectMake(290, 160, 20, 50)];
    label8.text = @"0";
    
    [view addSubview:label1];
    [view addSubview:label2];
    [view addSubview:label3];
    [view addSubview:label8];

    [view addSubview:label4];
    [view addSubview:label5];
    [view addSubview:label6];
    [view addSubview:label7];
    
    _lowPathLabel = label4;
    _mediumPathLabel = label5;
    _largePathLabel = label6;
    _tooLargePathLabel = label8;
    
    _infoView = view;
}

- (void) loadMap {
    MKMapView * mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _map = mapView;
    _map.delegate = self;
    _map.showsUserLocation = YES;

    [self.view addSubview:mapView];
}

- (void) loadLocation {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    [_locationManager requestAlwaysAuthorization];
    [_locationManager startUpdatingLocation];
}

- (void) createStudents {
    NSMutableArray * tmp = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        ABStudent * student = [[ABStudent alloc] init];
        [student setupRandomSettingsForStudent];
        [self createLocationForStudent:student];
        
        [tmp addObject:student];
    }
    
    _students = tmp;
    [_map showAnnotations:_students animated:YES];
}

- (void) createLocationForStudent: (ABStudent*) student {
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    
    CLLocation * location = [[CLLocation alloc] initWithLatitude: student.coordinate.latitude longitude:student.coordinate.longitude];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * placemarks, NSError * error) {
        if (error) {
            NSLog(@"Error");
        } else {
            if (placemarks.count > 0) {
                CLPlacemark* placemark = [placemarks lastObject];
                student.city = placemark.locality;
                student.countryCode = placemark.ISOcountryCode;
                student.country = placemark.country;
                student.street = placemark.thoroughfare;
            } else {
                NSLog(@"Error");
            }
        }
    }];
    
}

- (void) showCircleRaduis {
    
    MKCircle * cirle1 = [MKCircle circleWithCenterCoordinate: _meetup.coordinate radius:1000.0];
    MKCircle * cirle2 = [MKCircle circleWithCenterCoordinate: _meetup.coordinate radius:5000.0];
    MKCircle * cirle3 = [MKCircle circleWithCenterCoordinate: _meetup.coordinate radius:10000.0];
    
    _meetup.radiusCircles = @[cirle1, cirle2, cirle3];
    [_map addOverlays:_meetup.radiusCircles];
}

- (BOOL) willDisplayOverlayAtMap: (CLLocationDistance) distance {
    if (distance <= 1000) {
        return arc4random() % 1001 < 9001;
    } else if (distance > 1000 && distance <= 5000) {
        return arc4random() % 1001 < 501;
    } else if (distance < 10000){
        return arc4random() % 1001 < 201;
    } else {
        return arc4random() % 1001 > 101;
    }
    
    return YES;
}

- (void) changeTitlesForLabels {
    _dividedStudens = [self.meetup devideStudentsAccordingToPath:_students];

    _lowPathLabel.text = [NSString stringWithFormat:@"%d", [[_dividedStudens objectForKey:@"1000"] count]];
    _mediumPathLabel.text = [NSString stringWithFormat:@"%d", [[_dividedStudens objectForKey:@"5000"] count]];
    _largePathLabel.text = [NSString stringWithFormat:@"%d", [[_dividedStudens objectForKey:@"10000"] count]];
    _tooLargePathLabel.text = [NSString stringWithFormat:@"%d", [[_dividedStudens objectForKey:@"10000+"] count]];

    
    NSLog(@"%@", _lowPathLabel.text);
    NSLog(@"%@", _mediumPathLabel.text);
}

- (NSArray*) randomStudentsOnEvent {
    NSMutableArray * tmp = [NSMutableArray array];
    
    for (ABStudent * student in _students) {
        if ([self willDisplayOverlayAtMap:student.distance]) {
            [tmp addObject:student];
        }
    }
    
    return tmp;
}


#pragma mark - Actions


- (void) meetupButtonPressed: (UIButton*) sender {
    
    if (_meetup == nil) {
        CLLocationCoordinate2D coordinate = [_map centerCoordinate];
        ABMeetupLocation * meetUp = [[ABMeetupLocation alloc] initWithCoordinate: coordinate];
        [meetUp setupTitileAndSubtitle];
        _meetup = meetUp;
            
        [_map showAnnotations:[_students arrayByAddingObject:_meetup] animated:YES];
        [self showCircleRaduis];
        
        [self.meetup devideStudentsAccordingToPath:_students];
        [self.view addSubview:_infoView];
        [self changeTitlesForLabels];
    }

}

- (void) meetupInfoButtonPressed: (UIButton*) sender {
    if ([[[sender superAnnotationView] annotation] isKindOfClass:[ABMeetupLocation class]]) {
        ABMeetupLocation * source = (ABMeetupLocation*) [[sender superAnnotationView] annotation];
        CLLocation * location = [[CLLocation alloc] initWithLatitude:source.coordinate.latitude longitude:source.coordinate.longitude];
        
        if (_randomStudents.count == 0) {
            _randomStudents = [self randomStudentsOnEvent];

        }

        ABMeetupViewController * viewController = [[ABMeetupViewController alloc] initWithLocation:location andUsersCount:[_randomStudents count]];
        
        viewController.modalPresentationStyle = UIModalPresentationPopover;
        viewController.preferredContentSize = CGSizeMake(300, 400);
        
        UIPopoverPresentationController * popover = viewController.popoverPresentationController;
        popover.delegate = self;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        popover.sourceRect = sender.frame;
        popover.sourceView = sender;
        
        [self presentViewController:viewController animated:YES completion:nil];
    }
}


- (void) pathButtonPressed: (UIButton*) sender {
    
    if ([_randomStudents count] == 0) {
        _randomStudents = [self randomStudentsOnEvent];
    }
    
    [_map removeOverlays:_map.overlays];
    [self showCircleRaduis];
    
    CLLocation * location = [[CLLocation alloc] initWithLatitude: _meetup.coordinate.latitude longitude:_meetup.coordinate.longitude];
    MKDirectionsRequest * request = [[MKDirectionsRequest alloc] init];
    request.source = [[MKMapItem alloc] initWithPlacemark: [[MKPlacemark alloc] initWithCoordinate:_meetup.coordinate]];
    
    for (ABStudent* item in _randomStudents) {
        MKPlacemark * placemark = [[MKPlacemark alloc] initWithCoordinate:item.coordinate];
        MKMapItem * destination = [[MKMapItem alloc] initWithPlacemark:placemark];
        
        request.destination = destination;
        request.transportType = MKDirectionsTransportTypeAutomobile;
        
        MKDirections * directions = [[MKDirections alloc] initWithRequest:request];
        
        [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
            NSString * message;
            if (error) {
                message = [error description];
                NSLog(@"%@", message);
            } else {
                if (response.routes.count == 0) {
                        message = @"No routes found";
                } else {
                    NSLog(@"%@", response.routes.firstObject.polyline);
                    [self.map addOverlays:@[response.routes.firstObject.polyline]];
                }
            }
        }];
    }
}

- (void) refreshButtonPressed: (UIBarButtonItem*) sender {
    
    [_map removeAnnotation:_meetup];
    _meetup = nil;
    
    [_infoView removeFromSuperview];
    [_map removeOverlays:_map.overlays];
}

- (void) infoButtonPressed: (UIButton*) sender {
    
    if ([[[sender superAnnotationView] annotation] isKindOfClass:[ABStudent class]]) {
        ABStudent * source = (ABStudent*) [[sender superAnnotationView] annotation];
        ABStudentViewController * viewController = [[ABStudentViewController alloc] initWithStudent: source];
        viewController.modalPresentationStyle = UIModalPresentationPopover;
        viewController.preferredContentSize = CGSizeMake(300, 400);

        
        UIPopoverPresentationController * popover = viewController.popoverPresentationController;
        popover.delegate = self;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        popover.sourceRect = sender.frame;
        popover.sourceView = sender;
        
        [self presentViewController:viewController animated:YES completion:nil];
    }

}


- (void) addButtonPressed: (UIBarButtonItem*) sender {
    ABStudent * student = [[ABStudent alloc] init];
    [student setupRandomSettingsForStudent];
    [self createLocationForStudent:student];

    NSMutableArray * array = [NSMutableArray arrayWithArray:_students];
    [array addObject:student];
    _students = array;
    
    [self changeTitlesForLabels];
    [_map showAnnotations:array animated:YES];
}

- (void) zoomButtonPressed: (UIBarButtonItem*) sender {
    
    MKMapRect result = MKMapRectNull;
    
    for (id<MKAnnotation> item in _map.annotations) {
        CLLocationCoordinate2D coordinate = item.coordinate;
        
        MKMapPoint center = MKMapPointForCoordinate(coordinate);
        MKMapRect rect = MKMapRectMake(center.x - 10000, center.y - 10000, 20000, 20000);
        
        result = MKMapRectUnion(result, rect);
    }

    [_map setVisibleMapRect:result edgePadding:UIEdgeInsetsMake(30, 30, 30, 30) animated:YES];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(nullable CLRegion *)region withError:(NSError *) error {
    NSLog(@"%@", error.description);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [_locationManager requestAlwaysAuthorization];
    [_locationManager startUpdatingLocation];
    _location = [locations lastObject];
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"Okey");
    if (status == kCLAuthorizationStatusNotDetermined || status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
       NSLog(@"Error");
    }
}

#pragma mark - MKMapViewDelegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
  
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer * render = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        render.lineWidth = 4.f;
        render.strokeColor = render.polyline.pointCount < 150 ? UIColor.greenColor : render.polyline.pointCount < 220 ? UIColor.yellowColor : UIColor.redColor;
        return render;
    }
    
    if ([overlay isKindOfClass:[MKCircle class]])  {

        MKCircleRenderer * render = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        render.fillColor = [UIColor colorWithDisplayP3Red:0.5 green:0.5 blue:0.5 alpha:0.2];
        render.strokeColor = [UIColor colorWithDisplayP3Red:0.5 green:0.5 blue:0.5 alpha:0.2];
        return render;
    }

    return nil;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString * identifier = @"id";
    MKAnnotationView * annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!annotationView) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    
    if ([annotation isKindOfClass:[ABStudent class]]){
        
        ABStudent * source = (ABStudent*) annotation;
        annotationView.image = source.sex  == ABStudentSexMale ?  [UIImage imageNamed:@"3.png"] : [UIImage imageNamed:@"4.png"];
        UIButton * infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [infoButton addTarget:self action:@selector(infoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        annotationView.rightCalloutAccessoryView = infoButton;

    } else if ([annotation isKindOfClass:[ABMeetupLocation class]]){
        annotationView.image = [UIImage imageNamed:@"pin.png"];
        annotationView.draggable = YES;
        UIButton * pathButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [pathButton addTarget:self action:@selector(meetupInfoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        annotationView.rightCalloutAccessoryView = pathButton;
    }
    
    annotationView.canShowCallout = YES;
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState {
    
    if (newState == MKAnnotationViewDragStateStarting && [_meetup.radiusCircles count] > 0){
         [_map removeOverlays:_map.overlays];
    }
    
    if (newState == MKAnnotationViewDragStateEnding) {
        UIAlertController * controller = [UIAlertController alertControllerWithTitle:@"Ulalala location has changes!" message:@"We must notify students." preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction: [UIAlertAction actionWithTitle:@"I've got it!" style:UIAlertActionStyleCancel handler:nil]];
        
        
        [(ABMeetupLocation*) view.annotation setupTitileAndSubtitle];
        [self changeTitlesForLabels];
        [self showCircleRaduis];
        [self.meetup devideStudentsAccordingToPath:_students];
        
        [self presentViewController:controller animated:YES completion:nil];
    }
        
}

#pragma mark - UIPopoverDelegate

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController * ) controller {
    return UIModalPresentationNone;
}

@end
