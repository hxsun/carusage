
#import "XLForm.h"
#import "CarInfoStep4VC.h"
#import "RMStepsController.h"
#import "CarAddingConstant.h"
#import "Models.h"

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
    
    [self initializeForm:self.stepsController.results];
    self.tableView.sectionHeaderHeight = 44;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self){
        [self initializeForm:self.stepsController.results];
    }
    return self;
}

/*
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initializeForm:self.stepsController.results];
    }
    return self;
}
 */

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)initializeForm:(NSDictionary *)sessionDictionary
{
    Models *model = sessionDictionary[KEY_SELECTED_MODEL];
    
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"Text Fields"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    formDescriptor.assignFirstResponderOnShow = YES;
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"车型信息"];
    section.footerTitle = @" ";
    [formDescriptor addFormSection:section];
    
    // Car Structure
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCarStructure rowType:XLFormRowDescriptorTypeInfo title:@"车身结构"];
    // row.disabled = YES;
    [section addFormRow:row];
    
    // Engine
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kEngine rowType:XLFormRowDescriptorTypeInfo title:@"发动机"];
    // row.disabled = YES;
    row.value = model.engine;
    [section addFormRow:row];
    
    // Drive type
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDriveType rowType:XLFormRowDescriptorTypeInfo title:@"驱动方式"];
    // row.disabled = YES;
    row.value = model.driveType;
    [section addFormRow:row];
    
    // Transmission type
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTransmissionType rowType:XLFormRowDescriptorTypeInfo title:@"变速箱"];
    // row.disabled = YES;
    row.value = model.transmissionType;
    [section addFormRow:row];

    // Warranty
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kWarranty rowType:XLFormRowDescriptorTypeInfo title:@"整车质保"];
    // row.disabled = YES;
    [section addFormRow:row];

    
    // Information for maintenance - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"车辆信息"];
    section.footerTitle = @" ";
    [formDescriptor addFormSection:section];
    
    // Date of purchase
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDateOfPurchase rowType:XLFormRowDescriptorTypeDate title:@"购车日期"];
    row.value = [NSDate date];
    [section addFormRow:row];
    
    // Mileage
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kMileage rowType:XLFormRowDescriptorTypeInteger title:@"行驶里程"];
    [row.cellConfigAtConfigure setObject:[NSNumber numberWithInteger:NSTextAlignmentRight] forKey:@"textField.textAlignment"];
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"保养相关"];
    [formDescriptor addFormSection:section];
    
    // Load initial package
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kLoadInitialPackage rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"是否添加默认配件列表"];
    row.value = [NSNumber numberWithBool:YES];
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@" "];
    // section.footerTitle = @"Button will show a message when Switch is ON";
    [formDescriptor addFormSection:section];
    
    // Button
    XLFormRowDescriptor * buttonRow = [XLFormRowDescriptor formRowDescriptorWithTag:kSubmitButton rowType:XLFormRowDescriptorTypeButton title:@"添加"];
    [buttonRow.cellConfig setObject:self.view.tintColor forKey:@"textLabel.textColor"];
    [section addFormRow:buttonRow];
    
    self.form = formDescriptor;
    
}



@end
