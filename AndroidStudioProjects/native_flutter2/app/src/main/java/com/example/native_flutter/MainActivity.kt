package com.example.native_flutter

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterActivityLaunchConfigs
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

private const val FLUTTER_ENGINE_NAME = "flutter"

class MainActivity : AppCompatActivity() {
    lateinit var button: Button
    lateinit var helpBtn: Button
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        warmupFlutterEngine()
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        button = findViewById(R.id.button)
        helpBtn = findViewById(R.id.helpBtn)

        helpBtn.setOnClickListener {
            startActivity(Intent(this,HelpActivity::class.java))
        }

        button.setOnClickListener {
            println(message = "opening flutter sdk...")
            runFlutterNPS()
        }
    }


    private fun runFlutterNPS() {
        val flutterIntent = Intent(this, CustomFlutterActivity::class.java)
        flutterIntent.putExtra("native_message", "Hello from Android native button!")
        startActivity(flutterIntent)
    }



    private fun warmupFlutterEngine() {
        val flutterEngine = FlutterEngine(this)

        // Start executing Dart code to pre-warm the FlutterEngine.
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example.native_flutter/native_channel")
            .setMethodCallHandler { call, result ->
                if (call.method == "getIntentData") {
                    // Get data from the Intent that launched FlutterActivity
                    val message = (this as? FlutterActivity)?.intent?.getStringExtra("native_message")
                    result.success(message)
                } else {
                    result.notImplemented()
                }
            }

        // Cache the FlutterEngine to be used by FlutterActivity.
        FlutterEngineCache
            .getInstance()
            .put(FLUTTER_ENGINE_NAME, flutterEngine)
    }
}