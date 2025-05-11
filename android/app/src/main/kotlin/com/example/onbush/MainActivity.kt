package com.example.onbush

import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import android.app.AlarmManager
import io.flutter.plugin.common.MethodChannel
import android.content.Context

class MainActivity: FlutterActivity() {
    private val CHANNEL = "check_exact_alarm"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "isExactAlarmAllowed") {
                val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                    result.success(alarmManager.canScheduleExactAlarms())
                } else {
                    result.success(true)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
