//
//  CHDropDownTextField.h
//  DPIM
//
//  Created by Rogelio Gudino on 5/22/14.
//  Copyright (c) 2014 ChaiOne. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CHDropDownTextFieldDelegate;

/**
 A DPIM stylized textfield that has a drop-down as an additional input method to the keyboard.
 */
@interface CHDropDownTextField : UITextField

/**
 Array of strings to be shown as titles in the drop down table.
 */
@property (nonatomic, copy) NSArray *dropDownTableTitlesArray;

/**
 Array of string to be shown as subtitles in the drop down table.
 
 The number of objects in this array must match the number of objects in the `dropDownTableTitlesArray` array, otherwise subtitle labels will be hidden.
 
 @see dropDownTableTitlesArray
 */
@property (nonatomic, copy) NSArray *dropDownTableSubtitlesArray;

/**
 Indicates whether the textfield allows text to be pasted. Defaults to YES.
 */
@property (nonatomic, assign) BOOL canPaste;

/**
 Indicates the drop-down's number of visible rows at a time. Defaults to 0.
 */
@property (nonatomic, assign) NSInteger dropDownTableVisibleRowCount;

/**
 The drop-down table.
 */
@property (nonatomic, strong, readonly) UITableView *dropDownTableView;

/**
 The receiver’s drop-down delegate.
 */
@property (nonatomic, assign) id<CHDropDownTextFieldDelegate> dropDownDelegate;

@end

/**
 Defines delegate methods to define the content of the textfield's drop-down as well as a callback method to communicate the chosen option.
 */
@protocol CHDropDownTextFieldDelegate <NSObject>

@required

/**
 Tells the delegate that an option was chosen at a given index. After this call, the textfield resigns as first responder.
 
 @param dropDownTextField The textfield object that's calling the delegate.
 @param index The index of the selected option.
 */
- (void)dropDownTextField:(CHDropDownTextField *)dropDownTextField didChooseDropDownOptionAtIndex:(NSUInteger)index;

@end
