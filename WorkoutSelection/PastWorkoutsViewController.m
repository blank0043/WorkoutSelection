//
//  PastWorkoutsViewController.m
//  WorkoutSelection
//
//  Created by Bryan Cam on 12/2/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import "PastWorkoutsViewController.h"
#import <Parse/Parse.h>

@interface PastWorkoutsViewController ()

@end

@implementation PastWorkoutsViewController

@synthesize mainTableView;

@synthesize taskNames;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _workoutData = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"PastWorkouts"];
    //changeprimarykey to _objectId
    [query whereKey:@"user" equalTo:[PFUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            
            
            // Do something with the found objects
            for (PFObject *object in objects) {
                [_workoutData addObject:object[@"taskName"]];
                [_workoutData addObject:object[@"Sets"]];
                [_workoutData addObject:object[@"Reps"]];
                [_workoutData addObject:object[@"weight"]];
               
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSString *date = [dateFormatter stringFromDate:object.updatedAt];
                
                [_workoutData addObject:date];
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
    return [_workoutData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"workouts";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [_workoutData objectAtIndex:indexPath.row];
    return cell;
}




@end
