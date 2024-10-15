package com.example.anotherapp

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import android.content.Intent
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity(){
    private val CHANNEL = "com.example.anotherapp/params"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val intent = intent
        val data = intent.data

        if (intent.action == Intent.ACTION_VIEW && data != null) {
            val param1 = data.getQueryParameter("param1")
            val param2 = data.getQueryParameter("param2")

            // Sending data to Flutter using Method Channel
            MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL).invokeMethod(
                "sendParams", mapOf("param1" to param1, "param2" to param2)
            )
        }
    }
}
