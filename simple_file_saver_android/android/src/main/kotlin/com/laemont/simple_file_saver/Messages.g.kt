// Autogenerated from Pigeon (v17.2.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package com.laemont.simple_file_saver

import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  if (exception is FlutterError) {
    return listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    return listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface SimpleFileSaverApi {
  fun saveToDownloads(dataBytes: ByteArray, filenameWithExtension: String): String
  fun saveFileAs(dataBytes: ByteArray, filenameWithExtension: String, mimeType: String?, callback: (Result<String?>) -> Unit)

  companion object {
    /** The codec used by SimpleFileSaverApi. */
    val codec: MessageCodec<Any?> by lazy {
      StandardMessageCodec()
    }
    /** Sets up an instance of `SimpleFileSaverApi` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: SimpleFileSaverApi?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.simple_file_saver_android.SimpleFileSaverApi.saveToDownloads", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val dataBytesArg = args[0] as ByteArray
            val filenameWithExtensionArg = args[1] as String
            var wrapped: List<Any?>
            try {
              wrapped = listOf<Any?>(api.saveToDownloads(dataBytesArg, filenameWithExtensionArg))
            } catch (exception: Throwable) {
              wrapped = wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.simple_file_saver_android.SimpleFileSaverApi.saveFileAs", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val dataBytesArg = args[0] as ByteArray
            val filenameWithExtensionArg = args[1] as String
            val mimeTypeArg = args[2] as String?
            api.saveFileAs(dataBytesArg, filenameWithExtensionArg, mimeTypeArg) { result: Result<String?> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
