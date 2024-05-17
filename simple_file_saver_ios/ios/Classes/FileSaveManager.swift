//
//  FileSaveManager.swift
//  simple_file_saver_ios
//
//  Created by Gary Lin on 2024/4/29.
//

import Flutter

final class FileSaveManager: NSObject, UIDocumentPickerDelegate {
    static let shared = FileSaveManager()

    private var result: FlutterResult?

    private var onFileSavedAs: ((Result<String?, Error>) -> Void)? = nil

    private var tempFileUrl: URL? = nil

    override private init() {}

    func getDocumentDirectory() throws -> String {
        return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).path
    }

    func saveFileAs(dataBytes: FlutterStandardTypedData, filenameWithExtension: String, completion: @escaping (Result<String?, Error>) -> Void) {
        onFileSavedAs = completion

        // Save the file to a temporary directory
        let tempFileUrl = FileManager.default.temporaryDirectory.appendingPathComponent(filenameWithExtension)
        do {
            try dataBytes.data.write(to: tempFileUrl)
        } catch {
            completion(Result.failure(error))
        }
        self.tempFileUrl = tempFileUrl

        // Use UIDocumentPickerViewController to move the file to a user specified place
        var docPickerVC: UIDocumentPickerViewController
        if #available(iOS 14.0, *) {
            docPickerVC = UIDocumentPickerViewController(forExporting: [tempFileUrl])
        } else {
            docPickerVC = UIDocumentPickerViewController(url: tempFileUrl, in: .exportToService)
        }
        docPickerVC.delegate = self

        // Present the UIDocumentPickerViewController
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            rootVC.present(docPickerVC, animated: true)
        }
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        deleteTempFile()
        onFileSavedAs?(Result.success(nil))
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        deleteTempFile()
        onFileSavedAs?(Result.success(url.path))
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        deleteTempFile()
        onFileSavedAs?(Result.success(urls[0].path))
    }

    // Delete the temporary file
    func deleteTempFile() {
        if tempFileUrl != nil {
            do {
                if FileManager.default.fileExists(atPath: tempFileUrl!.path) {
                    try FileManager.default.removeItem(at: tempFileUrl!)
                }
            } catch {
                onFileSavedAs?(Result.failure(error))
            }
        }
    }
}
