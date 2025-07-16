import 'package:test/services/network_util.dart';

class DashboardRepository {
  DashboardRepository({required NetworkUtil networkUtil})
      : _networkUtil = networkUtil;
  late final NetworkUtil _networkUtil;
}
