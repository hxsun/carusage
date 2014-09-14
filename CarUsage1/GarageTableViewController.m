//
//  GarageTableViewController.m
//  CarUsage1
//
//  Created by Kenneth on 8/27/14.
//  Copyright (c) 2014 fatken. All rights reserved.
//

#import "GarageTableViewController.h"
#import "CarUsageDatabaseAvailability.h"
#import "Cars.h"
#import "Models.h"
#import "SWRevealViewController.h"
#import "MCSwipeTableViewCell.h"
#import "PXAlertView.h"
#import "GarageTableViewController+PickVC.h"
#import "ComponentListTVC.h"

@interface GarageTableViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;

@property (strong, nonatomic) NSMutableArray *ownedCars;

// @property (nonatomic, strong) MCSwipeTableViewCell *cellToDelete;

@end

@implementation GarageTableViewController

- (void)refreshData {
    [self.ownedCars removeAllObjects];

    self.ownedCars = [[Cars MR_findAll] mutableCopy];

    [self.tableView reloadData];
}

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
    [self setUpRevealViewController];
    
    // [self refreshData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshData];
}

- (void)setUpRevealViewController {
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.revealButtonItem setTarget:self.revealViewController];
        [self.revealButtonItem setAction:@selector(revealToggle:)];
        [self.navigationController.navigationBar addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Car Cell";
    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (NSString *)trimLastChineseChars:(NSString *)originalString {
    NSString *modelName = [originalString mutableCopy];
    long length = [modelName length];
    int index = 0;
    for (int i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [modelName substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) != 3) {
            index = i;
        }
    }
    
    return [originalString substringToIndex:index + 1];
}

/*
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
    
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.frame = cell.bounds;
    grad.opacity = .2;
    grad.startPoint = CGPointMake(0.0, 0.5);
    grad.endPoint = CGPointMake(1.0, 0.5);
    NSNumber *gradBottomStart = [NSNumber numberWithFloat:0.8];
    NSNumber *gradBottomEnd = [NSNumber numberWithFloat:1.0];
    grad.locations = @[gradBottomStart, gradBottomEnd];

    grad.colors = [NSArray arrayWithObjects:(id)[[UIColor greenColor] CGColor], (id)[[UIColor greenColor] CGColor], nil];
    
    [cell setBackgroundView:[[UIView alloc] init]];
    [cell.backgroundView.layer insertSublayer:grad atIndex:0];
    
    CAGradientLayer *selectedGrad = [CAGradientLayer layer];
    selectedGrad.frame = cell.bounds;
    selectedGrad.opacity = 0.5;
    selectedGrad.startPoint = CGPointMake(0.0, 0.5);
    selectedGrad.endPoint = CGPointMake(1.0, 0.5);
    selectedGrad.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    
    [cell setSelectedBackgroundView:[[UIView alloc] init]];
    [cell.selectedBackgroundView.layer insertSublayer:selectedGrad atIndex:0];
}
 
 */

-(UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellAccessoryNone;
}

- (void)configureCell:(MCSwipeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIView *crossView = [self viewWithImageName:@"cross"];
    UIColor *redColor = [UIColor colorWithRed:232.0 / 255.0 green:61.0 / 255.0 blue:14.0 / 255.0 alpha:1];
    
    UIView *clockView = [self viewWithImageName:@"clock"];
    UIColor *blueColor = [UIColor colorWithRed:126 / 255.0 green:206.0 / 255.0 blue:255.0 / 255.0 alpha:1];
    
    [cell setDefaultColor:self.tableView.backgroundView.backgroundColor];
    
    [cell setDelegate:self];
    Cars *car = [self.ownedCars objectAtIndex:indexPath.row];
    
    cell.textLabel.text = car.whichModel.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Purchased at %@", [NSDateFormatter localizedStringFromDate:car.purchaseDate
                                                                                                              dateStyle:NSDateFormatterShortStyle
                                                                                                              timeStyle:NSDateFormatterNoStyle]];
    [cell setSwipeGestureWithView:crossView
                            color:redColor
                             mode:MCSwipeTableViewCellModeExit
                            state:MCSwipeTableViewCellState3
                  completionBlock:^(MCSwipeTableViewCell *indexCell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
                      // TODO;
                      DLog(@"Swipe to delete the car.");
                      
                      // _cellToDelete = indexCell;
                      
                      [PXAlertView showAlertWithTitle:@"确认删除"
                                              message:@"删除后不能恢复，请确认是否删除"
                                          cancelTitle:@"取消"
                                           otherTitle:@"删除"
                                           completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                               if (cancelled) {
                                                   DLog(@"Cancel button pressed");
                                                   [indexCell swipeToOriginWithCompletion:^{
                                                       DLog(@"Swiped back!");
                                                   }];
                                                   // _cellToDelete = nil;
                                                   
                                               } else {
                                                   [car MR_deleteEntity];
                                                   [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                                                   [self.ownedCars removeObjectAtIndex:indexPath.row];
                                                   
                                                   [self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:indexCell]] withRowAnimation:UITableViewRowAnimationFade];
                                                   // _cellToDelete = nil;
                                                   [self.tableView reloadData];
                                                   DLog(@"Deleted.");
                                               }
                                           }];
                  }];
    
    [cell setSwipeGestureWithView:clockView
                            color:blueColor
                             mode:MCSwipeTableViewCellModeExit
                            state:MCSwipeTableViewCellState1
                  completionBlock:^(MCSwipeTableViewCell *indexCell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
                      // TODO;
                      DLog(@"Swipe to update the mileage.");
                      
                      _selectedCar = car;
                      // _cellToDelete = cell;
                      [self openPickerController:self selectedCar:car swipeBackBlock:^{
                          [indexCell swipeToOriginWithCompletion:^{
                              DLog(@"Swiped back!");
                          }];
                          // _cellToDelete = nil;
                      }];
                      
                      
                  }];
}

- (UIView *)viewWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    return imageView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.ownedCars count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Select Car"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ComponentListTVC *dest = segue.destinationViewController;
        dest.car = [self.ownedCars objectAtIndex:indexPath.row];
    }
    
}


@end
