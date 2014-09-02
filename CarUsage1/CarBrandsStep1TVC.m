//
//  CarBrandsStep1TVC.m
//  CarUsage1
//
//  Created by Kenneth on 8/30/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "CarBrandsStep1TVC.h"
#import "Brands.h"
#import "RMStepsController.h"
#import "CarAddingConstant.h"

@interface CarBrandsStep1TVC (){
    NSMutableDictionary *dataDictionary;
    NSMutableArray *sectionTitles;
}

@end

#define const SELECTED_BRAND @"selectedBrand"
@implementation CarBrandsStep1TVC

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *sectionTitle = [sectionTitles objectAtIndex:indexPath.section];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Car Brand Cell"];
    Brands *brands = [[dataDictionary objectForKey:sectionTitle] objectAtIndex:indexPath.row];
    cell.textLabel.text = brands.name;
    [cell.imageView setImage:[UIImage imageNamed:brands.logoURL]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionTitle = [sectionTitles objectAtIndex:section];
    NSArray *sectionBrands = [dataDictionary objectForKey:sectionTitle];
    
    return [sectionBrands count];
}

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
    dataDictionary = [NSMutableDictionary new];
    sectionTitles = [NSMutableArray new];
    [self refreshData];
}

- (void)refreshData {
    [dataDictionary removeAllObjects];
    [sectionTitles removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isSubbrand = 0"];
    NSArray *allRecords = [Brands MR_findAllSortedBy:@"pinyinName" ascending:YES withPredicate:predicate];
    [self groupRecordsByInitials:allRecords];
    [self.tableView reloadData];
}

- (void)groupRecordsByInitials:(NSArray *)allRecords {
    // NSMutableDictionary *nameDictionary = [NSMutableDictionary new];
    for (Brands *brand in allRecords) {
        NSString *pinyinName = brand.pinyinName;
        NSString *initial = [[pinyinName substringToIndex:1] capitalizedString];
        // NSLog(@"Initial: %@", initial);
        if ([dataDictionary objectForKey:initial]) {
            [((NSMutableArray *)[dataDictionary objectForKey:initial]) addObject:brand];
        } else {
            [dataDictionary addEntriesFromDictionary:@{initial : @[brand]}];
            [sectionTitles addObject:initial];
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [sectionTitles objectAtIndex:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [sectionTitles count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return sectionTitles;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Brands *selectedBrand = [[dataDictionary objectForKey:sectionTitles[indexPath.section]] objectAtIndex:indexPath.row];
    DLog(@"SelectedBrand: %@", selectedBrand.name);
    [self.stepsController.results setValue:selectedBrand forKey:KEY_SELECTED_BRAND];
    
    [self.stepsController showNextStep];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
