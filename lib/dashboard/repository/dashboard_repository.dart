import 'package:test/dashboard/models/post_dto.dart';
import 'package:test/services/network_util.dart';

class DashboardRepository {
  DashboardRepository({required NetworkUtil networkUtil})
      : _networkUtil = networkUtil;
  late final NetworkUtil _networkUtil;

  Future<List<PostDto>> fetchPosts() async {
    try {
      final response = await _networkUtil.getReq('/posts');
      final json = response['data'] as List<dynamic>;
      final result = json
          .map((element) => PostDto.fromJson(element as Map<String, dynamic>))
          .toList();

      return result;
    } catch (_) {
      rethrow;
    }
  }
}
