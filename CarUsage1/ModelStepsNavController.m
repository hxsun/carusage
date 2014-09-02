//
//  ModelStepsNavController.m
//  CarUsage1
//
//  Created by Kenneth on 8/29/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "ModelStepsNavController.h"

@interface ModelStepsNavController ()

@end

@implementation ModelStepsNavController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)stepViewControllers {
    UIViewController *firstStep = [self.storyboard instantiateViewControllerWithIdentifier:@"AddStep1CarBrands"];
    firstStep.step.title = @"品牌";
    
    UIViewController *secondStep = [self.storyboard instantiateViewControllerWithIdentifier:@"AddStep2CarSeries"];
    secondStep.step.title = @"系列";
    
    UIViewController *thirdStep = [self.storyboard instantiateViewControllerWithIdentifier:@"AddStep3CarModels"];
    thirdStep.step.title = @"车型";
    
    UIViewController *fourthStep = [self.storyboard instantiateViewControllerWithIdentifier:@"AddStep4CarInfo"];
    fourthStep.step.title = @"基本信息";
    
    return @[firstStep, secondStep, thirdStep, fourthStep];
    
}

- (void)finishedAllSteps {

    // TODO: create car object and load the components of the specified model.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)canceled {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
