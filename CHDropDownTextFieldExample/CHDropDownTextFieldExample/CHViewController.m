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

@interface CHViewController () <CHDropDownTextFieldDelegate, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet CHDropDownTextField *dropDownTextField;
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
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)setupDropDownTextField {
    
    self.titlesArray = @[ @"First", @"Second", @"Third", @"Fourth", @"Fifth", @"Sixth" ];
    self.filteredTitlesArray = [self.titlesArray mutableCopy];
    self.dropDownTextField.dropDownTableVisibleRowCount = 4;
    self.dropDownTextField.dropDownTableTitlesArray = self.filteredTitlesArray;
}

- (void)setupStyling {
    
    self.dropDownTextField.dropDownTableView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.dropDownTextField.dropDownTableView.layer.shadowOpacity = 0.45f;
    self.dropDownTextField.dropDownTableView.layer.shadowOffset = CGSizeMake(0, 3.0f);
    self.dropDownTextField.dropDownTableView.layer.shadowRadius = 2.0f;
}

#pragma mark - Action Methods

- (void)viewWasTapped:(UITapGestureRecognizer *)sender {
    
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
}

#pragma mark - CHDropDownTextFieldDelegate

- (void)dropDownTextField:(CHDropDownTextField *)dropDownTextField didChooseDropDownOptionAtIndex:(NSUInteger)index {
    
}

@end
