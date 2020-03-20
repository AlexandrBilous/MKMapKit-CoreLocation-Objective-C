//
//  ABStudentViewController.m
//  MKMapView 37-38 OBJC HW
//
//  Created by Marentilo on 18.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import "ABStudentViewController.h"

@interface ABStudentViewController ()

@property (strong, nonatomic) NSArray * array;

@end

@implementation ABStudentViewController

- (instancetype)initWithStudent: (ABStudent*) student {
    self = [super init];
    if (self) {
        self.student = student;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self createPlaceMarkForStudent];

    
    [self setupView];
}

- (void) setupView {
    _array = [NSArray arrayWithObjects:@"Name", @"Last Name", @"Gender", @"Date of Birth", @"Country", @"Country Code", @"City", @"Street", nil];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, 300, 400) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) createPlaceMarkForStudent {

}

- (NSString*) valueForCellAtIndex: (NSInteger) index {
    NSString * result;
        
    switch (index) {
        case 0:
            result = _student.firstName;
            break;
        case 1:
            result = _student.lastName;
            break;
        case 2:
            result = _student.sex == ABStudentSexMale ? @"Male" : @"Female";
            break;
        case 3:
            result = [_student dayOfBirth];
            break;
        case 4:
            result = _student.country;
            break;
        case 5:
            result = _student.countryCode;
            break;
        case 6:
            result = _student.city;
            break;
        case 7:
            result = _student.street;
            break;
        default:
            result = @"nil";
            break;
    }
    
    return result;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"id"];
    }
    
    cell.textLabel.text = [_array objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.text = [self valueForCellAtIndex:indexPath.row];
    
//    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 100, 40)];
//    label.text = [self valueForCellAtIndex:indexPath.row];
//
//    [cell.contentView addSubview:label];
    
    return cell;
}

@end
