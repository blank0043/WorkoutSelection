//
//  SecondViewController.m
//  WorkoutSelection
//
//  Created by Bryan Cam on 11/17/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstViewController.h"
#import "DetailsViewController.h"
#import <Parse/Parse.h>

@interface SecondViewController ()

@end

@implementation SecondViewController{
    NSArray *tableData;
    int count;
    PFObject *workout;
    int sizeOfInnerQuery;
    NSString *moreInformationMuscle;
}

@synthesize mainTableView;

@synthesize tasksList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tasksList = [[NSMutableArray alloc] init];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.taskName becomeFirstResponder];
   
    
    _label.text = _muscleChosen;
    count = 1;
    PFQuery *query = [PFQuery queryWithClassName:@"Workout"];
    [query whereKey:@"MuscleGroup" equalTo:_muscleChosen];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            tableData = objects;
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSString *playerName = object[@"workoutName"];
                
                if ((int)count == 1) {
                    _workout1.text = playerName;
                }
                else if ((int)count == 2) {
                    _workout2.text = playerName;
                }
                else if ((int)count == 3) {
                    _workout3.text = playerName;
                }
                else if ((int)count == 4) {
                    _workout4.text = playerName;
                }
                count = count + 1;
            }
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    NSString *workoutNameAndMuscleGroup = [NSString stringWithFormat:@"%@/%@/", _workoutName, _muscleChosen];
    PFQuery *innerQuery = [PFQuery queryWithClassName:@"WorkoutCreated"];  // fix with your real user type
    [innerQuery whereKey:@"workoutNameAndMuscleGroup" equalTo:workoutNameAndMuscleGroup];
    sizeOfInnerQuery = 0;
    [innerQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            tableData = objects;
            // Do something with the found objects
            
            for (PFObject *object in objects) {
                NSString *usernameOfObject = object[@"username"];
                NSString *currentUser = [PFUser currentUser].username;
                if ([usernameOfObject isEqualToString:currentUser]) {
                    workout = object;
                    _workoutId = object.objectId;
                    sizeOfInnerQuery ++;
                }
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"chooseMuscles"])
    {
        // Get reference to the destination view controller
        FirstViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        
        vc.firstWorkouts = _workouts;
        vc.objectId = _workoutId;
        vc.workoutName = _workoutName;
        
        
        
    }
    else if ([[segue identifier] isEqualToString:@"moreInfo"]){
        
        DetailsViewController *vc = [segue destinationViewController];
        vc.taskNameText = moreInformationMuscle;
        
        PFQuery *muscles = [PFQuery queryWithClassName:@"Workout"];
        [muscles whereKey:@"workoutName" equalTo:moreInformationMuscle];
        
        PFObject *workoutObject = [muscles getFirstObject];
        PFFile *pictureFile = workoutObject[@"workoutExample"];
        vc.workoutInstructions = workoutObject[@"Instructions"];
        if(pictureFile != NULL)
        {
            
            [pictureFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                
                UIImage *thumbnailImage = [UIImage imageWithData:imageData];
                
                vc.picture.image = thumbnailImage;
                
            }];
            
        }
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger rows = [[self tasksList] count];
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *contentForThisRow = [[self tasksList] objectAtIndex:[indexPath row]];
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        // Do anything that should be the same on EACH cell here.  Fonts, colors, etc.
    }
    
    // Do anything that COULD be different on each cell here.  Text, images, etc.
    [[cell textLabel] setText:contentForThisRow];
    
    return cell;}


- (IBAction)editTaskChosen:(id)sender {
    UIButton *buttonPressed = (UIButton *)sender;
    switch ( buttonPressed.tag ){
            
        case 1:
            if ([buttonPressed.titleLabel.text isEqualToString:@"+"]) {
                [buttonPressed setTitle:@"-" forState:UIControlStateNormal];
                [self addTask:_workout1.text];
            }
            else {
                [buttonPressed setTitle:@"+" forState:UIControlStateNormal];
                [self removeTask:_workout1.text];
            }
            break;
        case 2:
            if ([buttonPressed.titleLabel.text isEqualToString:@"+"]) {
                [buttonPressed setTitle:@"-" forState:UIControlStateNormal];
                [self addTask:_workout2.text];
            }
            else {
                [buttonPressed setTitle:@"+" forState:UIControlStateNormal];
                [self removeTask:_workout2.text];
            }
            break;
        case 3:
            if ([buttonPressed.titleLabel.text isEqualToString:@"+"]) {
                [buttonPressed setTitle:@"-" forState:UIControlStateNormal];
                [self addTask:_workout3.text];
            }
            else {
                [buttonPressed setTitle:@"+" forState:UIControlStateNormal];
                [self removeTask:_workout3.text];
            }
            break;
        case 4:
            if ([buttonPressed.titleLabel.text isEqualToString:@"+"]) {
                [buttonPressed setTitle:@"-" forState:UIControlStateNormal];
                [self addTask:_workout4.text];
            }
            else {
                [buttonPressed setTitle:@"+" forState:UIControlStateNormal];
                [self removeTask:_workout4.text];
            }
            break;
            
        default:
            break;
          
    }
}

