import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trailo_pro/features/onboarding/presentation/pages/splash_screen.dart';

import 'core/theme/theme.dart';


void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: SplashScreen(),

    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_beacon/flutter_beacon.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'dart:async';
// import 'dart:math';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Restaurant Beacon App',
//       theme: ThemeData(primarySwatch: Colors.orange),
//       home: BeaconTestScreen(),
//     );
//   }
// }

// class BeaconTestScreen extends StatefulWidget {
//   @override
//   _BeaconTestScreenState createState() => _BeaconTestScreenState();
// }

// class _BeaconTestScreenState extends State<BeaconTestScreen> {
//   static const platform = MethodChannel('beacon_platform');

//   bool isBroadcasting = false;
//   bool isScanning = false;
//   List<DetectedBeacon> detectedBeacons = [];
//   StreamSubscription<RangingResult>? _rangingSubscription;

//   // Track beacons that have shown notifications
//   final Set<String> _notifiedBeacons = {};

//   final String restaurantUUID = "550e8400-e29b-41d4-a716-446655440000";
//   final String deviceId = "DEVICE_${Random().nextInt(9999)}";

//   @override
//   void initState() {
//     super.initState();
//     _initializeBeacon();
//   }

//   Future<void> _initializeBeacon() async {
//     await _requestPermissions();
//     await flutterBeacon.initializeScanning;
//   }

//   Future<void> _requestPermissions() async {
//     await [
//       Permission.bluetooth,
//       Permission.bluetoothScan,
//       Permission.bluetoothAdvertise,
//       Permission.locationWhenInUse,
//       Permission.bluetoothConnect,
//     ].request();
//   }

//   Future<void> _startBroadcasting() async {
//     try {
//       await platform.invokeMethod('startBroadcasting', {
//         'uuid': restaurantUUID,
//         'major': 1,
//         'minor': Random().nextInt(1000),
//         'identifier': deviceId,
//         'message': 'Hello from $deviceId!',
//       });

//       setState(() {
//         isBroadcasting = true;
//       });

//       _showSnackBar('Started broadcasting as beacon!');
//     } catch (e) {
//       _showSnackBar('Failed to start broadcasting: $e');
//     }
//   }

//   Future<void> _stopBroadcasting() async {
//     try {
//       await platform.invokeMethod('stopBroadcasting');
//       setState(() {
//         isBroadcasting = false;
//       });
//       _showSnackBar('Stopped broadcasting');
//     } catch (e) {
//       _showSnackBar('Failed to stop broadcasting: $e');
//     }
//   }

//   Future<void> _startScanning() async {
//     try {
//       final region = Region(
//         identifier: 'restaurant-region',
//         proximityUUID: restaurantUUID,
//       );

//       _rangingSubscription =
//           flutterBeacon.ranging([region]).listen((RangingResult result) {
//         setState(() {
//           detectedBeacons = result.beacons
//               .map((beacon) => DetectedBeacon(
//                     beacon: beacon,
//                     lastSeen: DateTime.now(),
//                     message: _getBeaconMessage(beacon),
//                   ))
//               .toList();

//           // Remove notifications for beacons no longer in range
//           _notifiedBeacons.removeWhere(
//               (id) => !result.beacons.any((b) => _getBeaconId(b) == id));
//         });

//         // Handle new beacons detected
//         for (var beacon in result.beacons) {
//           _handleBeaconDetected(beacon);
//         }
//       });

//       setState(() {
//         isScanning = true;
//       });

//       _showSnackBar('Started scanning for beacons!');
//     } catch (e) {
//       _showSnackBar('Failed to start scanning: $e');
//     }
//   }

//   Future<void> _stopScanning() async {
//     _rangingSubscription?.cancel();
//     setState(() {
//       isScanning = false;
//       detectedBeacons.clear();
//       _notifiedBeacons.clear(); // Clear notifications when scanning stops
//     });
//     _showSnackBar('Stopped scanning');
//   }

//   String _getBeaconId(Beacon beacon) {
//     // Unique identifier for a beacon (using major and minor)
//     return '${beacon.major}_${beacon.minor}';
//   }

//   void _handleBeaconDetected(Beacon beacon) {
//     String message = _getBeaconMessage(beacon);
//     String beaconId = _getBeaconId(beacon);

//     // Show notification only if not already shown for this beacon
//     if (beacon.accuracy < 2.0 && !_notifiedBeacons.contains(beaconId)) {
//       _notifiedBeacons.add(beaconId);
//       _showBeaconNotification(beacon, message);
//     }
//   }

//   String _getBeaconMessage(Beacon beacon) {
//     switch (beacon.major) {
//       case 1:
//         return "🎉 Welcome to the Labim Mall!\n\nToday’s Offer: Get 10% off!";
//       case 2:
//         return "🍸 Bar Special!\n\nHappy Hour: Buy 1 Get 1 Free (5–7 PM).";
//       case 3:
//         return "🍰 Dessert Time!\n\nOrder any main course and get a free dessert today!";
//       default:
//         return "🎉 Special Deal just for you!";
//     }
//   }

