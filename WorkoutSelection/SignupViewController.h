//
//  SignupViewController.h
//  Chatter
//
//  Created by Josh Pearlstein on 11/3/15.
//  Copyright © 2015 SEAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField* username;
@property (strong, nonatomic) IBOutlet UITextField* password;
@property (strong, nonatomic) IBOutlet UITextField* email;

- (IBAction)registerNewUser:(id)sender;

@end