- (void)addTask: (NSString *) input {
    
    [tasksList addObject:input];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [mainTableView reloadData];
}

- (void)removeTask:(NSString *) input {
    [tasksList removeObject:input];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [mainTableView reloadData];
}

- (IBAction)SaveTasksChosen:(id)sender {
    
    
    
    
    if (sizeOfInnerQuery == 0) {
        
        PFObject *tasks = [PFObject objectWithClassName:@"WorkoutCreated"];
        tasks[@"username"] = [PFUser currentUser].username;
        //replace with just objectId if you need anything

        tasks[@"workoutName"] = _workoutName;
        
        tasks[@"muscleGroup"] = _label.text;
        NSString *workoutNameAndMuscleGroup = [NSString stringWithFormat:@"%@/%@/", _workoutName, _muscleChosen];
        tasks[@"workoutNameAndMuscleGroup"] = workoutNameAndMuscleGroup;
        _workoutId = tasks.objectId;
        
        int counter = 1;
        for (NSString *taskSelected in tasksList) {
            switch (counter) {
                case 1:
                    tasks[@"task1"] = taskSelected;
                    break;
                case 2:
                    tasks[@"task2"] = taskSelected;
                    break;
                case 3:
                    tasks[@"task3"] = taskSelected;
                    break;
                case 4:
                    tasks[@"task4"] = taskSelected;
                    break;
                default:
                    break;
            }
            counter ++;
        }
        [tasks saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }];
    }
    else {
        PFQuery *query2 = [PFQuery queryWithClassName:@"WorkoutCreated"];
        
        // Retrieve the object by id
        [query2 getObjectInBackgroundWithId:_workoutId
                                     block:^(PFObject *workoutSelected, NSError *error) {
                                         // Now let's update it with some new data. In this case, only cheatMode and score
                                         // will get sent to the cloud. playerName hasn't changed.
                                         
                                         int counter = 1;
                                         for (NSString *taskSelected in tasksList) {
                                             switch (counter) {
                                                 case 1:
                                                     workoutSelected[@"task1"] = taskSelected;
                                                     break;
                                                 case 2:
                                                     workoutSelected[@"task2"] = taskSelected;
                                                     break;
                                                 case 3:
                                                     workoutSelected[@"task3"] = taskSelected;
                                                     break;
                                                 case 4:
                                                     workoutSelected[@"task4"] = taskSelected;
                                                     break;
                                                 default:
                                                     break;
                                             }
                                             counter++;
                                         }
                                         while (counter < 5) {
                                             switch (counter) {
                                                 case 1:
                                                     workoutSelected[@"task1"] = @"";
                                                     break;
                                                 case 2:
                                                     workoutSelected[@"task2"] = @"";
                                                     break;
                                                 case 3:
                                                     workoutSelected[@"task3"] = @"";
                                                     break;
                                                 case 4:
                                                     workoutSelected[@"task4"] = @"";
                                                     break;
                                                 default:
                                                     break;
                                             }
                                             counter++;
                                         }
                                         [workoutSelected saveInBackground];
                                     }];
    }
}

- (IBAction)moreInfo:(id)sender {
    UIButton *buttonPressed = (UIButton *)sender;
    
    switch (buttonPressed.tag) {
        case 1:
            moreInformationMuscle = _workout1.text;
            break;
        case 2:
            moreInformationMuscle = _workout2.text;
            break;
        case 3:
            moreInformationMuscle = _workout3.text;
            break;
        case 4:
            moreInformationMuscle = _workout4.text;
            break;
        default:
            break;
    }
    [self performSegueWithIdentifier:@"moreInfo" sender:self];
}

@end
