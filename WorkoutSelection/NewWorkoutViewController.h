//
//  NewWorkoutViewController.h
//  WorkoutSelection
//
//  Created by Bryan Cam on 11/30/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewWorkoutViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) NSString *workoutName;
@property (strong, nonatomic) NSString *workoutId;

@property (strong, nonatomic) NSMutableArray *workoutNames;
@property (strong, nonatomic) NSMutableArray *workoutIds;

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) IBOutlet UITextField *workoutNameChosen;


- (IBAction)newWorkoutChosen :(id)sender;

@end
