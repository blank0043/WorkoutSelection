//
//  WorkoutTableViewController.m
//  WorkoutSelection
//
//  Created by Bryan Cam on 11/19/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import "WorkoutTableViewController.h"
#import "ActivitiesViewController.h"
#import <Parse/Parse.h>

@interface WorkoutTableViewController ()

@end

@implementation WorkoutTableViewController {
    NSArray *tableData;
    
}

@synthesize mainTableView;

@synthesize taskNames;
@synthesize targetLatitudes;
@synthesize targetLongitudes;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    taskNames = [[NSMutableArray alloc] init];
    targetLatitudes = [[NSMutableArray alloc] init];
    targetLongitudes = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view.
    PFQuery *query = [PFQuery queryWithClassName:@"Activities"];
    //changeprimarykey to _objectId
//    [query whereKey:@"workoutName" equalTo:_workoutName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            
            tableData = objects;
            // Do something with the found objects
            for (PFObject *object in objects) {
                
                NSString *taskName = object[@"TaskName"];
                [taskNames addObject:taskName];
                
                NSNumber *latitude = object[@"Latitude"];
                [targetLatitudes addObject:latitude];
                
                NSNumber *longitude = object[@"Longitude"];
                [targetLongitudes addObject:longitude];
                [mainTableView reloadData];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [mainTableView reloadData];
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [mainTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [taskNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"workouts";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [taskNames objectAtIndex:indexPath.row];
    
    return cell;
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _individualTaskName = [taskNames objectAtIndex:indexPath.row];
    _targetLatitude = [targetLatitudes objectAtIndex:indexPath.row];
    _targetLongitude = [targetLongitudes objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"detail" sender:self];
}

- (IBAction)beginWorkout :(id)sender {
    [self performSegueWithIdentifier:@"beginWorkout" sender:self];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"detail"]){
        
        ActivitiesViewController *vc = [segue destinationViewController];
        vc.taskName.text = _individualTaskName;
        vc.targetLatitude = _targetLatitude;
        vc.targetLongitude = _targetLongitude;
        vc.name = _individualTaskName;
        vc.userPoints = _userPoints;
        NSLog(@"%@", _individualTaskName);
        
    }
       
    
    
}


@end
