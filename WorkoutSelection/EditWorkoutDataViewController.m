//
//  EditWorkoutDataViewController.m
//  WorkoutSelection
//
//  Created by Bryan Cam on 12/2/15.
//  Copyright © 2015 Bryan Cam. All rights reserved.
//

#import "EditWorkoutDataViewController.h"
#import "AddPastWorkoutViewController.h"
@interface EditWorkoutDataViewController ()

@end

@implementation EditWorkoutDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _taskNameLabel.text = _nameOfTask;
    _setsLabel.text = [NSString stringWithFormat:@"%d", _sets];
    _repsLabel.text = [NSString stringWithFormat:@"%d", _reps];
    _weightLabel.text = [NSString stringWithFormat:@"%d", _weight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addition :(id)sender {
    UIButton *buttonPressed = (UIButton *)sender;
    
    switch (buttonPressed.tag) {
        case 1:
            _sets ++;
            _setsLabel.text = [NSString stringWithFormat:@"%d", _sets];
            break;
        case 2:
            _reps ++;
            _repsLabel.text = [NSString stringWithFormat:@"%d", _reps];
            break;
        case 3:
            _weight = _weight + 5;
            _weightLabel.text = [NSString stringWithFormat:@"%d", _weight];
            break;
        default:
            break;
    }
}
- (IBAction)subtraction :(id)sender{
    UIButton *buttonPressed = (UIButton *)sender;
    
    switch (buttonPressed.tag) {
        case 1:
            _sets --;
            _setsLabel.text = [NSString stringWithFormat:@"%d", _sets];
            break;
        case 2:
            _reps --;
            _repsLabel.text = [NSString stringWithFormat:@"%d", _reps];
            break;
        case 3:
            _weight = _weight - 5;
            _weightLabel.text = [NSString stringWithFormat:@"%d", _weight];
            break;
        default:
            break;
    }
}

- (IBAction)save :(id)sender{
    
    [self performSegueWithIdentifier:@"beginWorkout" sender:self];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"beginWorkout"]){
        
        AddPastWorkoutViewController *vc = [segue destinationViewController];
        
        vc.sets = [NSString stringWithFormat:@"          Sets: %d", _sets];
        vc.reps = [NSString stringWithFormat:@"          Reps: %d", _reps];
        vc.weight = [NSString stringWithFormat:@"          Weight: %d", _weight];
        vc.workoutData = _workoutData;
        vc.workoutName = _workoutName;
        vc.workoutData = [[NSMutableArray alloc]init];
        NSMutableArray *tempWorkoutData = [[NSMutableArray alloc] init];
        int count = 10;
        for (NSString *taskName in _workoutData) {
            if ([taskName isEqualToString:_nameOfTask]) {
                [tempWorkoutData addObject: taskName];
                [tempWorkoutData addObject:[NSString stringWithFormat:@"          Sets: %d", _sets]];
                [tempWorkoutData addObject:[NSString stringWithFormat:@"          Reps: %d", _reps]];
                [tempWorkoutData addObject:[NSString stringWithFormat:@"          Weight: %d", _weight]];
                count = 0;
            }
            else if (count < 3) {
                count++;
            }
            else {
                [tempWorkoutData addObject:taskName];
            }
        }
        vc.workoutData = tempWorkoutData;
    }
}


@end
