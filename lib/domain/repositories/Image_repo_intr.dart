import 'package:ism_test/domain/entities/image_entity.dart';

/// Абстрактный репозиторий для получения изображений.
abstract class ImageRepoIntr {
  /// Получает список изображений с возможным фильтром по [category].
  ///
  /// Принимает [page] и [perPage] для пагинации,
  /// а также [category] для поиска по категориям.
  Future<List<ImageEntity>> getImages(int page, int perPage,
      {String? category});
}
