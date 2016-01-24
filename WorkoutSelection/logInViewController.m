//
//  SignupViewController.m
//  WorkoutSelection
//
//  Created by Bryan Cam on 11/25/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import "logInViewController.h"
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>


@interface logInViewController () <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end

@implementation logInViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 150; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
    - (void)textFieldDidBeginEditing:(UITextField *)textField
    {
        [self animateTextField: textField up: YES];
        textField.placeholder = nil;
    }
    - (BOOL)textFieldShouldReturn:(UITextField *)textField
    {
        [textField resignFirstResponder];
        return YES;
    }
    - (void)textFieldDidEndEditing:(UITextField *)textField
    {
        [self animateTextField: textField up: NO];
        textField.placeholder = @"bryan2";
    }
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) loginUser:(id)sender {
    [PFUser logInWithUsernameInBackground:_username.text password:_password.text
                                block:^(PFUser *user, NSError *error) {
                                    if (user) {
                                        // Do stuff after successful login.
                                        [self performSegueWithIdentifier:@"workout" sender:self];
                                    } else {
                                        // The login failed. Check error to see why.
                                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                                       message:@"Please change one of the fields"
                                                                                                preferredStyle:UIAlertControllerStyleAlert];
                                        
                                        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                                              handler:^(UIAlertAction * action) {}];
                                        
                                        [alert addAction:defaultAction];
                                        [self presentViewController:alert animated:YES completion:nil];
                                    }
                                }];
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
