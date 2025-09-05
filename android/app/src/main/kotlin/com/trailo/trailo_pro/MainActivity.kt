package com.trailo.trailo_pro 

import android.Manifest
import android.bluetooth.*
import android.bluetooth.le.*
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.os.ParcelUuid
import android.util.Log
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.nio.ByteBuffer
import java.util.*

class MainActivity: FlutterActivity() {
    private val CHANNEL = "beacon_platform"
    private val TAG = "BeaconBroadcast"
    private val REQUEST_PERMISSIONS = 1001
    
    private var bluetoothAdapter: BluetoothAdapter? = null
    private var bluetoothLeAdvertiser: BluetoothLeAdvertiser? = null
    private var advertiseCallback: AdvertiseCallback? = null
    private var isAdvertising = false
    
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startBroadcasting" -> {
                    val arguments = call.arguments as? Map<String, Any>
                    if (arguments != null) {
                        startBroadcasting(arguments, result)
                    } else {
                        result.error("INVALID_ARGUMENTS", "Arguments cannot be null", null)
                    }
                }
                "stopBroadcasting" -> {
                    stopBroadcasting(result)
                }
                "checkBluetoothSupport" -> {
                    result.success(checkBluetoothSupport())
                }
                "requestPermissions" -> {
                    requestBluetoothPermissions(result)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
        
        initializeBluetooth()
    }
    
    private fun initializeBluetooth() {
        val bluetoothManager = getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager
        bluetoothAdapter = bluetoothManager.adapter
        
        if (bluetoothAdapter == null) {
            Log.e(TAG, "Bluetooth not supported on this device")
            return
        }
        
        if (!bluetoothAdapter!!.isEnabled) {
            Log.w(TAG, "Bluetooth is not enabled")
            return
        }
        
        // Check if device supports BLE advertising
        if (!packageManager.hasSystemFeature(PackageManager.FEATURE_BLUETOOTH_LE)) {
            Log.e(TAG, "BLE not supported on this device")
            return
        }
        
        bluetoothLeAdvertiser = bluetoothAdapter!!.bluetoothLeAdvertiser
        if (bluetoothLeAdvertiser == null) {
            Log.e(TAG, "BLE advertising not supported on this device")
        }
    }
    
    private fun checkBluetoothSupport(): Map<String, Boolean> {
        val support = mutableMapOf<String, Boolean>()
        
        support["hasBluetoothAdapter"] = bluetoothAdapter != null
        support["isBluetoothEnabled"] = bluetoothAdapter?.isEnabled ?: false
        support["hasBleFeature"] = packageManager.hasSystemFeature(PackageManager.FEATURE_BLUETOOTH_LE)
        support["hasAdvertiser"] = bluetoothLeAdvertiser != null
        support["hasPermissions"] = hasRequiredPermissions()
        
        return support
    }
    
    private fun hasRequiredPermissions(): Boolean {
        val permissions = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            arrayOf(
                Manifest.permission.BLUETOOTH_ADVERTISE,
                Manifest.permission.BLUETOOTH_CONNECT,
                Manifest.permission.ACCESS_FINE_LOCATION
            )
        } else {
            arrayOf(
                Manifest.permission.BLUETOOTH,
                Manifest.permission.BLUETOOTH_ADMIN,
                Manifest.permission.ACCESS_FINE_LOCATION
            )
        }
        
        return permissions.all { permission ->
            ContextCompat.checkSelfPermission(this, permission) == PackageManager.PERMISSION_GRANTED
        }
    }
    
    private fun requestBluetoothPermissions(result: MethodChannel.Result) {
        val permissions = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            arrayOf(
                Manifest.permission.BLUETOOTH_ADVERTISE,
                Manifest.permission.BLUETOOTH_CONNECT,
                Manifest.permission.ACCESS_FINE_LOCATION
            )
        } else {
            arrayOf(
                Manifest.permission.BLUETOOTH,
                Manifest.permission.BLUETOOTH_ADMIN,
                Manifest.permission.ACCESS_FINE_LOCATION
            )
        }
        
        ActivityCompat.requestPermissions(this, permissions, REQUEST_PERMISSIONS)
        result.success(null)
    }
    
    private fun startBroadcasting(arguments: Map<String, Any>, result: MethodChannel.Result) {
        if (!hasRequiredPermissions()) {
            result.error("PERMISSIONS_DENIED", "Required permissions not granted", null)
            return
        }
        
        if (bluetoothLeAdvertiser == null) {
            result.error("ADVERTISER_NOT_AVAILABLE", "BLE advertiser not available", null)
            return
        }
        
        if (isAdvertising) {
            result.error("ALREADY_ADVERTISING", "Already broadcasting", null)
            return
        }
        
        try {
            val uuid = arguments["uuid"] as? String ?: "550e8400-e29b-41d4-a716-446655440000"
            val major = (arguments["major"] as? Int) ?: 1
            val minor = (arguments["minor"] as? Int) ?: 1
            val identifier = arguments["identifier"] as? String ?: "default"
            val txPower = (arguments["txPower"] as? Int) ?: -59
            
            Log.d(TAG, "Starting broadcast with UUID: $uuid, Major: $major, Minor: $minor")
            
            // Create iBeacon advertisement data
            val advertisementData = createIBeaconAdvertisementData(uuid, major, minor, txPower)
            
            // Configure advertisement settings
            val settings = AdvertiseSettings.Builder()
                .setAdvertiseMode(AdvertiseSettings.ADVERTISE_MODE_BALANCED)
                .setTxPowerLevel(AdvertiseSettings.ADVERTISE_TX_POWER_MEDIUM)
                .setConnectable(false)
                .setTimeout(0) // Advertise indefinitely
                .build()
            
            // Create advertise callback
            advertiseCallback = object : AdvertiseCallback() {
                override fun onStartSuccess(settingsInEffect: AdvertiseSettings?) {
                    super.onStartSuccess(settingsInEffect)
                    isAdvertising = true
                    Log.d(TAG, "BLE advertisement started successfully")
                }
                
                override fun onStartFailure(errorCode: Int) {
                    super.onStartFailure(errorCode)
                    isAdvertising = false
                    val errorMessage = when (errorCode) {
                        ADVERTISE_FAILED_ALREADY_STARTED -> "Advertisement already started"
                        ADVERTISE_FAILED_DATA_TOO_LARGE -> "Advertisement data too large"
                        ADVERTISE_FAILED_FEATURE_UNSUPPORTED -> "Advertisement feature unsupported"
                        ADVERTISE_FAILED_INTERNAL_ERROR -> "Advertisement internal error"
                        ADVERTISE_FAILED_TOO_MANY_ADVERTISERS -> "Too many advertisers"
                        else -> "Unknown error: $errorCode"
                    }
                    Log.e(TAG, "BLE advertisement failed: $errorMessage")
                }
            }
            
            // Start advertising
            bluetoothLeAdvertiser!!.startAdvertising(settings, advertisementData, advertiseCallback)
            result.success("Broadcasting started")
            
        } catch (e: Exception) {
            Log.e(TAG, "Error starting broadcast: ${e.message}")
            result.error("BROADCAST_ERROR", "Failed to start broadcasting: ${e.message}", null)
        }
    }
    
    private fun createIBeaconAdvertisementData(uuidString: String, major: Int, minor: Int, txPower: Int): AdvertiseData {
        // Convert UUID string to bytes
        val uuid = UUID.fromString(uuidString)
        val uuidBytes = ByteBuffer.allocate(16)
            .putLong(uuid.mostSignificantBits)
            .putLong(uuid.leastSignificantBits)
            .array()
        
        // Create iBeacon manufacturer data
        val manufacturerData = ByteBuffer.allocate(23)
            .put(0x02.toByte()) // iBeacon identifier
            .put(0x15.toByte()) // iBeacon data length (21 bytes)
            .put(uuidBytes) // UUID (16 bytes)
            .putShort(major.toShort()) // Major (2 bytes)
            .putShort(minor.toShort()) // Minor (2 bytes)
            .put(txPower.toByte()) // TX Power (1 byte)
            .array()
        
        return AdvertiseData.Builder()
            .setIncludeDeviceName(false)
            .setIncludeTxPowerLevel(false)
            .addManufacturerData(0x004C, manufacturerData) // Apple's company identifier
            .build()
    }
    
    private fun stopBroadcasting(result: MethodChannel.Result) {
        try {
            if (bluetoothLeAdvertiser != null && advertiseCallback != null && isAdvertising) {
                if (hasRequiredPermissions()) {
                    bluetoothLeAdvertiser!!.stopAdvertising(advertiseCallback)
                    isAdvertising = false
                    Log.d(TAG, "BLE advertisement stopped")
                    result.success("Broadcasting stopped")
                } else {
                    result.error("PERMISSIONS_DENIED", "Required permissions not granted", null)
                }
            } else {
                result.success("Broadcasting was not active")
            }
        } catch (e: SecurityException) {
            Log.e(TAG, "Security exception stopping broadcast: ${e.message}")
            result.error("SECURITY_ERROR", "Security error stopping broadcast: ${e.message}", null)
        } catch (e: Exception) {
            Log.e(TAG, "Error stopping broadcast: ${e.message}")
            result.error("STOP_ERROR", "Failed to stop broadcasting: ${e.message}", null)
        }
    }
    
    override fun onDestroy() {
        super.onDestroy()
        // Stop advertising when activity is destroyed
        if (isAdvertising && bluetoothLeAdvertiser != null && advertiseCallback != null) {
            try {
                if (hasRequiredPermissions()) {
                    bluetoothLeAdvertiser!!.stopAdvertising(advertiseCallback)
                }
            } catch (e: Exception) {
                Log.e(TAG, "Error stopping advertising in onDestroy: ${e.message}")
            }
        }
    }
    
    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        
        when (requestCode) {
            REQUEST_PERMISSIONS -> {
                val allPermissionsGranted = grantResults.isNotEmpty() && 
                    grantResults.all { it == PackageManager.PERMISSION_GRANTED }
                
                if (allPermissionsGranted) {
                    Log.d(TAG, "All permissions granted")
                    initializeBluetooth()
                } else {
                    Log.w(TAG, "Some permissions were denied")
                }
            }
        }
    }
}