## 2.0.0+2

* Null safety

## 1.1.1+4

* Updated FBSDK v7 to v9

## 1.1.1+3

* Updated FBSDK v5 to v7
* Added MIT License

## 1.1.0+1

* Fixed an error caused from iterating on a null data.

## 1.1.0

* BREAKING CHANGE: it's not necessary anymore to split the code for Android and iOS. In either cases it will return `null` when any deferred deep link is available, or a map containing `deeplink` and `promotionalCode`. The `promotionalCode` can be `null`.
* README: adding important notes on how to manage user privacy using this plugin.

## 1.0.2+1

* Removed Log from Java code.

## 1.0.2

* Fixed a bug on Android where the Future does not complete when no deferred deep link is retrieved. Not it returns `null`.

## 1.0.1+1

* Removed the deprecated `author:` field from pubspec.yaml

## 1.0.1

* Added example code.

## 1.0.0

* Initial release.
