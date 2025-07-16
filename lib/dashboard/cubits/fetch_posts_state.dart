part of 'fetch_posts_cubit.dart';

@freezed
class FetchPostsState with _$FetchPostsState {
  const factory FetchPostsState.initial() = _Initial;
  const factory FetchPostsState.loading() = _Loading;
  const factory FetchPostsState.loaded({
    required List<PostDto> posts,
  }) = _Loaded;
  const factory FetchPostsState.error({
    required String error,
  }) = _Error;
}
