//
//  TakePictureViewController.h
//  WorkoutSelection
//
//  Created by Bryan Cam on 1/23/16.
//  Copyright © 2016 Bryan Cam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakePictureViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *picture;
@property (strong, nonatomic) NSNumber *targetLongitude;
@property (strong, nonatomic) NSNumber *targetLatitude;
@property (nonatomic) int valid;
@property (strong, nonatomic) NSString *userPoints;
@property (strong, nonatomic) NSString *name;


- (IBAction)takePhoto :(UIButton *)sender;


@end