//   void _showBeaconNotification(Beacon beacon, String message) {
//     showDialog(
//       context: context,
//       barrierDismissible: true, // allow dismiss when tapped outside
//       builder: (context) => Dialog(
//         backgroundColor: Colors.transparent, // remove white background
//         insetPadding: const EdgeInsets.all(16),
//         child: Stack(
//           alignment: Alignment.topRight,
//           children: [
//             // Advertisement Image
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Image.asset(
//                 'assets/images/advertisment.png',
//                 fit: BoxFit.cover,
//               ),
//             ),
//             // Close Button
//             Positioned(
//               right: 8,
//               top: 8,
//               child: GestureDetector(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.black54, // semi-transparent bg
//                     shape: BoxShape.circle,
//                   ),
//                   padding: const EdgeInsets.all(6),
//                   child: const Icon(
//                     Icons.close,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Restaurant Beacon Test'),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Card(
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Beacon Broadcasting',
//                         style: Theme.of(context).textTheme.headlineSmall),
//                     SizedBox(height: 10),
//                     Text('Device ID: $deviceId'),
//                     SizedBox(height: 10),
//                     Row(
//                       children: [
//                         ElevatedButton(
//                           onPressed: isBroadcasting ? null : _startBroadcasting,
//                           child: Text('Start Broadcast'),
//                         ),
//                         SizedBox(width: 10),
//                         ElevatedButton(
//                           onPressed: !isBroadcasting ? null : _stopBroadcasting,
//                           child: Text('Stop Broadcast'),
//                         ),
//                       ],
//                     ),
//                     if (isBroadcasting)
//                       Padding(
//                         padding: EdgeInsets.only(top: 10),
//                         child: Row(
//                           children: [
//                             Icon(Icons.broadcast_on_personal,
//                                 color: Colors.green),
//                             SizedBox(width: 8),
//                             Text('Broadcasting active',
//                                 style: TextStyle(color: Colors.green)),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Card(
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Beacon Detection',
//                         style: Theme.of(context).textTheme.headlineSmall),
//                     SizedBox(height: 10),
//                     Row(
//                       children: [
//                         ElevatedButton(
//                           onPressed: isScanning ? null : _startScanning,
//                           child: Text('Start Scanning'),
//                         ),
//                         SizedBox(width: 10),
//                         ElevatedButton(
//                           onPressed: !isScanning ? null : _stopScanning,
//                           child: Text('Stop Scanning'),
//                         ),
//                       ],
//                     ),
//                     if (isScanning)
//                       Padding(
//                         padding: EdgeInsets.only(top: 10),
//                         child: Row(
//                           children: [
//                             Icon(Icons.search, color: Colors.blue),
//                             SizedBox(width: 8),
//                             Text('Scanning for beacons...',
//                                 style: TextStyle(color: Colors.blue)),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text('Detected Beacons (${detectedBeacons.length})',
//                 style: Theme.of(context).textTheme.headlineSmall),
//             SizedBox(height: 10),
//             Expanded(
//               child: detectedBeacons.isEmpty
//                   ? Center(
//                       child: Text(
//                         isScanning
//                             ? 'Scanning for beacons...'
//                             : 'No beacons detected',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: detectedBeacons.length,
//                       itemBuilder: (context, index) {
//                         final detectedBeacon = detectedBeacons[index];
//                         final beacon = detectedBeacon.beacon;

//                         return Card(
//                           margin: EdgeInsets.symmetric(vertical: 4),
//                           child: ListTile(
//                             leading: Icon(
//                               Icons.bluetooth,
//                               color: _getSignalColor(beacon.accuracy),
//                             ),
//                             title: Text('Device ${beacon.minor}'),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Text(
//                                 //     'Distance: ${beacon.accuracy.toStringAsFixed(2)}m'),
//                                 // Text('Signal: ${beacon.rssi}dBm'),
//                                 Text(detectedBeacon.message),
//                               ],
//                             ),
//                             trailing: Text(
//                               _getProximity(beacon.accuracy),
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: _getSignalColor(beacon.accuracy),
//                               ),
//                             ),
//                             onTap: () => _showBeaconDetails(detectedBeacon),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Color _getSignalColor(double distance) {
//     if (distance < 1.0) return Colors.green;
//     if (distance < 3.0) return Colors.orange;
//     return Colors.red;
//   }

//   String _getProximity(double distance) {
//     if (distance < 0.5) return 'CLOSE';
//     if (distance < 2.0) return 'NEAR';
//     if (distance < 10.0) return 'FAR';
//     return 'UNKNOWN';
//   }

//   void _showBeaconDetails(DetectedBeacon detectedBeacon) {
//     final beacon = detectedBeacon.beacon;
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Beacon Details'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('UUID: ${beacon.proximityUUID}'),
//             Text('Major: ${beacon.major}'),
//             Text('Minor: ${beacon.minor}'),
//             Text('Distance: ${beacon.accuracy.toStringAsFixed(2)}m'),
//             Text('RSSI: ${beacon.rssi}dBm'),
//             Text(
//                 'Last seen: ${detectedBeacon.lastSeen.toString().substring(11, 19)}'),
//             SizedBox(height: 10),
//             Text('Message:', style: TextStyle(fontWeight: FontWeight.bold)),
//             Text(detectedBeacon.message),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _rangingSubscription?.cancel();
//     _stopBroadcasting();
//     super.dispose();
//   }
// }

// class DetectedBeacon {
//   final Beacon beacon;
//   final DateTime lastSeen;
//   final String message;

//   DetectedBeacon({
//     required this.beacon,
//     required this.lastSeen,
//     required this.message,
//   });
// }
