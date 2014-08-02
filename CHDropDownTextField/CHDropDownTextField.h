//
//  CHDropDownTextField.h
//  CHDropDownTextField
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

#import <UIKit/UIKit.h>

@protocol CHDropDownTextFieldDelegate;

/**
 A textfield that has a drop-down as an additional input method to the keyboard.
 */
@interface CHDropDownTextField : UITextField

/**
 Designated initializer.
 
 @param cellClass The class to be used by the internal table view to dequeue cells. Defaults to `CHDropDownTextFieldTableViewCell`.
 */
- (instancetype)initWithCellClass:(Class)cellClass;

/**
 The class to be used by the internal table view to dequeue cells. Defaults to `CHDropDownTextFieldTableViewCell`.
 */
@property (nonatomic, assign) Class cellClass;

/**
 Array of strings to be shown as titles in the drop down table. Setting this will cause the table view to reload its data.
 */
@property (nonatomic, copy) NSArray *dropDownTableTitlesArray;

/**
 Array of string to be shown as subtitles in the drop down table. Setting this will cause the table view to reload its data.
 
 The number of objects in this array must match the number of objects in the `dropDownTableTitlesArray` array, otherwise subtitle labels will be hidden in the case of having a cell that supports subtitles.
 
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
 
 @warning Use only for visual customization. To reload the data, re-set `dropDownTableTitlesArray` and `dropDownTableSubtitlesArray` as needed.
 
 @see dropDownTableTitlesArray
 @see dropDownTableSubtitlesArray
 */
@property (nonatomic, strong, readonly) UITableView *dropDownTableView;

/**
 The receiver’s drop-down delegate.
 */
@property (nonatomic, assign) IBOutlet id<CHDropDownTextFieldDelegate> dropDownDelegate;

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
