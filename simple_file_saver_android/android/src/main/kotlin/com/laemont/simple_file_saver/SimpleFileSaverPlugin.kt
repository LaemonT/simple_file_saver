package com.laemont.simple_file_saver

import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import java.io.IOException

/** SimpleFileSaverAndroidPlugin */
class SimpleFileSaverPlugin : FlutterPlugin, SimpleFileSaverApi, ActivityAware {

    private var fileSaveManager: FileSaveManager? = null
    private var activityBinding: ActivityPluginBinding? = null

    companion object {
        const val TAG = "SimpleFileSaverPlugin"
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        try {
            SimpleFileSaverApi.setUp(binding.binaryMessenger, this)
        } catch (ex: Exception) {
            Log.e(TAG, "Received exception while setting up SimpleFileSaverPlugin", ex)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        SimpleFileSaverApi.setUp(binding.binaryMessenger, null)
        cleanUpOnDetached()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        bindOnAttached(binding)
    }

    override fun onDetachedFromActivity() {
        cleanUpOnDetached()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        bindOnAttached(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        cleanUpOnDetached()
    }

    private fun bindOnAttached(binding: ActivityPluginBinding) {
        activityBinding = binding
        if (fileSaveManager != null) {
            fileSaveManager!!.activity = activityBinding!!.activity
        } else {
            fileSaveManager = FileSaveManager(activityBinding!!.activity)
        }
        activityBinding!!.addActivityResultListener(fileSaveManager!!)
    }

    private fun cleanUpOnDetached() {
        if (fileSaveManager != null) {
            activityBinding?.removeActivityResultListener(fileSaveManager!!)
            fileSaveManager = null
        }
        activityBinding = null
    }

    override fun saveToDownloads(
        dataBytes: ByteArray,
        filenameWithExtension: String,
    ): String {
        return fileSaveManager?.saveToDownloads(dataBytes, filenameWithExtension)
            ?: throw IOException("Failed to save the file in the download directory.")
    }

    override fun saveFileAs(
        dataBytes: ByteArray,
        filenameWithExtension: String,
        mimeType: String?,
        callback: (Result<String?>) -> Unit
    ) {
        fileSaveManager?.saveFileAs(dataBytes, filenameWithExtension, mimeType) {
            callback(Result.success(it))
        }
    }

}