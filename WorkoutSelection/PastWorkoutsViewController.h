//
//  PastWorkoutsViewController.h
//  WorkoutSelection
//
//  Created by Bryan Cam on 12/2/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PastWorkoutsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>



@property (strong, nonatomic) NSMutableArray *taskNames;
@property (strong, nonatomic) NSMutableArray *workoutData;

@property (strong, nonatomic) NSString *nameOfTask;
@property (strong, nonatomic) NSString *sets;
@property (strong, nonatomic) NSString *reps;
@property (strong, nonatomic) NSString *weight;
@property (nonatomic) int row;

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;

@end
