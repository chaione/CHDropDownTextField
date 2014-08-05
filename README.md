
# CHDropDownTextField

A custom text field with drop-down support.

[![Version](https://cocoapod-badges.herokuapp.com/v/CHDropDownTextField/badge.png)](http://cocoadocs.org/docsets/CHDropDownTextField)
[![Platform](https://cocoapod-badges.herokuapp.com/p/CHDropDownTextField/badge.png)](http://cocoadocs.org/docsets/CHDropDownTextField)

<img src="https://github.com/chaione/CHDropDownTextField/raw/master/Misc/animation01.gif" width=320>

## Installation

### CocoaPods

CHDropDownTextField is available through [CocoaPods](http://cocoapods.org), to install it simply add the following line to your Podfile:

`pod "CHDropDownTextField"`

### Manually

To install manually, just copy everything in the `CHDropDownTextField` directory into your Xcode project.

_**Important:**_ If your project doesn't use ARC you must add the `-fobjc-arc` compiler flag to all CHCircleGaugeView implementation files in Target Settings > Build Phases > Compile Sources.

## Usage

1. Instantiate manually or through a storyboard/xib.
2. Set the number of visible rows for the drop-down to display at a time: `self.dropDownTextField.dropDownTableVisibleRowCount = 4;`
3. Set an array of strings for the drop-down to display: `self.dropDownTextField.dropDownTableTitlesArray = self.stringsArray;`
4. Set yourself up as the drop-down delegate through `dropDownDelegate`. Note that this delegate is separate from the regular `UITextField`'s delegate.
5. Implement `dropDownTextField:didChooseDropDownOptionAtIndex:`.

#### Optional

**Custom Cells**

The default cell is not flexible at all. If you wish to customize the style of the cells you need to create a custom cell subclass and set the `cellClass`:

```
self.dropDownTextField.cellClass = [MyCustomTableViewCell class];
```

*Warning:* The text field will still use the native `textLabel` and `detailTextLabel`.

**Subtitles**

The default drop-down cells support subtitles by default (using `UITableViewCellStyleValue1` style). To show subtitles you just need to set the `dropDownTableSubtitlesArray` property to an array of strings with the same amount of strings as the `dropDownTableTitlesArray`, otherwise the subtitles won't show.

If you choose to use a custom cell, your custom cell subclass should override `initWithStyle:reuseIdentifier:` and call super by enforcing a style. For example;

```
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    return [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
}
```

**Styling**

Feel free to customize the text field's `dropDownTableView` as you wish with a few exceptions:

* Do not take over data source or delegation.
* Do not remove the tableview from the view hierarchy.
* Do not modify the tableview's positioning and size.

## Contributing

Pull request are welcomed. To add functionality or to make changes:

1. Fork this repo.
2. Open `CHDropDownTextField.xcodeproj` in the `CHDropDownTextFieldExample` directory.
3. Make changes to the necessary files in the `CHDropDownTextField` group.
4. Ensure new public methods are documented.
5. Submit a pull request.

## Authors

Created by [Osama Ashawa](http://oashawa.com/), [Matthew Morey](http://matthewmorey.com), [Rogelio Gudino](http://cananito.com/), and other [contributors](https://github.com/chaione/CHCircleGaugeView/graphs/contributors).

## License

CHDropDownTextField is available under the MIT license. See the [LICENSE](https://github.com/chaione/CHDropDownTextField/blob/master/LICENSE) file for more information. If you're using CHDropDownTextField in your project, attribution would be nice.
