//
//  GarageTableViewController+PickVC.m
//  CarUsage1
//
//  Created by Kenneth Sun on 9/12/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "GarageTableViewController+PickVC.h"
#import "UpdateHistory.h"

#define NUMBER_OF_COLUMNS 6

@implementation GarageTableViewController (PickVC)

- (IBAction)openPickerController:(id)sender selectedCar:(Cars *)car swipeBackBlock:(void (^)())swipeBackBlock {
    RMPickerViewController *pickerVC = [RMPickerViewController pickerController];
    pickerVC.titleLabel.text = @"请选择已行驶里程（公里）";
    pickerVC.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    pickerVC.disableBouncingWhenShowing = YES;
    
    pickerVC.picker.dataSource = self;
    pickerVC.picker.delegate = self;
    
    NSSortDescriptor *sortDescriptorByDateDescending = [[NSSortDescriptor alloc] initWithKey:@"updateDate" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptorByDateDescending, nil];
    
    NSArray *updateHistories = [[car.hasUpdateHistories allObjects] sortedArrayUsingDescriptors:sortDescriptors];
    
    NSUInteger mileage = [car.initialMilage integerValue];
    if ([updateHistories count] > 0) {
        mileage = [((UpdateHistory *)updateHistories[0]).mileage integerValue];
    }
    
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
            
            UpdateHistory *updateHistory = [UpdateHistory MR_createEntity];
            updateHistory.mileage = [NSNumber numberWithInteger:inputMilage];
            updateHistory.updatedDate = [NSDate date];
            updateHistory.updateTakenByCar = car;
            
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            // [self.form formRowWithTag:KEY_MILEAGE].value = [NSString stringWithFormat:@"%lu 公里", self.mileage];
            // [self.tableView reloadData];
            swipeBackBlock();
        } andCancelHandler:^(RMPickerViewController *vc) {
            // do nothing;
            swipeBackBlock();
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
