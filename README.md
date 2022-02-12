- ~~GUIElement~~
- ~~GUIWindow~~
- ~~GUIButton~~
- ~~GUICheckbox~~
- ~~GUIInput~~
- ~~GUIImage~~
- ~~GUILabel~~
- ~~GUITabPanel~~
- ~~GUITextArea~~
- ~~GUISlider~~
- ~~GUIProgressBar~~

- GUICombobox
- GUIChanger
- GUIRadioButton
- GUIRadioButtonGroup
- GUIGridList
- GUIGridListItem

GUIWindow
- ToggleMoving()

GUIInput
- ~~Events: Focus, Unfocus~~
- ~~Handling player input enable/disable~~
- ~~SetPlaceholder()~~
- ~~GetPlaceholder()~~
- ~~SetMaxLength()~~
- SetMaxValue() <- maybe second class just for numbers
- ESC Menu and ChatBox can cause issues with player input handling!!

GUILabel
- SetAlignX()
- SetAlignY()
- SetClickable()

GUICombobox
- AddItem(key, value)
- RemoveItem(key)
- GetItemCount()
- GetSelectedKey()
- SetSelectedKey()

GUIChanger
- AddItem(key, value)
- RemoveItem(key)
- GetItemCount()
- GetSelectedKey()
- SetSelectedKey()

GUIRadioButton
- SetEnabled()
- IsEnabled()
- IsChecked()
- SetChecked()

GUIRadioButtonGroup
- AddRadioButton()
- RemoveRadioButton()
- GetSelectedRadioButton()

GUIGridList
- AddItem()
- RemoveItem()
- GetItemCount()

GUIGridListItem
- SetText()
