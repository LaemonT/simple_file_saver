## 2.0.1

* Fixed an error in Android when receiving activity results from intents opened by the other packages ([#1](https://github.com/LaemonT/simple_file_saver/issues/1))

## 2.0.0

* BREAKING CHANGE: The API in now simplified into one single method `saveFile()` and an additional method `downloadLinkBuilder()` only for the web platform.
* The new API takes a `FileSaveInfo` object which you may create it from either `FileSaveInfo.fromBytes()` or `FileSaveInfo.fromUrl()`.

## 1.1.0

* Add web implementation to the plugin.

## 1.0.0

* Initial open source release.
