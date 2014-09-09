
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
    [section addFormRow:row];
    
    // Engine
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kEngine rowType:XLFormRowDescriptorTypeInfo title:@"发动机"];
    [section addFormRow:row];
    
    // Drive type
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDriveType rowType:XLFormRowDescriptorTypeInfo title:@"驱动方式"];
    [section addFormRow:row];
    
    // Transmission type
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTransmissionType rowType:XLFormRowDescriptorTypeInfo title:@"变速箱"];
    [section addFormRow:row];

    // Warranty
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kWarranty rowType:XLFormRowDescriptorTypeInfo title:@"整车质保"];
    [section addFormRow:row];

    
    // Information for maintenance - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"车辆信息"];
    section.footerTitle = @" ";
    [formDescriptor addFormSection:section];
    
    // Date of purchase
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDateOfPurchase rowType:XLFormRowDescriptorTypeDate title:@"购车日期"];
    // [row.cellConfigAtConfigure setObject:[NSDate date] forKey:@"datePi"];
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
    [formDescriptor addFormSection:section];
    
    // Button
    XLFormRowDescriptor * buttonRow = [XLFormRowDescriptor formRowDescriptorWithTag:kSubmitButton rowType:XLFormRowDescriptorTypeButton title:@"添加"];
    [buttonRow.cellConfig setObject:self.view.tintColor forKey:@"textLabel.textColor"];
    [section addFormRow:buttonRow];
    
    self.form = formDescriptor;
    
}



@end
