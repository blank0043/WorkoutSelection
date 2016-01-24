
//
//  NewWorkoutViewController.m
//  WorkoutSelection
//
//  Created by Bryan Cam on 11/30/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import "NewWorkoutViewController.h"
#import "WorkoutTableViewController.h"
#import <Parse/Parse.h>

@interface NewWorkoutViewController ()

@end

@implementation NewWorkoutViewController{
    NSArray *tableData;
}


@synthesize workoutNames;

@synthesize workoutIds;

- (void) viewDidAppear:(BOOL)animated {
    NSLog(@"Hi");
    __block int level = 1;
    float maxScore = 1000.0f;
    NSString *maxScoreString = [NSString stringWithFormat:@"%f", maxScore];
    
    // Do any additional setup after loading the view.
    PFQuery *query = [PFQuery queryWithClassName:@"Score"];
    [query whereKey:@"Username" equalTo:[PFUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            
            tableData = objects;
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSNumber *score1 = object[@"Score"];
                NSNumberFormatter *formatter = [NSNumberFormatter new];
                [formatter setNumberStyle:NSNumberFormatterDecimalStyle]; // this line is important!
                
                NSString *formatted = [formatter stringFromNumber:[NSNumber numberWithInteger:[score1 integerValue]]];
                NSString *formattedMax = [formatter stringFromNumber:[NSNumber numberWithInteger:[maxScoreString integerValue]]];
                
                _score.text = [NSString stringWithFormat:@"%@ / %@", formatted, formattedMax];
                float progressValue = [score1 floatValue]/[maxScoreString floatValue];
                
                NSString *remainingPointsLeftStr = [NSString stringWithFormat:@"%f", maxScore - [score1 floatValue]];
                NSString *formattedRemaining = [formatter stringFromNumber:[NSNumber numberWithInteger:[remainingPointsLeftStr integerValue]]];
                _remainingPointsLeft.text = [NSString stringWithFormat:@"%@ points until", formattedRemaining];
                NSNumber *currentLevel = object[@"Level"];
                level = [currentLevel integerValue];
                
                if (progressValue > 0.995) {
                    
                    
                    //if currentLevel is 5, we don't do anything and stay at 5, it doesn't matter if the points are capped because progress bar will stay maxed out
                    if ([currentLevel integerValue] == 5) {
                        continue;
                    }
                    
                    
                    else {
                        //Reset score to 0
                        object[@"Score"] = @0;
                        _score.text = [NSString stringWithFormat:@"%@ / %@", @0, formattedMax];
                        progressValue = 0.0f;
                        
                        //Increment level
                        int nextLevel = [currentLevel integerValue] + 1;
                        object[@"Level"] = [NSNumber numberWithInt: nextLevel];
                        
                        //Set local global level object to nextLevel
                        level = nextLevel;
                        
                        //Update to Parse database
                        [object saveInBackground];
                    }
                }
                NSLog(@"%@", [NSString stringWithFormat:@"The level is %u", level]);
                if (level == 1) {
                    _currentLevel.text = [NSString stringWithFormat:@"R O O K I E"];
                    _nextLevel.text = [NSString stringWithFormat:@"S I D E K I C K"];
                    _iconBaymax.image = [UIImage imageNamed: @"baymaxrookie.png"];
                    
                }
                else if (level == 2) {
                    _currentLevel.text = [NSString stringWithFormat:@"S I D E K I C K"];
                    _nextLevel.text = [NSString stringWithFormat:@"V I G I L A N T E"];
                    _iconBaymax.image = [UIImage imageNamed: @"baymaxsidekick.png"];
                }
                else if (level == 3) {
                    _currentLevel.text = [NSString stringWithFormat:@"V I G I L A N T E"];
                    _nextLevel.text = [NSString stringWithFormat:@"W A R R I O R"];
                    _iconBaymax.image = [UIImage imageNamed: @"baymaxvigilante.png"];
                }
                else if (level == 4) {
                    _currentLevel.text = [NSString stringWithFormat:@"W A R R I O R"];
                    _nextLevel.text = [NSString stringWithFormat:@"H E R O"];
                    _iconBaymax.image = [UIImage imageNamed: @"baymaxwarrior.png"];
                }
                
                else if (level == 5) {
                    _currentLevel.text = [NSString stringWithFormat:@"H E R O"];
                    _nextLevel.text = [NSString stringWithFormat:@"MAXED"];
                    _iconBaymax.image = [UIImage imageNamed: @"baymaxhero.png"];
                }
                
                _progressBar.progress = progressValue;
                [_progressBar setProgress:progressValue animated:YES];
                [_progressBar reloadInputViews];
                
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    

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
        vc.userPoints = _score.text;
    }
        
}



@end
