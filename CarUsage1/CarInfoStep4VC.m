
#import "XLForm.h"
#import "CarInfoStep4VC.h"
#import "RMStepsController.h"
#import "CarAddingConstant.h"
#import "Models.h"
#import "PXAlertView.h"
#import "Cars.h"

NSString *const kCarStructure = @"carStructure";
NSString *const kEngine = @"engine";
NSString *const kDriveType = @"driveType";
NSString *const kTransmissionType = @"transmissionTYpe";
NSString *const kWarranty = @"warranty";
NSString *const kDateOfPurchase = @"dateOfPurchase";
NSString *const kMileage = @"mileage";
NSString *const kLoadInitialPackage = @"loadInitialPackage";
NSString *const kSubmitButton = @"submitButton";

@implementation CarInfoStep4VC

- (void)viewDidLoad {
    [super viewDidLoad];
    DLog(@"View did load");
    
    [self initializeForm];
    self.tableView.sectionHeaderHeight = 44;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.form) {
        [self updateFormValues:self.stepsController.results];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, tableView.frame.size.width, 12)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    [label setTextColor:[UIColor grayColor]];
    // NSString *string =[sectionTitles objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:[self tableView:tableView titleForHeaderInSection:section]];
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

- (void)updateFormValues:(NSDictionary *)sessionDictionary {
    if (!self.form) {
        [self initializeForm];
    }
    Models *model = sessionDictionary[KEY_SELECTED_MODEL];
    [self.form formRowWithTag:kCarStructure].value = model.carStructure;
    [self.form formRowWithTag:kEngine].value = model.engine;
    [self.form formRowWithTag:kDriveType].value = model.driveType;
    [self.form formRowWithTag:kTransmissionType].value = model.transmissionType;
    [self.form formRowWithTag:kWarranty].value = model.warranty;
    [self.form formRowWithTag:kMileage].value = 0;
    [self.form formRowWithTag:kDateOfPurchase].value = [NSDate date];
    
    [self.tableView reloadData];
}

-(void)initializeForm
{
    
    
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"CarInfoStep4"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    formDescriptor.assignFirstResponderOnShow = YES;
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"车型信息"];
    section.footerTitle = @" ";
    [formDescriptor addFormSection:section];
    
    // Car Structure
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCarStructure rowType:XLFormRowDescriptorTypeInfo title:@"车身结构"];
    [row.cellConfig setObject:[UIFont boldSystemFontOfSize:17] forKey:@"textLabel.font"];
    [section addFormRow:row];
    
    // Engine
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kEngine rowType:XLFormRowDescriptorTypeInfo title:@"发动机"];
    [row.cellConfig setObject:[UIFont boldSystemFontOfSize:17] forKey:@"textLabel.font"];
    [section addFormRow:row];
    
    // Drive type
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDriveType rowType:XLFormRowDescriptorTypeInfo title:@"驱动方式"];
    [row.cellConfig setObject:[UIFont boldSystemFontOfSize:17] forKey:@"textLabel.font"];
    [section addFormRow:row];
    
    // Transmission type
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTransmissionType rowType:XLFormRowDescriptorTypeInfo title:@"变速箱"];
    [row.cellConfig setObject:[UIFont boldSystemFontOfSize:17] forKey:@"textLabel.font"];
    [section addFormRow:row];

    // Warranty
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kWarranty rowType:XLFormRowDescriptorTypeInfo title:@"整车质保"];
    [row.cellConfig setObject:[UIFont boldSystemFontOfSize:17] forKey:@"textLabel.font"];
    [section addFormRow:row];

    
    // Information for maintenance - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"车辆信息"];
    section.footerTitle = @" ";
    [formDescriptor addFormSection:section];
    
    // Date of purchase
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDateOfPurchase rowType:XLFormRowDescriptorTypeDate title:@"购车日期"];
    [row.cellConfig setObject:[UIFont boldSystemFontOfSize:17] forKey:@"textLabel.font"];
    [section addFormRow:row];
    
    // Mileage
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMileage rowType:XLFormRowDescriptorTypeInteger title:@"行驶里程"];
    [row.cellConfig setObject:[UIFont boldSystemFontOfSize:17] forKey:@"textLabel.font"];
    [row.cellConfigAtConfigure setObject:[NSNumber numberWithInteger:NSTextAlignmentRight] forKey:@"textField.textAlignment"];
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"保养相关"];
    [formDescriptor addFormSection:section];
    
    // Load initial package
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kLoadInitialPackage rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"是否添加默认配件列表"];
    [row.cellConfig setObject:[UIFont boldSystemFontOfSize:17] forKey:@"textLabel.font"];
    row.value = [NSNumber numberWithBool:YES]; 
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@" "];
    [formDescriptor addFormSection:section];
    
    // Button
    XLFormRowDescriptor * buttonRow = [XLFormRowDescriptor formRowDescriptorWithTag:kSubmitButton rowType:XLFormRowDescriptorTypeButton title:@"添 加"];
    [buttonRow.cellConfig setObject:self.view.tintColor forKey:@"textLabel.textColor"];
    [buttonRow.cellConfig setObject:[UIFont boldSystemFontOfSize:18] forKey:@"textLabel.font"];
    [section addFormRow:buttonRow];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@" "];
    [formDescriptor addFormSection:section];

    
    self.form = formDescriptor;
    
}

-(void)didSelectFormRow:(XLFormRowDescriptor *)formRow
{
    [super didSelectFormRow:formRow];
    
    if ([formRow.tag isEqual:kSubmitButton]){
        if ([[NSDate date] compare:[self.form formRowWithTag:kDateOfPurchase].value] == NSOrderedAscending) {
            [PXAlertView showAlertWithTitle:@"日期填写错误"
                                    message:@"购车日期不得晚于当天日期"
                                cancelTitle:@"OK"
                                 completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                     if (cancelled) {
                                         NSLog(@"Cancel button pressed");
                                     }
                                 }];
            [self deselectFormRow:formRow];
            return;
        }
        
        NSNumber *mileage = [self.form formRowWithTag:kMileage].value;
        if (!mileage || ([mileage longValue] < 0 || [mileage longValue] > 1000000)) {
            [PXAlertView showAlertWithTitle:@"里程数填写错误"
                                    message:@"请填写有效行驶里程，且不得超过1000000公里"
                                cancelTitle:@"OK"
                                 completion:^(BOOL cancelled, NSInteger buttonIndex) {
                                     if (cancelled) {
                                         NSLog(@"Cancel button pressed");
                                     }
                                 }];
            [self deselectFormRow:formRow];
            return;
        }
        Cars *car = [Cars MR_createEntity];
        car.addedDate = [NSDate date];
        car.purchaseDate = [self.form formRowWithTag:kDateOfPurchase].value;
        car.whichModel = self.stepsController.results[KEY_SELECTED_MODEL];
        car.deleted = [NSNumber numberWithBool:NO];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        [self deselectFormRow:formRow];
        [self.stepsController showNextStep];
    }
}

@end
