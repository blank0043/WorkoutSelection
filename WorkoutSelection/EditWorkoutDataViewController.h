//
//  EditWorkoutDataViewController.h
//  WorkoutSelection
//
//  Created by Bryan Cam on 12/2/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditWorkoutDataViewController : UIViewController

@property (nonatomic) int taskName;
@property (nonatomic) int sets;
@property (nonatomic) int reps;
@property (nonatomic) int weight;
@property (nonatomic) int row;

@property (strong, nonatomic) NSString *workoutName;
@property (strong, nonatomic) NSString *nameOfTask;

@property (strong, nonatomic) NSMutableArray *workoutData;

@property (strong, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *setsLabel;
@property (strong, nonatomic) IBOutlet UILabel *repsLabel;
@property (strong, nonatomic) IBOutlet UILabel *weightLabel;


- (IBAction)addition :(id)sender;
- (IBAction)subtraction :(id)sender;
- (IBAction)save :(id)sender;

@end
