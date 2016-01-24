//
//  IntermediateViewController.h
//  WorkoutSelection
//
//  Created by Bryan Cam on 1/24/16.
//  Copyright © 2016 Bryan Cam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntermediateViewController : UIViewController
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *targetLongitude;
@property (strong, nonatomic) NSNumber *targetLatitude;
@property (strong, nonatomic) NSNumber *completed;
@property (strong, nonatomic) NSString *userPoints;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) UIImage *completedPicture;
@property (strong, nonatomic) IBOutlet UILabel *taskName;

@end
