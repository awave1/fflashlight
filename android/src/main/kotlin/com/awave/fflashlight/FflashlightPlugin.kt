package com.awave.fflashlight

import android.content.Context
import android.content.pm.PackageManager
import android.graphics.Camera
import android.hardware.camera2.CameraManager
import android.os.Build
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class FflashlightPlugin(r: Registrar) : MethodCallHandler {
  private var registrar: Registrar = r

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "fflashlight")
      channel.setMethodCallHandler(FflashlightPlugin(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when(call.method) {
      "enable" -> {
        call.argument<Boolean>("state")?.let { enable(it) }
        result.success(null)
      }
      "on"  -> {
        enable(true)
        result.success(null)
      }
      "off" -> {
        enable(false)
        result.success(null)
      }
      "hasFlashlight" -> result.success(hasFlashlight())
      else -> result.notImplemented()
    }
  }

  private fun enable(state: Boolean) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      // new way
      val cameraManager = registrar.context().getSystemService(Context.CAMERA_SERVICE) as CameraManager?
      cameraManager?.let {
        val cameraId = it.cameraIdList[0]

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
          it.setTorchMode(cameraId, state)
        }
      }
    } else {
      // deprecated way
      TODO()
    }
  }

  private fun hasFlashlight() = registrar.context()
          .applicationContext
          .packageManager
          .hasSystemFeature(PackageManager.FEATURE_CAMERA_FLASH)
}
