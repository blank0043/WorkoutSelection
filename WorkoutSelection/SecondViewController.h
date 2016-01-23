//
//  SecondViewController.h
//  WorkoutSelection
//
//  Created by Bryan Cam on 11/17/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *tasksList;
    
    UIView *addtaskview;
}

@property (strong, nonatomic) NSString *muscleChosen;
@property (strong, nonatomic) NSString *workoutName;

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *workout1;
@property (strong, nonatomic) IBOutlet UILabel *workout2;
@property (strong, nonatomic) IBOutlet UILabel *workout3;
@property (strong, nonatomic) IBOutlet UILabel *workout4;
@property (strong, nonatomic) NSString* workoutId;

@property  NSMutableArray *workouts;

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;

@property (nonatomic, retain) NSMutableArray *tasksList;

@property (strong, nonatomic) IBOutlet UITextField *taskName;

- (IBAction)editTaskChosen:(id)sender;
- (IBAction)SaveTasksChosen:(id)sender;
- (IBAction)moreInfo:(id)sender;



@end

