import Flutter
import UIKit

public class SimpleFileSaverPlugin: NSObject, FlutterPlugin, SimpleFileSaverApi {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        SimpleFileSaverApiSetup.setUp(binaryMessenger: registrar.messenger(), api: SimpleFileSaverPlugin())
    }
    
    func saveFile(dataBytes: FlutterStandardTypedData, fileName: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            let fileUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(fileName)
            print("fileUrl: \(fileUrl)")
            try dataBytes.data.write(to: fileUrl)
            completion(Result.success(true))
        } catch {
            completion(Result.failure(error))
        }
    }
    
    func saveFileAs(dataBytes: FlutterStandardTypedData, fileName: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let tempFileUrl = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        do {
            try dataBytes.data.write(to: tempFileUrl)
        } catch {
            completion(Result.failure(error))
        }
        
        let avc = UIActivityViewController(activityItems: [tempFileUrl], applicationActivities: nil)
        avc.excludedActivityTypes = [.airDrop, .postToTwitter, .assignToContact, .postToFlickr, .postToWeibo, .postToTwitter]
        avc.completionWithItemsHandler = { activity, success, items, error in
            completion(Result.success(success))
        }
        
        if let rvc = UIApplication.shared.keyWindow?.rootViewController {
            rvc.present(avc, animated: true)
        }
    }
    
}
