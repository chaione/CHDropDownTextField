//
//  CHDropDownTextField.m
//  DPIM
//
//  Created by Rogelio Gudino on 5/22/14.
//  Copyright (c) 2014 ChaiOne. All rights reserved.
//

#import "CHDropDownTextField.h"
#import "CHDropDownTextFieldTableViewCell.h"

static NSString * const DPIMDropDownTextFieldTableViewCellIdentifier = @"DPIMTextFieldDropDownTableViewCellIdentifier";
static CGFloat const DPIMDropDownTextFieldTableViewCellHeight = 44.0;
static CGFloat const DPIMDropDownTableViewSidePadding = 0;

@interface CHDropDownTextField () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *dropDownTableView;

@end

@implementation CHDropDownTextField

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        _canPaste = YES;
    }
    
    return self;
}

#pragma mark - Setters

- (void)setDropDownTableTitlesArray:(NSArray *)dropDownTableTitlesArray {
    
    if (_dropDownTableTitlesArray != dropDownTableTitlesArray) {
        _dropDownTableTitlesArray = dropDownTableTitlesArray;
        [self.dropDownTableView reloadData];
    }
}

- (void)setDropDownTableSubtitlesArray:(NSArray *)dropDownTableSubtitlesArray {
    
    if (_dropDownTableSubtitlesArray != dropDownTableSubtitlesArray) {
        _dropDownTableSubtitlesArray = dropDownTableSubtitlesArray;
        [self.dropDownTableView reloadData];
    }
}

- (void)setDropDownTableVisibleRowCount:(NSInteger)dropDownTableVisibleRowCount {
    
    if (_dropDownTableVisibleRowCount != dropDownTableVisibleRowCount) {
        _dropDownTableVisibleRowCount = dropDownTableVisibleRowCount;
        [self layoutDropDownTableView];
    }
}

#pragma mark - Accessors

- (UITableView *)dropDownTableView {
    
    if (_dropDownTableView == nil) {
        _dropDownTableView = [[UITableView alloc] init];
        _dropDownTableView.translatesAutoresizingMaskIntoConstraints = NO;
        [_dropDownTableView registerClass:[CHDropDownTextFieldTableViewCell class] forCellReuseIdentifier:DPIMDropDownTextFieldTableViewCellIdentifier];
        _dropDownTableView.scrollEnabled = NO;
        _dropDownTableView.dataSource = self;
        _dropDownTableView.delegate = self;
        [self layoutDropDownTableView];
    }
    
    return _dropDownTableView;
}

#pragma mark - Overridden Methods

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self layoutDropDownTableView];
}

- (void)layoutDropDownTableView {
    
    // UITextField's layoutSubviews doesn't play well with adding custom constraints.
    // This causes a crash when popping a VC that has this textfield as the first responder.
    // The cheapest way out is to manually layout the drop-down table.
    CGRect frame = CGRectZero;
    frame.origin.x = DPIMDropDownTableViewSidePadding;
    frame.origin.y = CGRectGetHeight(self.bounds);
    frame.size.width = CGRectGetWidth(self.bounds) - (DPIMDropDownTableViewSidePadding * 2);
    frame.size.height = self.dropDownTableVisibleRowCount * DPIMDropDownTextFieldTableViewCellHeight;
    self.dropDownTableView.frame = frame;
    
    // Table Shadow
    self.dropDownTableView.layer.masksToBounds = NO;
    self.dropDownTableView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.dropDownTableView.layer.shadowOpacity = 0.55f;
    self.dropDownTableView.layer.shadowOffset = CGSizeMake(0, 7.0f);
    self.dropDownTableView.layer.shadowRadius = 4.0f;
}

- (BOOL)becomeFirstResponder {
    
    [self addAndDisplayDropdown];
    
    return [super becomeFirstResponder];
}

- (void)addAndDisplayDropdown {
    
    [self addSubview:self.dropDownTableView];
    [self layoutDropDownTableView];
    [self.dropDownTableView reloadData];
}

- (BOOL)resignFirstResponder {
    
    [self.dropDownTableView removeFromSuperview];
    
    return [super resignFirstResponder];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if ([self isDropDownTableViewOnScreen] && CGRectContainsPoint(self.dropDownTableView.frame, point)) {
        return self.dropDownTableView;
    }
    
    return [super hitTest:point withEvent:event];
}

- (BOOL)isDropDownTableViewOnScreen {
    
    if (self.dropDownTableView.superview != nil) {
        return YES;
    }
    
    return NO;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if (self.canPaste == NO && action == @selector(paste:)) {
        
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dropDownTableTitlesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CHDropDownTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DPIMDropDownTextFieldTableViewCellIdentifier];
    NSString *title = [self.dropDownTableTitlesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    
    if ([self dropDownSubtitlesShouldBeShown] == YES) {
        cell.detailTextLabel.text = [self.dropDownTableSubtitlesArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (BOOL)dropDownSubtitlesShouldBeShown {
    
    if ([self.dropDownTableSubtitlesArray count] == [self.dropDownTableTitlesArray count]) {
        return YES;
    }
    
    return NO;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.dropDownDelegate dropDownTextField:self didChooseDropDownOptionAtIndex:indexPath.row];
    [self resignFirstResponder];
}

@end
