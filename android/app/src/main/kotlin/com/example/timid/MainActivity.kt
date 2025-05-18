package com.example.timid

import android.bluetooth.le.*
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothManager
import android.content.Context
import android.os.Bundle
import android.os.ParcelUuid
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MainActivity: FlutterActivity() {
    private val CHANNEL = "ble_broadcaster"
    private var advertiser: BluetoothLeAdvertiser? = null
    private var advertisingCallback: AdvertiseCallback? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
                when (call.method) {
                    "startBroadcast" -> {
                        val userId = call.argument<String>("userId") ?: ""
                        startBleAdvertise(userId)
                        result.success(null)
                    }
                    "stopBroadcast" -> {
                        stopBleAdvertise()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
        }
    }

    private fun startBleAdvertise(userId: String) {
        val bluetoothManager = getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager
        val bluetoothAdapter = bluetoothManager.adapter
        advertiser = bluetoothAdapter.bluetoothLeAdvertiser

        val settings = AdvertiseSettings.Builder()
            .setAdvertiseMode(AdvertiseSettings.ADVERTISE_MODE_LOW_LATENCY)
            .setTxPowerLevel(AdvertiseSettings.ADVERTISE_TX_POWER_HIGH)
            .setConnectable(false)
            .build()

        val manufacturerData = userId.toByteArray()
        val data = AdvertiseData.Builder()
            .addManufacturerData(0xFFFF, manufacturerData)
            .build()

        advertisingCallback = object : AdvertiseCallback() {
            override fun onStartSuccess(settingsInEffect: AdvertiseSettings) {
                super.onStartSuccess(settingsInEffect)
                println("BLE advertising started successfully")
            }

            override fun onStartFailure(errorCode: Int) {
                super.onStartFailure(errorCode)
                println("BLE advertising failed: $errorCode")
            }
        }

        advertiser?.startAdvertising(settings, data, advertisingCallback)
    }

    private fun stopBleAdvertise() {
        advertiser?.stopAdvertising(advertisingCallback)
        println("BLE advertising stopped")
    }
}
