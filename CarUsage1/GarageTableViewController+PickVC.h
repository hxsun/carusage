//
//  GarageTableViewController+PickVC.h
//  CarUsage1
//
//  Created by Kenneth Sun on 9/12/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "GarageTableViewController.h"
#import "RMPickerViewController.h"

@interface GarageTableViewController (PickVC)<UIPickerViewDataSource, UIPickerViewDelegate>

- (IBAction)openPickerController:(id)sender selectedCar:(Cars *)car swipeBackBlock:(void (^)())swipeBackBlock;

@end
