//
//  CHViewController.m
//  CHDropDownTextFieldExample
//
//  Created by Rogelio Gudino on 8/1/14.
//  Copyright (c) 2014 ChaiOne. All rights reserved.
//

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
