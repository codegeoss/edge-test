import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/dashboard/models/post_dto.dart';
import 'package:test/dashboard/repository/dashboard_repository.dart';
import 'package:test/services/failure.dart';

part 'fetch_posts_cubit.freezed.dart';
part 'fetch_posts_state.dart';

class FetchPostsCubit extends Cubit<FetchPostsState> {
  FetchPostsCubit({required DashboardRepository dashboardRepository})
      : super(const FetchPostsState.initial()) {
    _dashboardRepository = dashboardRepository;
  }

  late DashboardRepository _dashboardRepository;

  Future<void> fetchPosts() async {
    try {
      emit(const FetchPostsState.loading());
      final response = await _dashboardRepository.fetchPosts();
      emit(FetchPostsState.loaded(posts: response));
    } on Failure catch (e) {
      emit(FetchPostsState.error(error: e.message));
    } on Exception catch (e) {
      emit(FetchPostsState.error(error: e.toString()));
    }
  }
}
