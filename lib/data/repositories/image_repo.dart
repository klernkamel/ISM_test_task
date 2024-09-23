import 'package:ism_test/data/models/image_model.dart';
import 'package:ism_test/data/providers/piaxabay_api_provider.dart';
import 'package:ism_test/domain/entities/image_entity.dart';
import 'package:ism_test/domain/repositories/Image_repo_intr.dart';

/// Реализация [ImageRepo], взаимодействующая с [PiaxabayApiProvider].
class ImageRepo implements ImageRepoIntr {
  /// Провайдер для выполнения запросов к Pixabay API.
  final PiaxabayApiProvider apiProvider;

  ImageRepo({required this.apiProvider});

  @override
  Future<List<ImageEntity>> getImages(int page, int perPage,
      {String? category}) async {
    // Получаем список [ImageModel] из провайдера.
    List<ImageModel> imageModels = await apiProvider.fetchImages(
        page: page, perPage: perPage, category: category);
    // Возвращаем их как сущности домена.
    return imageModels
        .map((imageModel) => ImageEntity(
            id: imageModel.id,
            likes: imageModel.likes,
            views: imageModel.views,
            previewURL: imageModel.previewURL,
            largeImageURL: imageModel.largeImageURL))
        .toList();
  }
}
