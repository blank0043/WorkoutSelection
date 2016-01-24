//
//  IntermediateViewController.m
//  WorkoutSelection
//
//  Created by Bryan Cam on 1/24/16.
//  Copyright © 2016 Bryan Cam. All rights reserved.
//

#import "IntermediateViewController.h"
#import "ActivitiesViewController.h"
#import <Parse/Parse.h>

@interface IntermediateViewController ()

@end

@implementation IntermediateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Score"];
    [query whereKey:@"Username" equalTo:[PFUser currentUser].username];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    
        if (!error) {
            // The find succeeded.
            
            // Do something with the found objects
            for (PFObject *object in objects) {

                    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                    f.numberStyle = NSNumberFormatterDecimalStyle;
            
                    NSNumber *myNumber = [f numberFromString:_userPoints];
                    //don't hardcode here
                
                    long pointsUser = myNumber.integerValue + 1000;
                    _userPoints = [NSString stringWithFormat:@"%lu", pointsUser];
                    NSNumber *pointsAccumulated = [NSNumber numberWithLong:pointsUser];

            
                    [object setObject:pointsAccumulated forKey:@"Score"];
                        
                    [object saveInBackground];
                
                //segue to next
                [self performSegueWithIdentifier:@"activities" sender:self];
                }
        }
    }];
    

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"activities"]){
        
        ActivitiesViewController *vc = [segue destinationViewController];
        vc.completedPicture = _completedPicture;
        
        
        
        
        vc.taskName.text = _name;
        vc.targetLatitude = _targetLatitude;
        vc.targetLongitude = _targetLongitude;
        vc.name = _name;
        vc.completed = [NSNumber numberWithInt:1];
        vc.userPoints = _userPoints;
        
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
        NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
        vc.date = [dateFormatter stringFromDate:[NSDate date]];
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
