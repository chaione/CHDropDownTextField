//
//  CHViewController.m
//  CHDropDownTextFieldExample
//
//  Copyright (c) 2014 ChaiOne <http://www.chaione.com/>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "CHViewController.h"
#import "CHDropDownTextField.h"
#import "CHCustomTableViewCell.h"
#import "CHDropDownTextFieldTableViewCell.h"

@interface CHViewController () <CHDropDownTextFieldDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet CHDropDownTextField *dropDownTextField;
@property (nonatomic, weak) IBOutlet UISwitch *useCustomCellSwitch;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSMutableArray *filteredTitlesArray;

@end

@implementation CHViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupGestureRecognizer];
    [self setupDropDownTextField];
    [self setupStyling];
}

- (void)setupGestureRecognizer {
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasTapped:)];
    tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)setupDropDownTextField {
    
    self.titlesArray = @[ @"First", @"Second", @"Third", @"Fourth", @"Fifth", @"Sixth" ];
    self.filteredTitlesArray = [self.titlesArray mutableCopy];
    self.dropDownTextField.dropDownTableVisibleRowCount = 4;
    self.dropDownTextField.dropDownTableTitlesArray = self.filteredTitlesArray;
}

- (void)setupStyling {
    
    self.dropDownTextField.cellClass = [CHCustomTableViewCell class];
    self.dropDownTextField.dropDownTableView.backgroundColor = [UIColor whiteColor];
    self.dropDownTextField.dropDownTableView.layer.masksToBounds = NO;
    self.dropDownTextField.dropDownTableView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.dropDownTextField.dropDownTableView.layer.shadowOpacity = 0.45f;
    self.dropDownTextField.dropDownTableView.layer.shadowOffset = CGSizeMake(0, 3.0f);
    self.dropDownTextField.dropDownTableView.layer.shadowRadius = 2.0f;
}

#pragma mark - Action Methods

- (void)viewWasTapped:(UITapGestureRecognizer *)sender {
    
    [self.view endEditing:YES];
}

- (IBAction)useCustomCellSwitchValueChanged:(UISwitch *)sender {
    
    if (self.dropDownTextField.cellClass == [CHCustomTableViewCell class]) {
        self.dropDownTextField.cellClass = [CHDropDownTextFieldTableViewCell class];
    } else {
        self.dropDownTextField.cellClass = [CHCustomTableViewCell class];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([self.dropDownTextField isFirstResponder]) {
        CGPoint touchPoint = [touch locationInView:self.dropDownTextField];
        
        if (CGRectContainsPoint(self.dropDownTextField.dropDownTableView.frame, touchPoint)) {
            
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *finalString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.filteredTitlesArray = [self.titlesArray mutableCopy];
    
    if (finalString.length != 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", finalString];
        [self.filteredTitlesArray filterUsingPredicate:predicate];
    }
    
    self.dropDownTextField.dropDownTableTitlesArray = self.filteredTitlesArray;
    
    return YES;
}

#pragma mark - CHDropDownTextFieldDelegate

- (void)dropDownTextField:(CHDropDownTextField *)dropDownTextField didChooseDropDownOptionAtIndex:(NSUInteger)index {
    
    self.dropDownTextField.text = self.filteredTitlesArray[index];
}

@end
