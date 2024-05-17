## 2.0.0

* BREAKING CHANGE: The platform interface API in now simplified into one single method `saveFile()` and an additional method `downloadLinkBuilder()` only for the web platform.
* The new API takes a `FileSaveInfo` object which you may create it from either `FileSaveInfo.fromBytes()` or `FileSaveInfo.fromUrl()`.

## 1.3.0

* Return the path of the file saved instead of a boolean.

## 1.2.0

* Add new platform APIs for the web implementation, and updates the download APIs.

## 1.1.2

* Remove the mimeType parameter for the downloadFileByUrl() API.

## 1.1.1

* Return non-nullable boolean.

## 1.1.0

* Add new platform APIs for the web implementation.

## 1.0.0

* Initial open source release.
