//
//  TakePictureViewController.m
//  WorkoutSelection
//
//  Created by Bryan Cam on 1/23/16.
//  Copyright © 2016 Bryan Cam. All rights reserved.
//

#import "TakePictureViewController.h"
#import "IntermediateViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>


@interface TakePictureViewController ()

@end

@implementation TakePictureViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    if (_valid == 1) {
        [self performSegueWithIdentifier:@"activities" sender:self];    }
    
    
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.picture.image = chosenImage;
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    
    }
    [locationManager startUpdatingLocation];
    double currentLatitude = [locationManager location].coordinate.latitude;
    double currentLongitude = [locationManager location].coordinate.longitude;
    NSLog(@"%f lat,%f long", currentLatitude, currentLongitude);
    NSLog(@"%f lat,%f long", _targetLatitude.doubleValue, _targetLongitude.doubleValue);
    NSLog(@"%f lat,%f long", _targetLatitude.doubleValue, _targetLongitude.doubleValue);
    float geoFenceEpsilon = 1.0f;
    if (geoFenceEpsilon > ABS([_targetLatitude floatValue] - currentLatitude) && geoFenceEpsilon > ABS([_targetLongitude floatValue] - currentLongitude)) {
        _valid = 1;
    }
    else {
        _valid = 0;
    }

    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"activities"]){
        
        IntermediateViewController *vc = [segue destinationViewController];
        vc.completedPicture = self.picture.image;
        
               

        
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


@end
