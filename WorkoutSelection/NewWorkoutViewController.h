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

@property (strong, nonatomic) IBOutlet UILabel *remainingPointsLeft;


@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) IBOutlet UITextField *workoutNameChosen;
@property (strong, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutlet UILabel *currentLevel;
@property (strong, nonatomic) IBOutlet UILabel *nextLevel;
@property (strong, nonatomic) IBOutlet UIImageView *iconBaymax;
@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;

- (IBAction)newWorkoutChosen :(id)sender;


@end
