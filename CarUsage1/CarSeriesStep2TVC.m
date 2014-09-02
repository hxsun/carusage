//
//  CarSeriesStep2TVC.m
//  CarUsage1
//
//  Created by Kenneth on 9/1/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "CarSeriesStep2TVC.h"
#import "CarAddingConstant.h"
#import "RMStepsController.h"
#import "Brands.h"
#import "Series.h"

@interface CarSeriesStep2TVC () {
    NSMutableDictionary *dataDictionary;
    NSMutableArray *sectionTitles;
}

@end

@implementation CarSeriesStep2TVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    [self refreshData];
}

- (void)refreshData {
    [dataDictionary removeAllObjects];
    [sectionTitles removeAllObjects];
    
    Brands *selectedBrand = self.stepsController.results[KEY_SELECTED_BRAND];
    DLog(@"Get selected brand on step 2. %@", selectedBrand.name);
    
    if (!selectedBrand) {
        DLog(@"Oops, the selectedBrand is empty, will return to the previous step.");
        
        [self.stepsController showPreviousStep];
        return;
    }
    
    DLog(@"childBrands: %lu", (unsigned long)[selectedBrand.childBrands count]);
    if (!selectedBrand.childBrands || [selectedBrand.childBrands count] == 0) {
        DLog(@"Show series under single brand without any subbrands.");
        [sectionTitles addObject:selectedBrand.name];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"brand = %@", selectedBrand];
        NSArray *series = [Series MR_findAllSortedBy:@"name" ascending:YES withPredicate:predicate];
        [dataDictionary setObject:series forKey:selectedBrand.name];
    } else {
        // Search for the subbrands with selected brand;
        DLog(@"Show series under parent brand with subbrands.");
        for (Brands *subbrand in selectedBrand.childBrands) {
            [sectionTitles addObject:subbrand.name];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"brand = %@", subbrand];
            NSArray *series = [Series MR_findAllSortedBy:@"name" ascending:YES withPredicate:predicate];
            [dataDictionary setObject:series forKey:subbrand.name];
        }
    }
    
    [self.tableView reloadData];
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
    NSString *sectionTitle = [sectionTitles objectAtIndex:section];
    // Return the number of rows in the section.
    return [[dataDictionary objectForKey:sectionTitle] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionTitle = [sectionTitles objectAtIndex:indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Car Series Cell"];
    Series *series = [[dataDictionary objectForKey:sectionTitle] objectAtIndex:indexPath.row];
    cell.textLabel.text = series.name;
    cell.detailTextLabel.text = series.rank;
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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
