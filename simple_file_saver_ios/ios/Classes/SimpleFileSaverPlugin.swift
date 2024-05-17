import Flutter
import UIKit

public class SimpleFileSaverPlugin: NSObject, FlutterPlugin, SimpleFileSaverApi {
    public static func register(with registrar: FlutterPluginRegistrar) {
        SimpleFileSaverApiSetup.setUp(binaryMessenger: registrar.messenger(), api: SimpleFileSaverPlugin())
    }

    func getDocumentDirectory() throws -> String {
        return try FileSaveManager.shared.getDocumentDirectory()
    }

    func saveFileAs(dataBytes: FlutterStandardTypedData, filenameWithExtension: String, completion: @escaping (Result<String?, any Error>) -> Void) {
        FileSaveManager.shared.saveFileAs(dataBytes: dataBytes, filenameWithExtension: filenameWithExtension, completion: completion)
    }
}
