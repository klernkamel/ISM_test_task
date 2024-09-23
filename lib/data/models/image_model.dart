import 'package:ism_test/domain/entities/image_entity.dart';

/// Модель данных для изображения, получаемого из Pixabay API.
/// Наследуется от [ImageEntity], определённого в Domain Layer.
class ImageModel extends ImageEntity {
  final int id;
  final int likes;
  final int views;
  final String previewURL;
  final String largeImageURL;

  ImageModel({
    required this.id,
    required this.likes,
    required this.views,
    required this.previewURL,
    required this.largeImageURL,
  }) : super(
          id: id,
          likes: likes,
          views: views,
          previewURL: previewURL,
          largeImageURL: largeImageURL,
        );

  /// Фабричный метод для создания экземпляра [ImageModel] из JSON.
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
        id: json['id'],
        likes: json['likes'],
        views: json['views'],
        previewURL: json['previewURL'],
        largeImageURL: json['largeImageURL']);
  }
}
