package com.example.picos

import android.os.Build
import android.os.Bundle
import android.app.NotificationChannel
import android.app.NotificationManager
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                    "default_channel_id",
                    "Default Channel",
                    NotificationManager.IMPORTANCE_DEFAULT
            )
            val notificationManager: NotificationManager = getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(channel)
        }
    }
}
