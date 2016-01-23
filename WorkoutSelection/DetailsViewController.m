//
//  DetailsViewController.m
//  WorkoutSelection
//
//  Created by Bryan Cam on 11/29/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import "DetailsViewController.h"
#import "WorkoutTableViewController.h"
#import <Parse/Parse.h>

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _instructions.text = _workoutInstructions;
    _taskName.text = _taskNameText;
    [_deleteWorkout setTitle:_shouldDelete forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteWorkout:(id)sender {
    if ([_shouldDelete isEqualToString:@"delete"]) {
        PFQuery *query = [PFQuery queryWithClassName:@"WorkoutCreated"];
        [query getObjectInBackgroundWithId:_workoutId block:^(PFObject *workout, NSError *error) {
            // Do something with the returned PFObject in the gameScore variable.
            if ([_taskNameText isEqualToString: workout[@"task1"]]) {
                workout[@"task1"] = @"";
                [workout saveInBackground];
            }
            else if ([_taskNameText isEqualToString: workout[@"task2"]]) {
                workout[@"task2"] = @"";
                [workout saveInBackground];
            }
            else if ([_taskNameText isEqualToString: workout[@"task3"]]) {
                workout[@"task3"] = @"";
                [workout saveInBackground];
            }
            else if ([_taskNameText isEqualToString: workout[@"task4"]]) {
                workout[@"task4"] = @"";
                [workout saveInBackground];
            }

        }];
        [self performSegueWithIdentifier:@"workouts" sender:self];
    }
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"workouts"]){
        
        WorkoutTableViewController *vc = [segue destinationViewController];
        vc.workoutId = _workoutId;
        vc.workoutName = _workoutName;
    }
}

@end
