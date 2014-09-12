//
//  CarInfoStep4VC+PickerVC.m
//  CarUsage1
//
//  Created by Kenneth Sun on 9/12/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "CarInfoStep4VC+PickerVC.h"
#import "RMDateSelectionViewController.h"
#import "RMPickerViewController.h"
#import "CarAddingConstant.h"

#define NUMBER_OF_COLUMNS 6

@implementation CarInfoStep4VC (PickerVC)

- (void)initializeData {
    if (!self.dateOfPurchase) {
        self.dateOfPurchase = [NSDate date];
    }
    self.mileage = 0;
}

#pragma mark - Actions
- (IBAction)openDateSelectionController:(id)sender initDate:(NSDate *) date {
    [RMDateSelectionViewController setLocalizedTitleForNowButton:@"Today"];
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    // dateSelectionVC.titleLabel.text = @"This is an example.";
    dateSelectionVC.disableBouncingWhenShowing = YES;
    // dateSelectionVC.disableBlurEffects = NO;
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionVC.datePicker.date = date;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [dateSelectionVC showWithSelectionHandler:^(RMDateSelectionViewController *vc, NSDate *aDate) {
            self.dateOfPurchase = aDate;
            [self.form formRowWithTag:KEY_DATE_OF_PURCHASE].value = [NSDateFormatter localizedStringFromDate:self.dateOfPurchase
                                                                                              dateStyle:NSDateFormatterLongStyle
                                                                                              timeStyle:NSDateFormatterNoStyle];
            [self.tableView reloadData];
        } andCancelHandler:^(RMDateSelectionViewController *vc) {
            // do nothing;
        }];
    } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        // Nothing would happen, since now we donot support ipad version.
        // [dateSelectionVC showFromRect:[self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] inView:self.view];
    }
}

- (IBAction)openPickerController:(id)sender initMileage:(NSUInteger)mileage {
    RMPickerViewController *pickerVC = [RMPickerViewController pickerController];
    pickerVC.titleLabel.text = @"请输入已行驶里程（公里）";
    pickerVC.disableBouncingWhenShowing = YES;
    
    pickerVC.picker.dataSource = self;
    pickerVC.picker.delegate = self;
    
    NSUInteger temp = mileage;
    NSUInteger level = NUMBER_OF_COLUMNS - 1;
    for (int i = 0; i < NUMBER_OF_COLUMNS; i++, level--) {
        NSUInteger dlevel = pow(10, level);
        NSUInteger digit = floor(temp / dlevel);
        temp = temp % dlevel;
        [pickerVC.picker selectRow:digit inComponent:i animated:YES];
    }
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [pickerVC showWithSelectionHandler:^(RMPickerViewController *vc, NSArray *selectedRows) {
            NSUInteger inputMilage = 0;
            NSUInteger level = NUMBER_OF_COLUMNS - 1;
            for (int i = 0; i < NUMBER_OF_COLUMNS; i++, level--) {
                inputMilage += [selectedRows[i] integerValue] * pow(10, level);
            }
            self.mileage = inputMilage;
            [self.form formRowWithTag:KEY_MILEAGE].value = [NSString stringWithFormat:@"%lu 公里", self.mileage];
            [self.tableView reloadData];
        } andCancelHandler:^(RMPickerViewController *vc) {
            // do nothing;
        }];
    } else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [pickerVC showFromViewController:self.navigationController];
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 6;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 10;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%lu", row];
}

@end
