//
//  DetailsViewController.h
//  WorkoutSelection
//
//  Created by Bryan Cam on 11/29/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController
@property (strong, nonatomic) NSString *shouldDelete;
@property (strong, nonatomic) NSString *workoutId;
@property (strong, nonatomic) NSString *taskNameText;
@property (strong, nonatomic) NSString *workoutInstructions;
@property (strong, nonatomic) NSString *workoutName;



@property (strong, nonatomic) IBOutlet UIImageView *picture;
@property (strong, nonatomic) IBOutlet UITextView *instructions;
@property (strong, nonatomic) IBOutlet UILabel *taskName;
@property (strong, nonatomic) IBOutlet UIButton *deleteWorkout;

- (IBAction)deleteWorkout:(id)sender;
@end
