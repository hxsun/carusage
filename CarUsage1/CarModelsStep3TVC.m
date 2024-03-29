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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 18;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 2, tableView.frame.size.width, 12)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    [label setTextColor:[UIColor grayColor]];
    NSString *string =[sectionTitles objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    //[view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *sectionTitle = [sectionTitles objectAtIndex:indexPath.section];
    
    Models *model = [[dataDictionary objectForKey:sectionTitle] objectAtIndex:indexPath.row];
    DLog(@"Selected model:%@", model.name);
    [self.stepsController.results setObject:model forKey:KEY_SELECTED_MODEL];
    [self.stepsController showNextStep];
}


@end
