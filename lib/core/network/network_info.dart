import 'dart:io';

class NetworkInfo {
  static Future<bool> get isConnected async{
    try{
      final List<InternetAddress> result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<bool> hasInternetConnection() async {
    return await isConnected;
  }
}