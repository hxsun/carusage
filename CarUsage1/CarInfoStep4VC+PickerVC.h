//
//  CarInfoStep4VC+PickerVC.h
//  CarUsage1
//
//  Created by Kenneth Sun on 9/12/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "CarInfoStep4VC.h"
#import "RMPickerViewController.h"

@interface CarInfoStep4VC (PickerVC)<UIPickerViewDataSource, UIPickerViewDelegate>

- (void)initializeFormData;

- (IBAction)openDateSelectionController:(id)sender initDate:(NSDate *)date;

- (IBAction)openPickerController:(id)sender initMileage:(NSUInteger)mileage;

@end
