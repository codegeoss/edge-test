import 'package:edge_telemetry_flutter/edge_telemetry_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/app/app.dart';
import 'package:test/bootstrap.dart';
import 'package:test/services/global.dart';
import 'package:test/services/locator.dart';
import 'package:test/services/singletons.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EdgeTelemetry.initialize(
    endpoint: 'your-opentelemetry-endpoint',
    serviceName: 'my-app',
    enableLocalReporting: true,
  );

  TestConfig(
    values: TestValues(
      urlScheme: 'https',
      baseDomain: 'jsonplaceholder.typicode.com',
    ),
  );

  setUpLocator();

  await bootstrap(
    () => MultiBlocProvider(
      providers: Singletons.registerCubits(),
      child: const App(),
    ),
  );
}
