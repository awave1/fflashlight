package com.awave.fflashlight

import android.content.pm.PackageManager
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
      "hasFlashlight" -> result.success(hasFlashlight())
      "on", "turnOn", "enable" -> enable(true)
      "off", "turnOff", "disable" -> enable(false)
      else -> result.notImplemented()
    }
  }

  private fun enable(state: Boolean) {
    TODO()
  }

  private fun hasFlashlight() = registrar.context()
          .applicationContext
          .packageManager
          .hasSystemFeature(PackageManager.FEATURE_CAMERA_FLASH)
}
