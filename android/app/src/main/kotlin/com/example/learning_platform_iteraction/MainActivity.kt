package com.example.learning_platform_iteraction

import androidx.annotation.NonNull

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.Objects

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "demo.tamim.com/learn"
        ).setMethodCallHandler { call, result ->
            if (call.method == "getMessage") {
                val arguments = call.arguments<Map<String, String>>()
                if (arguments?.getValue("from") is String){
                    val value: String = arguments?.getValue("from") as String
                    result.success("$value says hi from android")
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
