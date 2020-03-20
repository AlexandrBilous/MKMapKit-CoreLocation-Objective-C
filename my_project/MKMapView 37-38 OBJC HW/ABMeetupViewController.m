//
//  ABMeetupViewController.m
//  MKMapView 37-38 OBJC HW
//
//  Created by Marentilo on 19.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import "ABMeetupViewController.h"

@interface ABMeetupViewController ()

@property (strong, nonatomic) NSDate * dateOfEvent;
@property (strong, nonatomic) NSString * stringForDateEvent;
@property (strong, nonatomic) NSString * stringForTimeEvent;

@end

@implementation ABMeetupViewController

- (instancetype)initWithLocation:(CLLocation *)location andUsersCount: (NSInteger) usersCount {
    self = [super init];
    if (self) {
        self.location = location;
        self.usersCount = usersCount;
        
            [self setLocationOfMeetup];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.dateOfEvent = [NSDate dateWithTimeIntervalSinceNow: arc4random() % 30 * 60 * 60 * 24];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.calendar = [NSCalendar currentCalendar];
    
    formatter.dateFormat = @"dd-MMM-YYYY";
    _stringForDateEvent = [formatter stringFromDate: _dateOfEvent];
    
    formatter.dateFormat = @"HH-mm";
    _stringForTimeEvent = [formatter stringFromDate: _dateOfEvent];
    
    
    self.tableViewSource = [NSArray arrayWithObjects: @"Theme", @"Count of users", @"Date", @"Time", @"Country", @"City", @"Street", @"Nearest point", nil];
}

- (void) setLocationOfMeetup {
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:_location completionHandler:^(NSArray<CLPlacemark *> * placemarks, NSError * error) {
        if (error) {
            NSLog(@"Error");
        } else {
            if (placemarks.count > 0) {
                CLPlacemark* placemark = [placemarks lastObject];
                self.city = placemark.locality;
                self.country = placemark.country;
                self.street = placemark.thoroughfare;
                self.neearestPoint = placemark.areasOfInterest == nil ? @"Can't find location" : placemark.areasOfInterest.lastObject;
            } else {
                NSLog(@"Error");
            }
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tableViewSource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id"];
    }
    
    cell.textLabel.text = [_tableViewSource objectAtIndex: indexPath.row];
    
    switch (indexPath.row) {
        case 0:
            cell.detailTextLabel.text = @"iOS Dev Meetup";
            break;
        case 1:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", _usersCount];
            break;
        case 2:
            cell.detailTextLabel.text = _stringForDateEvent;
            break;
        case 3:
            cell.detailTextLabel.text = _stringForTimeEvent;
            break;
        case 4:
            cell.detailTextLabel.text = _country;
            break;
        case 5:
            cell.detailTextLabel.text = _city;
            break;
        case 6:
            cell.detailTextLabel.text = _street;
            break;
        case 7:
            cell.detailTextLabel.text = _neearestPoint;
            break;
        default:
            break;
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
