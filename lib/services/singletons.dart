import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/dashboard/cubits/fetch_posts_cubit.dart';
import 'package:test/dashboard/repository/dashboard_repository.dart';
import 'package:test/services/locator.dart';

class Singletons {
  static List<BlocProvider> registerCubits() => [
        BlocProvider<FetchPostsCubit>(
          create: (context) => FetchPostsCubit(
            dashboardRepository: locator<DashboardRepository>(),
          ),
        ),
      ];
}
