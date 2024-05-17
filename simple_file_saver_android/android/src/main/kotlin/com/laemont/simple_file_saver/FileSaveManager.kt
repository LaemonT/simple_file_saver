package com.laemont.simple_file_saver

import android.app.Activity
import android.content.ContentValues
import android.content.Intent
import android.os.Build
import android.os.Environment
import android.provider.DocumentsContract
import android.provider.MediaStore
import io.flutter.plugin.common.PluginRegistry
import java.io.File
import java.io.FileOutputStream
import java.io.IOException

class FileSaveManager(var activity: Activity) :
    PluginRegistry.ActivityResultListener {

    private var onFileSavedAs: ((String?) -> Unit)? = null
    private var byteArray: ByteArray? = null

    companion object {
        const val CREATE_FILE = 1
    }

    fun saveToDownloads(
        dataBytes: ByteArray,
        filenameWithExtension: String,
    ): String? {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            activity.contentResolver.run {
                val values = ContentValues().apply {
                    put(MediaStore.MediaColumns.DISPLAY_NAME, filenameWithExtension)
                    put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS)
                }

                val uri = insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values)
                    ?: throw IOException("Failed to create new MediaStore record.")

                // Write file data bytes
                openOutputStream(uri)?.use {
                    it.write(dataBytes)
                } ?: throw IOException("Failed to open output stream.")
 
//                query(uri, null, null, null, null)?.use {
//                    it.moveToFirst()
//                    val columnIndex = it.getColumnIndexOrThrow(MediaStore.MediaColumns.DATA)
//                    return it.getString(columnIndex)
//                } ?: throw IOException("Failed to query the MediaStore.")

                return uri.path
            }
        } else {
            val directory =
                Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
            var file = File(directory, filenameWithExtension)

            // Check file existence and avoid duplication
            val basename = file.nameWithoutExtension
            val extension = file.extension
            var count = 1
            while (file.exists()) {
                file = File(directory, "$basename ($count).$extension")
                count++
            }

            // Write file data bytes
            FileOutputStream(file).use {
                it.write(dataBytes)
            }
            return file.path
        }
    }

    fun saveFileAs(
        dataBytes: ByteArray,
        filenameWithExtension: String,
        mimeType: String?,
        onSaved: (String?) -> Unit
    ) {
        byteArray = dataBytes
        onFileSavedAs = onSaved

        val intent = Intent(Intent.ACTION_CREATE_DOCUMENT).apply {
            addCategory(Intent.CATEGORY_OPENABLE)
            putExtra(Intent.EXTRA_TITLE, filenameWithExtension)

            // Default to "text/plain", otherwise ActivityNotFoundException will be thrown
            // if the MIME type is null or not specified.
            setTypeAndNormalize(mimeType ?: "text/plain")

            // Optionally, specify a URI for the directory that should be opened in
            // the system file picker before your app creates the document.
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                putExtra(
                    DocumentsContract.EXTRA_INITIAL_URI,
                    Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS),
                )
            }
        }

        activity.startActivityForResult(intent, CREATE_FILE)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, result: Intent?): Boolean {
        require(onFileSavedAs != null) { "onFileSavedAs callback is NULL" }

        when (requestCode) {
            CREATE_FILE -> {
                when (resultCode) {
                    Activity.RESULT_OK -> {
                        val uri = result?.data ?: throw IOException("Failed to create the file.")

                        activity.contentResolver.openOutputStream(uri)?.use {
                            it.write(byteArray)
                            byteArray = null
                        } ?: throw IOException("Failed to open output stream.")

                        onFileSavedAs!!(uri.path)
                    }

                    else -> {
                        onFileSavedAs!!(null)
                    }
                }
                return true
            }
        }
        return false
    }

}