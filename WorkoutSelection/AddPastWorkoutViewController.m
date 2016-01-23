//
//  AddPastWorkoutViewController.m
//  WorkoutSelection
//
//  Created by Bryan Cam on 12/1/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import "AddPastWorkoutViewController.h"
#import "EditWorkoutDataViewController.h"
#import <Parse/Parse.h>
@interface AddPastWorkoutViewController ()

@end

@implementation AddPastWorkoutViewController


@synthesize mainTableView;

@synthesize taskNames;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    _individualTaskName = [taskNames objectAtIndex:indexPath.row];
    _workoutId = [workoutIds objectAtIndex:indexPath.row];
    NSLog(@"workout name is from didselect: %@", _individualTaskName);
    [self performSegueWithIdentifier:@"workoutInformation" sender:self];
    */
    int indexNameOfTask = (indexPath.row/4)*4;
    _nameOfTask = [_workoutData objectAtIndex: indexNameOfTask];
    _sets = [_workoutData objectAtIndex: indexNameOfTask + 1];
    _reps = [_workoutData objectAtIndex: indexNameOfTask + 2];
    _weight = [_workoutData objectAtIndex: indexNameOfTask + 3];
    _row = indexNameOfTask;
    
    [self performSegueWithIdentifier:@"workoutInformation" sender:self];
    
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"workoutInformation"]) {
        EditWorkoutDataViewController *vc = [segue destinationViewController];
        
        NSString *intSets =[_sets substringWithRange:NSMakeRange(16, (_sets.length - 16))];
        NSString *intReps =[_reps substringWithRange:NSMakeRange(16, (_reps.length - 16))];
        NSString *intWeight =[_weight substringWithRange:NSMakeRange(18, (_weight.length - 18))];
        
        vc.nameOfTask = _nameOfTask;
        vc.sets = [intSets integerValue];
        vc.reps = [intReps integerValue];
        vc.weight = [intWeight integerValue];
        vc.row = _row;
        vc.workoutData = _workoutData;
        vc.workoutName = _workoutName;
        
    }
    else if ([[segue identifier] isEqualToString:@"workoutTableView"]) {
        EditWorkoutDataViewController *vc = [segue destinationViewController];
        
        vc.workoutName = _workoutName;
        
    }
    
}

- (IBAction)saveWorkoutSession :(id)sender {
    int count = 0;
    NSString *tempTaskName;
    NSString *tempSets;
    NSString *tempReps;
    NSString *tempWeight;
    
    for (NSString *taskName in _workoutData) {
        if (count == 0) {
            tempTaskName = taskName;
            count++;
        }
        else if (count == 1){
            tempSets = taskName;
            count++;
        }
        else if (count == 2){
            tempReps = taskName;
            count++;
        }
        else if (count == 3){
            tempWeight = taskName;
            PFObject *tasks = [PFObject objectWithClassName:@"PastWorkouts"];
            tasks[@"taskName"] = tempTaskName;
            tasks[@"Sets"] = tempSets;
            tasks[@"Reps"] = tempReps;
            tasks[@"weight"] = tempWeight;
            tasks[@"user"] = [PFUser currentUser].username;
            
            [tasks saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    // The object has been saved.
                } else {
                    // There was a problem, check error.description
                }
            }];
            count = 0;
        }
        //replace with just objectId if you need anything

    }
    //[self performSegueWithIdentifier:@"WorkoutTableViewController" sender:self];
}


@end
