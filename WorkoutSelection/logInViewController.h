//
//  SignupViewController.h
//  WorkoutSelection
//
//  Created by Bryan Cam on 11/25/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface logInViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField* username;
@property (strong, nonatomic) IBOutlet UITextField* password;

- (IBAction) loginUser:(id)sender;

@end
