//
//  FirstViewController.m
//  WorkoutSelection
//
//  Created by Bryan Cam on 11/17/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "WorkoutTableViewController.h"
#import <Parse/Parse.h>



@interface FirstViewController ()

@end

@implementation FirstViewController {
    NSArray *tableData;
    NSArray *workoutResults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self queryAbs:self];
    _firstWorkouts = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"secondView"])
    {
        SecondViewController *d = (SecondViewController *)segue.destinationViewController;
        d.muscleChosen = _muscle;
        d.workoutName = _workoutName;
        //workoutResults = _firstWorkouts;
        //d.workouts = workoutResults.mutableCopy;
    }
    else if ([[segue identifier] isEqualToString:@"workoutSelected"]){
        WorkoutTableViewController *vc = [segue destinationViewController];
        vc.workoutId = _objectId;
        vc.workoutName = _workoutName;
    }
    
    
     
}

- (void)queryAbs:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Workout"];
    [query whereKey:@"MuscleGroup" equalTo:@"abs"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            tableData = objects;
            // Do something with the found objects
            for (PFObject *object in objects) {
                
                NSString *playerName = object[@"workoutName"];
                [_firstWorkouts addObject:playerName];
                
            }
            
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}
- (void)queryMuscle:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Workout"];
    [query whereKey:@"MuscleGroup" equalTo:_muscle];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            tableData = objects;
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSString *playerName = object[@"workoutName"];
                [_firstWorkouts addObject:playerName];
            }
            
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

- (void)muscle:(id)sender {
    
    UIButton *buttonPressed = (UIButton *)sender;
    _muscle = buttonPressed.titleLabel.text;
    //[self queryMuscle:self];
    [self performSegueWithIdentifier:@"secondView" sender:self];
}

- (IBAction)selectWorkout :(id)sender {
    //[self queryAbs:self];
        [self performSegueWithIdentifier:@"workoutSelected" sender:self];
}


@end
