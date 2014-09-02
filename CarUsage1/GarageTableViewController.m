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

@interface GarageTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;

@end

@implementation GarageTableViewController

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserverForName:CarUsageDatabaseAvailabilityNotification
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *note) {
                                                      self.managedObjectContext = note.userInfo[CarUsageDatabaseAvailabilityContext];
                                                  }];
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    _managedObjectContext = managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Cars"];
    request.predicate = [NSPredicate predicateWithFormat:@"deleted != 1"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"addedDate" ascending:YES selector:@selector(localizedStandardCompare:)]];
    
    self.fetchedResultsController =[[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                       managedObjectContext:managedObjectContext
                                                                         sectionNameKeyPath:nil
                                                                                  cacheName:nil];
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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Car Cell"
                                                            forIndexPath:indexPath];
    
    Cars *car = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = car.whichType.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Bought at %@",
                                 [NSDateFormatter localizedStringFromDate:car.boughtDate
                                                                dateStyle:NSDateFormatterShortStyle
                                                                timeStyle:NSDateFormatterNoStyle]];
    
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
