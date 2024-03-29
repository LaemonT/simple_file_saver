# Flutter simple_file_saver plugin

The [`simple_file_saver`][0] plugin is built with the Flutter's federated architecture. 

You may read the [Flutter documentation](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#federated-plugins) and watch the [Flutter channel](https://youtu.be/GAnSNplNpCA)
for more information about the federated plugin concept.

The plugin is separated into the following packages:

1. [`simple_file_saver`][1]: the app facing package. This is the package users depend on to use the plugin in their project.
2. [`simple_file_saver_android`][2]: this package contains the endorsed Android implementation of the [`simple_file_saver_platform_interface`][4] and adds Android support to the [`simple_file_saver`][1] app facing package.
3. [`simple_file_saver_ios`][3]: this package contains the endorsed iOS implementations of the [`simple_file_saver_platform_interface`][4] and adds iOS support to the [`simple_file_saver`][1] app facing package.
4. [`simple_file_saver_platform_interface`][4]: this package declares the interface which all platform packages must implement to support the app-facing package.

[0]: https://pub.dev/packages/simple_file_saver
[1]: ./simple_file_saver
[2]: ./simple_file_saver_android
[3]: ./simple_file_saver_ios
[4]: ./simple_file_saver_platform_interface