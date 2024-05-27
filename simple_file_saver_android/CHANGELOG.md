## 2.0.1

* Fixed an error when receiving activity results from intents opened by the other packages (#1)

## 2.0.0

* BREAKING CHANGE: Conforms to the new API changes in the platform interface.
* It is now simplified into one single method `saveFile()` that takes a `FileSaveInfo` object created from wither `FileSaveInfo.fromBytes()` or `FileSaveInfo.fromUrl()`.

## 1.0.2

* Fix the return type of the native code.

## 1.0.1

* Platform interface updates.
* Returns non-nullable result.

## 1.0.0

* Initial open source release.
