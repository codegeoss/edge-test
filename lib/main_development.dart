import 'package:edge_telemetry_flutter/edge_telemetry_flutter.dart';
import 'package:flutter/material.dart';
import 'package:test/app/app.dart';
import 'package:test/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EdgeTelemetry.initialize(
    endpoint: 'your-opentelemetry-endpoint',
    serviceName: 'my-app',
    enableLocalReporting: true,
  );

  await bootstrap(() => const App());
}
