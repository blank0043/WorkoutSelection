
//
//  NewWorkoutViewController.m
//  WorkoutSelection
//
//  Created by Bryan Cam on 11/30/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import "NewWorkoutViewController.h"
#import "FirstViewController.h"
#import "WorkoutTableViewController.h"
#import <Parse/Parse.h>

@interface NewWorkoutViewController ()

@end

@implementation NewWorkoutViewController{
    NSArray *tableData;
}

@synthesize mainTableView;

@synthesize workoutNames;

@synthesize workoutIds;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    workoutNames = [[NSMutableArray alloc] init];
    workoutIds = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view.
    PFQuery *query = [PFQuery queryWithClassName:@"WorkoutCreated"];
    [query whereKey:@"username" equalTo:[PFUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            
            tableData = objects;
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSString *workout1 = object[@"workoutName"];
                if (![workoutNames containsObject:workout1]) {
                    [workoutNames addObject:workout1];
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

- (IBAction)newWorkoutChosen :(id)sender {
    if (_workoutNameChosen.text.length < 1) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Please write a name for the new Workout"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        [self performSegueWithIdentifier:@"firstViewController" sender:self];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [workoutNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"workouts";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [workoutNames objectAtIndex:indexPath.row];
    
    return cell;
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _workoutId = [workoutIds objectAtIndex:indexPath.row];
    _workoutName = [workoutNames objectAtIndex:indexPath.row];
   
    [self performSegueWithIdentifier:@"detail" sender:self];
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"detail"]){
        
        WorkoutTableViewController *vc = [segue destinationViewController];
        vc.workoutId = _workoutId;
        vc.workoutName = _workoutName;
    }
    else if ([[segue identifier] isEqualToString:@"firstViewController"]){
        
        FirstViewController *vc = [segue destinationViewController];
        vc.workoutName = _workoutNameChosen.text;
        
    }
    
}



@end
