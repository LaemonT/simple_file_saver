export 'src/widget_none.dart' // Stub implementation
    if (dart.library.io) 'src/widget_io.dart' // dart:io implementation
    if (dart.library.html) 'src/widget_web.dart'; // package:web implementation
