import 'package:get_it/get_it.dart';
import 'package:test/dashboard/repository/dashboard_repository.dart';
import 'package:test/services/network_util.dart';

final GetIt locator = GetIt.instance;

void setUpLocator() {
  locator
    ..registerSingleton<NetworkUtil>(NetworkUtil())
    ..registerSingleton(
      DashboardRepository(networkUtil: locator<NetworkUtil>()),
    );
}
