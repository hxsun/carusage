//
//  ComponentListTVC.m
//  CarUsage1
//
//  Created by Kenneth Sun on 9/13/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "ComponentListTVC.h"
#import "Models.h"
#import "OfficialPackage.h"
#import "PackageComponentEntry.h"
#import "MaintenanceHistory.h"
#import "Components.h"

@interface ComponentListTVC ()

// @property (nonatomic, strong) NSMutableDictionary *partsHistoriesDic;
@property (nonatomic, strong) NSMutableDictionary *officialComponentDic;

@end

@implementation ComponentListTVC

@synthesize car = _car;
// @synthesize partsHistoriesDic = _partsHistoriesDic;
@synthesize officialComponentDic = _officialComponentDic;

- (void)setCar:(Cars *)car {
    _car = car;
    
    
    // DLog(@"model: %@, package: %@", car.whichModel, car.whichModel.hasPackage);
    NSNumber *packageId = car.whichModel.hasPackage.id;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"id", packageId];
    OfficialPackage *officialPackage = [[OfficialPackage MR_findAllWithPredicate:predicate] firstObject];
    NSArray *packComponentEntries = [officialPackage.containsComponents allObjects];
    
    DLog(@"number of rows:%lu", [packComponentEntries count]);
    
    if (!packComponentEntries || [packComponentEntries count] == 0) {
        DLog(@"No official package available.");
    } else {
    
        _officialComponentDic = [NSMutableDictionary new];
        [packComponentEntries enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            PackageComponentEntry *pcEntry = (PackageComponentEntry *)obj;
            [_officialComponentDic setObject:pcEntry forKey:pcEntry.compType.id];
        }];
        
    }
    
    /*
    _officialComponentDic = [NSMutableDictionary new];
    [[car.whichModel.hasPackage.containsComponents allObjects] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_officialComponentDic setObject:obj forKey:((PackageComponentEntry *)obj).compType.id];
    }];
    
    _partsHistoriesDic = [NSMutableDictionary new];
    NSArray *mtHistories = [car.hasMaintenanceHistories allObjects];
    if (!mtHistories || [mtHistories count] == 0) {
        DLog(@"No maitenance histories for selected car.");
        return;
    }
    
    [mtHistories sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDate *first = [(MaintenanceHistory *)obj1 updatedDate];
        NSDate *second = [(MaintenanceHistory *)obj2 updatedDate];
        return [second compare:first];
    }];
    
    [mtHistories enumerateObjectsUsingBlock:^(id history, NSUInteger idx, BOOL *stop) {
        MaintenanceHistory *temp = (MaintenanceHistory *)history;
        
        NSArray *partList = [temp.replaceComponents allObjects];
        [partList enumerateObjectsUsingBlock:^(id part, NSUInteger idx, BOOL *stop) {
            Components *compType = ((ComponentEntry *)part).compType;
            if (![_partsHistoriesDic.allKeys containsObject:compType.id]) {
                [_partsHistoriesDic setObject:temp forKey:compType.id];
            }
        }];
    }];
     */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.officialComponentDic.allKeys count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Component Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = ((PackageComponentEntry *)[self.officialComponentDic objectForKey:self.officialComponentDic.allKeys[indexPath.row]]).compType.name;
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
