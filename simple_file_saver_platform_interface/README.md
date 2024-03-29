# simple_file_saver_platform_interface

A common platform interface for the [`simple_file_saver`][1] plugin.

This interface allows platform-specific implementations of the `simple_file_saver`
plugin, as well as the plugin itself, to ensure they are supporting the
same interface.

You may read the [Flutter documentation](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#federated-plugins) and watch the [Flutter channel](https://youtu.be/GAnSNplNpCA) 
for more information about the federated plugin concept.

# Usage

To implement a new platform-specific implementation of `simple_file_saver`, extend
[`SimpleFileSaverPlatform`][2] with an implementation that performs the
platform-specific behavior, and when you register your plugin, set the default
`SimpleFileSaverPlatform` by calling
`SimpleFileSaverPlatform.instance = SimpleFileSaverX()`.

[1]: ../
[2]: lib/simple_file_saver_platform_interface.dart