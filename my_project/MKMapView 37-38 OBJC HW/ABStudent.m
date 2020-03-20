//
//  ABStudent.m
//  MKMapView 37-38 OBJC HW
//
//  Created by Marentilo on 18.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import "ABStudent.h"

@implementation ABStudent


- (void) setupRandomSettingsForStudent {
    CLLocationCoordinate2D city = CLLocationCoordinate2DMake(50.50, 30.50);
    
    double randLatitude = (arc4random() % 11) / 100.0 * (arc4random() % 2 == 0 ? -1 : 1);
    double randLongtitude = (arc4random() % 11 ) / 100.0 * (arc4random() % 2 == 0 ? -1 : 1);
    
    NSLog(@"{%f, %F}", randLongtitude, randLongtitude);
    
    _coordinate = CLLocationCoordinate2DMake(city.latitude + randLatitude, city.longitude + randLongtitude);
    
    [self randomDate];
    [self randomNameAndLastName];
    
    _title = [NSString stringWithFormat:@"%@ %@", _lastName, _firstName];
    _subtitle = [self dayOfBirth];
}

- (void) randomNameAndLastName {
    NSArray * lastNames = [NSArray arrayWithObjects:@"Smith",@"Johnson",@"Williams",@"Brown",@"Jones",@"Miller",@"Davis",@"Garcia",@"Rodriguez",@"Wilson",@"Martinez",@"Anderson",@"Taylor",@"Thomas",@"Hernandez",@"Moore",@"Martin",@"Jackson",@"Thompson",@"White",@"Lopez",@"Lee",@"Gonzalez",@"Harris",@"Clark",@"Lewis",@"Robinson",@"Walker",@"Perez",@"Hall",@"Young",@"Allen",@"Sanchez",@"Wright",@"King",@"Scott",@"Green",@"Baker",@"Adams",@"Nelson",@"Hill",@"Ramirez",@"Campbell",@"Mitchell",@"Roberts",@"Carter",@"Phillips",@"Evans",@"Turner",@"Torres",@"Parker",@"Collins",@"Edwards",@"Stewart",@"Flores",@"Morris",@"Nguyen",@"Murphy",@"Rivera",@"Cook",@"Rogers",@"Morgan",@"Peterson",@"Cooper",@"Reed",@"Bailey",@"Bell",@"Gomez",@"Kelly",@"Howard",@"Ward",@"Cox",@"Diaz",@"Richardson",@"Wood",@"Watson",@"Brooks",@"Bennett",@"Gray",@"James",@"Reyes",@"Cruz",@"Hughes",@"Price",@"Myers",@"Long",@"Foster",@"Sanders",@"Ross",@"Morales",@"Powell",@"Sullivan",@"Russell",@"Ortiz",@"Jenkins",@"Gutierrez",@"Perry",@"Butler",@"Barnes",@"Fisher",@"Henderson",@"Coleman",@"Simmons",@"Patterson",@"Jordan",@"Reynolds",@"Hamilton",@"Graham",@"Kim",@"Gonzales",@"Alexander",@"Ramos",@"Wallace",@"Griffin",@"West",@"Cole",@"Hayes",@"Chavez",@"Gibson",@"Bryant",@"Ellis",@"Stevens",@"Murray",@"Ford",@"Marshall",@"Owens",@"McDonald",@"Harrison",@"Ruiz",@"Kennedy",@"Wells",@"Alvarez",@"Woods",@"Mendoza",@"Castillo",@"Olson",@"Webb",@"Washington",@"Tucker",@"Freeman",@"Burns",@"Henry",@"Vasquez",@"Snyder",@"Simpson",@"Crawford",@"Jimenez",@"Porter",@"Mason",@"Shaw",@"Gordon",@"Wagner",@"Hunter", nil];
    
    NSArray * firstNames = [NSArray arrayWithObjects:@"Emily",@"Hannah",@"Madison",@"Ashley",@"Sarah",@"Alexis",@"Samantha",@"Jessica",@"Elizabeth",@"Taylor",@"Lauren",@"Alyssa",@"Kayla",@"Abigail",@"Brianna",@"Olivia",@"Emma",@"Megan",@"Grace",@"Victoria",@"Rachel",@"Anna",@"Sydney",@"Destiny",@"Morgan",@"Jennifer",@"Jasmine",@"Haley",@"Julia",@"Kaitlyn",@"Nicole",@"Amanda",@"Katherine",@"Natalie",@"Hailey",@"Alexandra",@"Savannah",@"Chloe",@"Rebecca",@"Stephanie",@"Maria",@"Sophia",@"Mackenzie",@"Allison",@"Isabella",@"Amber",@"Mary",@"Danielle",@"Gabrielle",@"Jordan",@"Brooke",@"Michelle",@"Sierra",@"Katelyn",@"Andrea",@"Madeline",@"Sara",@"Kimberly",@"Courtney",@"Erin",@"Brittany",@"Vanessa",@"Jenna",@"Jacqueline",@"Caroline",@"Faith",@"Makayla",@"Bailey",@"Paige",@"Shelby",@"Melissa",@"Kaylee",@"Christina",@"Trinity",@"Mariah",@"Caitlin",@"Autumn",@"Marissa",@"Breanna",@"Angela", nil];
    
    NSInteger index1 = arc4random() % ([firstNames count] - 1);
    NSInteger index2 = arc4random() % ([lastNames count] - 1);

    _sex = arc4random() % 2;
    _firstName = [firstNames objectAtIndex:index1];
    _lastName = [lastNames objectAtIndex:index2];
}

- (void) randomDate {
    
    double randomInterval = arc4random() %  40 * 60 * 60 * 24 * 365;
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970: randomInterval];
    
    _dateOfBirth = date;
}

- (NSString*) dayOfBirth {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.calendar = NSCalendar.currentCalendar;
    formatter.dateFormat = @"dd-MMM-YYYY";

    return [formatter stringFromDate:_dateOfBirth];;
}

@end
