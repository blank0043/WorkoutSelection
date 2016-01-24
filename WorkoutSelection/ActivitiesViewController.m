//
//  ActivitiesViewController.m
//  WorkoutSelection
//
//  Created by Bryan Cam on 1/23/16.
//  Copyright © 2016 Bryan Cam. All rights reserved.
//

#import "ActivitiesViewController.h"
#import "TakePictureViewController.h"
#import <Parse/Parse.h>

@interface ActivitiesViewController ()

@end

@implementation ActivitiesViewController {
    NSArray *tableData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _taskName.text = _name;
    PFQuery *query = [PFQuery queryWithClassName:@"Activities"];
    [query whereKey:@"TaskName" equalTo:_name];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            
            tableData = objects;
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSString *taskDescription = object[@"TaskDescription"];
                _taskDescription.text = taskDescription;
                if (_completed.intValue == 1) {
                    //save here
                    
                    _picture.image = _completedPicture;
                    
                    PFFile *imageFile = [PFFile fileWithData:UIImageJPEGRepresentation(_picture.image, 1.0)];
                    [imageFile save];
                    
                    
                   
                    
                    [object setObject:imageFile forKey:@"CompletePicture"];
                    [object setObject:_date forKey:@"DateofCompletion"];
                    
                    [object saveInBackground];
                    _accept.hidden = YES;
                    _date = object[@"DateofCompletion"];
                    _date = [@"date complete: " stringByAppendingString:_date];
                    
                    _dateCompleted.text = _date;
                }
                
                else {
                    PFFile *completedPictureFile = object[@"CompletePicture"];
                    if (completedPictureFile != NULL) {
                        [completedPictureFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                            
                            UIImage *thumbnailImage = [UIImage imageWithData:imageData];
                            
                            
                            _picture.image = thumbnailImage;
                            _accept.hidden = YES;
                            _date = object[@"DateofCompletion"];
                            _date = [@"date complete: " stringByAppendingString:_date];
                            
                            _dateCompleted.text = _date;
                        }];
                    }
                    else {
                        PFFile *pictureFile = object[@"TaskPicture"];
                        if(pictureFile != NULL)
                        {
                    
                            [pictureFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                        
                                UIImage *thumbnailImage = [UIImage imageWithData:imageData];
                            
                        
                                _picture.image = thumbnailImage;
                        
                            }];
                        }
                    }
                }

                
                NSNumber *points = object[@"Points"];
                NSNumberFormatter *formatter = [NSNumberFormatter new];
                [formatter setNumberStyle:NSNumberFormatterDecimalStyle]; // this line is important!
                
                NSString *formatted = [formatter stringFromNumber:[NSNumber numberWithInteger:[points integerValue]]];
                
                NSString *plus = @"+";
                _points.text = [plus stringByAppendingString:formatted];
                
                
                
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"picture"]){
        
        TakePictureViewController *vc = [segue destinationViewController];
        vc.targetLatitude = _targetLatitude;
        vc.targetLongitude = _targetLongitude;
        vc.name = _name;
        vc.userPoints = _userPoints;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
