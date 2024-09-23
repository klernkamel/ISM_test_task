import 'package:ism_test/data/repositories/image_repo.dart';
import 'package:ism_test/domain/entities/image_entity.dart';

/// Use Case для получения изображений.
class ImageUseCase {
  /// Репозиторий для получения изображений.
  final ImageRepo repo;

  /// Конструктор, принимающий [ImageRepo].
  ImageUseCase({required this.repo});

  /// Выполняет получение изображений с пагинацией и опциональным запросом.
  ///
  /// Принимает [page] и [perPage] для пагинации,
  /// а также [category] для фильтрации по категориям.
  Future<List<ImageEntity>> execute(int page, int perPage,
      {String? category}) async {
    return await repo.getImages(page, perPage, category: category);
  }
}
