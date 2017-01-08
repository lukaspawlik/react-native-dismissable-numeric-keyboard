# React Native Dismissable Numeric Keyboard

Add extra button to numeric keyboard to allow user dismiss it.
To enable this integration `TextInput` component has to contain `keyboardType` and `returnKeyType` props.

This supports only iOS as this module does not contain any Android file.

##Installation
```
npm install --save react-native-closeable-numeric-keyboard
rnpm link
```

##Sample usage in code
```
<TextInput
	autoCapitalize={ true }
	autoCorrect={ true }
	placeholder="Some placeholder text"
	returnKeyType={ returnKeyType }
	keyboardType="numeric"
/>
```

where `returnKeyType` can be one of supported return key types.

#### returnKeyType values
    - done
    - search
    - save
    - add
    - edit

##Changelog
    + v0.0.1

        First release