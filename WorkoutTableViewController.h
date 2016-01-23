//
//  WorkoutTableViewController.h
//  WorkoutSelection
//
//  Created by Bryan Cam on 11/19/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString *individualTaskName;
@property (strong, nonatomic) NSString *workoutId;
@property (strong, nonatomic) NSString *workoutName;
@property (strong, nonatomic) NSString *primaryKey;


@property (strong, nonatomic) NSMutableArray *taskNames;
@property (strong, nonatomic) NSMutableArray *workoutIds;

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;

- (IBAction)beginWorkout :(id)sender;

@end
