//
//  FirstViewController.h
//  WorkoutSelection
//
//  Created by Bryan Cam on 11/17/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (nonatomic) NSString *muscle;
@property (nonatomic) NSString *objectId;
@property (strong, nonatomic) NSString *workoutName;
@property (strong, nonatomic) NSMutableArray *firstWorkouts;

- (IBAction)muscle :(id)sender;
- (IBAction)selectWorkout :(id)sender;
@end

