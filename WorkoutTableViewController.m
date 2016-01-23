//
//  WorkoutTableViewController.m
//  WorkoutSelection
//
//  Created by Bryan Cam on 11/19/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import "WorkoutTableViewController.h"
#import "DetailsViewController.h"
#import "FirstViewController.h"
#import "AddPastWorkoutViewController.h"
#import <Parse/Parse.h>

@interface WorkoutTableViewController ()

@end

@implementation WorkoutTableViewController {
    NSArray *tableData;
    
}

@synthesize mainTableView;

@synthesize taskNames;

@synthesize workoutIds;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    taskNames = [[NSMutableArray alloc] init];
    workoutIds = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    PFQuery *query = [PFQuery queryWithClassName:@"WorkoutCreated"];
    //changeprimarykey to _objectId
    [query whereKey:@"workoutName" equalTo:_workoutName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            
            tableData = objects;
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSString *workout1 = object[@"task1"];
                NSString *workout2 = object[@"task2"];
                NSString *workout3 = object[@"task3"];
                NSString *workout4 = object[@"task4"];
                
                if (workout1.length > 0) {
                    [taskNames addObject:workout1];
                    [workoutIds addObject:object.objectId];
                }
                if (workout2.length > 0) {
                    [taskNames addObject:workout2];
                    [workoutIds addObject:object.objectId];
                }
                if (workout3.length > 0) {
                    [taskNames addObject:workout3];
                    [workoutIds addObject:object.objectId];
                }
                if (workout4.length > 0) {
                    [taskNames addObject:workout4];
                    [workoutIds addObject:object.objectId];
                }
                
                
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
    _workoutId = [workoutIds objectAtIndex:indexPath.row];
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
        
        DetailsViewController *vc = [segue destinationViewController];
        vc.taskNameText = _individualTaskName;
        vc.shouldDelete = @"delete";
        vc.workoutId = _workoutId;
        vc.workoutName = _workoutName;
        
        
        
        
        PFQuery *muscles = [PFQuery queryWithClassName:@"Workout"];
        [muscles whereKey:@"workoutName" equalTo:_individualTaskName];
        
        PFObject *workoutObject = [muscles getFirstObject];
        PFFile *pictureFile = workoutObject[@"workoutExample"];
        vc.workoutInstructions = workoutObject[@"Instructions"];
        if(pictureFile != NULL)
        {
            
            [pictureFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                
                UIImage *thumbnailImage = [UIImage imageWithData:imageData];
                
                vc.picture.image = thumbnailImage;
                
            }];
            
        }
    }
    else if ([[segue identifier] isEqualToString:@"firstViewController"]) {
        FirstViewController *vc = [segue destinationViewController];
        vc.workoutName = _workoutName;
        // temp deleted add if primaryKey/ id needed  ... vc.workoutId = _primaryKey;
    }
    else if ([[segue identifier] isEqualToString:@"beginWorkout"]) {
        AddPastWorkoutViewController *vc = [segue destinationViewController];
        vc.taskNames = taskNames;
        vc.workoutName = _workoutName;
        vc.workoutData = [[NSMutableArray alloc]init];
        for (NSString *taskName in taskNames) {
            
            [vc.workoutData addObject: taskName];
            [vc.workoutData addObject:@"          Sets: 0"];
            [vc.workoutData addObject:@"          Reps: 0"];
            [vc.workoutData addObject:@"          Weight: 0"];
            
        }
        
        
        
        vc.sets = [NSString stringWithFormat:@"          Sets: 0"];
        vc.reps = [NSString stringWithFormat:@"          Reps: 0"];
        vc.weight = [NSString stringWithFormat:@"          Weight: 0"];

        // temp deleted add if primaryKey/ id needed  ... vc.workoutId = _primaryKey;
    }
    
    
}


@end
