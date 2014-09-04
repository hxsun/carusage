//
//  CarInfoStep4VC.m
//  CarUsage1
//
//  Created by Kenneth on 9/4/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "CarInfoStep4VC.h"
#import "RMStepsController.h"
#import "CarAddingConstant.h"
#import "CarInfoForm.h"
#import "Models.h"

@interface CarInfoStep4VC ()

@end

@implementation CarInfoStep4VC

- (void)awakeFromNib
{
    // [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.formController.form = [CarInfoForm new];
    }

- (void)viewDidLoad {
    
    [super viewDidLoad];
    CarInfoForm *form = self.formController.form;
    
    Models *model = self.stepsController.results[KEY_SELECTED_MODEL];
    form.engine = model.engine;
    form.driveType = model.driveType;
    form.transmissionType = model.transmissionType;
    // form.carStructure = model.carStructure;
    // form.warranty = model.warranty;


}

- (void)submitCarInfoForm:(UITableViewCell<FXFormFieldCell> *)cell {
    // TODO: save the car info and finish all steps.
    
    
    [self.stepsController showNextStep];

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
