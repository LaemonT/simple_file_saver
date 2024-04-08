package com.laemont.simple_file_saver

import android.app.Activity
import android.content.ContentValues
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import java.io.File
import java.io.FileOutputStream
import java.io.IOException

/** SimpleFileSaverAndroidPlugin */
class SimpleFileSaverPlugin: FlutterPlugin, SimpleFileSaverApi, ActivityAware,
  PluginRegistry.ActivityResultListener {

  private lateinit var context: Context
  private lateinit var activity: Activity

  private lateinit var onFileSaved: (Result<Boolean>) -> Unit
  private lateinit var onFileSavedAs: (Result<Boolean>) -> Unit

  private var byteArray: ByteArray? = null

  companion object {
    const val CREATE_FILE = 1
    const val TAG = "SimpleFileSaverPlugin"
  }

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    try {
      SimpleFileSaverApi.setUp(binding.binaryMessenger, this)
      context = binding.applicationContext
    } catch (ex: Exception) {
      Log.e(TAG, "Received exception while setting up SimpleFileSaverPlugin", ex)
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    SimpleFileSaverApi.setUp(binding.binaryMessenger, null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivity() { }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() { }

  override fun saveFile(
    dataBytes: ByteArray,
    fileName: String,
    mimeType: String?,
    callback: (Result<Boolean>) -> Unit
  ) {
    onFileSaved = callback

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
      context.contentResolver.run {
        val values = ContentValues().apply {
          put(MediaStore.MediaColumns.DISPLAY_NAME, fileName)
          put(MediaStore.MediaColumns.MIME_TYPE, mimeType)
          put(MediaStore.MediaColumns.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS)
        }
        val uri = insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values)
          ?: throw IOException("Failed to create new MediaStore record.")
        openOutputStream(uri)?.use {
          it.write(dataBytes)
        } ?: throw IOException("Failed to open output stream.")
      }
      onFileSaved(Result.success(true))
    } else {
      val downloadDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
      val fos = FileOutputStream(File(downloadDir, fileName))
      fos.write(dataBytes)
      fos.close()
      onFileSaved(Result.success(true))
    }
  }

  override fun saveFileAs(
    dataBytes: ByteArray,
    fileName: String,
    mimeType: String?,
    callback: (Result<Boolean>) -> Unit
  ) {
    byteArray = dataBytes
    onFileSavedAs = callback

    val intent = Intent(Intent.ACTION_CREATE_DOCUMENT).apply {
      addCategory(Intent.CATEGORY_OPENABLE)
      type = mimeType
      putExtra(Intent.EXTRA_TITLE, fileName)
    }

    activity.startActivityForResult(intent, CREATE_FILE)
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, result: Intent?): Boolean {
    when (requestCode) {
      CREATE_FILE -> {
        when (resultCode) {
          Activity.RESULT_OK -> {
            result?.data?.also { uri ->
              context.contentResolver.openOutputStream(uri)?.use {
                it.write(byteArray)
                byteArray = null
              } ?: throw IOException("Failed to open output stream.")
            }
            onFileSavedAs(Result.success(true))
          }
          else -> {
            onFileSavedAs(Result.success(false))
          }
        }
        return true
      }
    }
    return false
  }

}
