//
//  CHDropDownTextField.m
//  CHDropDownTextField
//
//  Created by Rogelio Gudino on 5/22/14.
//  Copyright (c) 2014 ChaiOne. All rights reserved.
//

#import "CHDropDownTextField.h"
#import "CHDropDownTextFieldTableViewCell.h"

static NSString * const CHDropDownTextFieldTableViewCellIdentifier = @"CHTextFieldDropDownTableViewCellIdentifier";
static CGFloat const CHDropDownTextFieldTableViewCellHeight = 44.0;
static CGFloat const CHDropDownTableViewSidePadding = 0;

@interface CHDropDownTextField () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *dropDownTableView;

@end

@implementation CHDropDownTextField

- (instancetype)init {
    
    return [self initWithCellClass:[CHDropDownTextFieldTableViewCell class]];
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initSetup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initSetup];
    }
    
    return self;
}

- (instancetype)initWithCellClass:(Class)cellClass {
    
    self = [super init];
    
    if (self) {
        [self initSetup];
        _cellClass = cellClass;
    }
    
    return self;
}

- (void)initSetup {
    
    self.clipsToBounds = NO;
    _canPaste = YES;
    _cellClass = [CHDropDownTextFieldTableViewCell class];
}

#pragma mark - Setters

- (void)setCellClass:(Class)cellClass {
    
    if (_cellClass != cellClass) {
        _cellClass = cellClass;
        [self.dropDownTableView reloadData];
    }
}

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
        [_dropDownTableView registerClass:self.cellClass forCellReuseIdentifier:CHDropDownTextFieldTableViewCellIdentifier];
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
    frame.origin.x = CHDropDownTableViewSidePadding;
    frame.origin.y = CGRectGetHeight(self.bounds);
    frame.size.width = CGRectGetWidth(self.bounds) - (CHDropDownTableViewSidePadding * 2);
    frame.size.height = self.dropDownTableVisibleRowCount * CHDropDownTextFieldTableViewCellHeight;
    self.dropDownTableView.frame = frame;
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHDropDownTextFieldTableViewCellIdentifier];
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
