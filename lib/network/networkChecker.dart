import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io'; // For further checking internet availability.

class NetworkChecker {
  /// Checks if the device is connected to the internet
  static Future<bool> isInternetAvailable() async {
    try {
      // Step 1: Check connectivity status
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false; // No connection to Wi-Fi or mobile data.
      }

      // Step 2: Verify actual internet connection by pinging a reliable host
      final result = await _checkInternetAccess();
      return result;
    } catch (e) {
      print("Error checking internet: $e");
      return false; // Return false if any error occurs.
    }
  }


  /// Performs a basic internet access test
  static Future<bool> _checkInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('example.com'); // Reliable DNS check
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      print("Internet access failed: $e");
      return false; // No internet access
    }
  }
}