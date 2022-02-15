import '../../common/http.dart';
import '../../environmet_config.dart';
import '../models/movies_data.dart';
import '../models/paged_data.dart';

class MoviesRepository with Http {
  Future<PagedData<MoviesData>> getMovies() {
    return get(
      '${EnvironmentConfig.apiUrl}/movies?populate=*',
    ).then(
      (result) {
        var entities = result["data"] as List<dynamic>;
        var items = <MoviesData>[];
        for (var entity in entities) {
          items.add(MoviesData.fromMap(entity));
        }

        return PagedData(items, 0, 0);
      },
    );
  }
}
