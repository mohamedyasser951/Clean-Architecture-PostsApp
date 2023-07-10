import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImplem implements NetworkInfo {
  @override
  Future<bool> get isConnected => InternetConnectionChecker().hasConnection;
}
