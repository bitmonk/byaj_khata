package com.example.native_flutter

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class CustomFlutterActivity : FlutterActivity() {

    private val CHANNEL = "com.example.native_flutter/native_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "getIntentData") {
                    val message = intent.getStringExtra("native_message")
                    result.success(message)
                } else {
                    result.notImplemented()
                }
            }
    }
}
