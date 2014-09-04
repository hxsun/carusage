//
//  CarModelsStep3TVC.m
//  CarUsage1
//
//  Created by Kenneth on 9/2/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "RMStepsController.h"
#import "CarAddingConstant.h"
#import "CarModelsStep3TVC.h"
#import "Series.h"
#import "Models.h"
#import "NSMutableArray+KSSorted.h"

#define keyOnSaleSegment 0
#define keyOffSaleSegment 1

#define valueForKeyOnSaleSegment 1
#define valueForKeyOffSaleSegment 0

@interface CarModelsStep3TVC () {
    NSMutableDictionary *dataDictionary;
    NSMutableArray *sectionTitles;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CarModelsStep3TVC

- (IBAction)didChangeSegment:(id)sender {
    
    UISegmentedControl *control = (UISegmentedControl *)sender;
    
    if (control.selectedSegmentIndex == keyOnSaleSegment)
    {
        [self refreshData:valueForKeyOnSaleSegment blockToProcessData:^(NSMutableDictionary *pDictionary, Models *pModels) {
            if ([[pDictionary allKeys] containsObject:pModels.engine]) {
                [[pDictionary mutableArrayValueForKey:pModels.engine] addObject:pModels withComparator:^NSComparisonResult(Models *obj1, Models *obj2) {
                    return [obj1.name compare:obj2.name];
                }];
            } else {
                [pDictionary setValue:@[pModels] forKey:pModels.engine];
            }
        }];
    }
    else if (control.selectedSegmentIndex == keyOffSaleSegment)
    {
        [self refreshData:valueForKeyOffSaleSegment blockToProcessData:^(NSMutableDictionary *pDictionary, Models *pModels) {
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear
                                                                           fromDate:pModels.publishedYear];
            NSString *keyString = [NSString stringWithFormat:@"%ld款", (long)[components year]];
            
            if ([[pDictionary allKeys] containsObject:keyString]) {
                
                [[pDictionary mutableArrayValueForKey:keyString] addObject:pModels withComparator:^NSComparisonResult(Models *obj1, Models *obj2) {
                    return [obj1.name compare:obj2.name];
                }];
            } else {
                [pDictionary setValue:@[pModels] forKey:keyString];
            }
        }];
    }
}

- (void) refreshData:(NSInteger)valueForSelectedSegment blockToProcessData:(void (^)(NSMutableDictionary *pDictionary, Models *pModels))block {
    [dataDictionary removeAllObjects];
    [sectionTitles removeAllObjects];
    
    Series *selectedSeries = self.stepsController.results[KEY_SELECTED_SERIES];
    DLog(@"Get selected series on step 3. %@", selectedSeries.name);
    
    if (!selectedSeries) {
        DLog(@"Oops, the selectedSeries is empty, will return to the previous step.");
        
        [self.stepsController showPreviousStep];
        return;
    }
    
    DLog(@"number of models: %lu", (unsigned long)[selectedSeries.models count]);
    
    if (!selectedSeries.models || [selectedSeries.models count] == 0) {
    
        DLog(@"No series are configured in current selected model.");
    } else {
        DLog(@"Show series under current selected model.");
        for (Models *model in selectedSeries.models) {
            if ([model.onsale isEqualToNumber:[NSNumber numberWithInteger:valueForSelectedSegment]]) {
                block(dataDictionary, model);
            }
        }
        [sectionTitles addObjectsFromArray:dataDictionary.allKeys];
        
        // Sort the section in descending order.
        if (valueForSelectedSegment == valueForKeyOnSaleSegment) {
            [sectionTitles sortUsingSelector:@selector(localizedStandardCompare:)];
        } else {
            [sectionTitles sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                if ([obj1 intValue] < [obj2 intValue]) return NSOrderedDescending;
                else return NSOrderedAscending;
            }];
        }
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dataDictionary = [NSMutableDictionary new];
    sectionTitles = [NSMutableArray new];
    
    [self refreshData:valueForKeyOnSaleSegment blockToProcessData:^(NSMutableDictionary *pDictionary, Models *pModels) {
        if ([[pDictionary allKeys] containsObject:pModels.engine]) {
            [[pDictionary mutableArrayValueForKey:pModels.engine] addObject:pModels];
        } else {
            [pDictionary setValue:@[pModels] forKey:pModels.engine];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [sectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return sectionTitles[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *sectionTitle = [sectionTitles objectAtIndex:section];
    return [[dataDictionary objectForKey:sectionTitle] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *sectionTitle = [sectionTitles objectAtIndex:indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Car Model Cell"];
    
    Models *model = [[dataDictionary objectForKey:sectionTitle] objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", model.driveType, model.transmissionType];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
