/// Сущность изображения в доменном слое.
class ImageEntity {
  /// Уникальный идентификатор изображения.
  final int id;

  /// Количество лайков изображения
  final int likes;

  /// Количество просмотров изображения
  final int views;

  /// URL для предварительного просмотра изображения.
  final String previewURL;

  /// URL для полноразмерного изображения.
  final String largeImageURL;

  ImageEntity({
    required this.id,
    required this.likes,
    required this.views,
    required this.previewURL,
    required this.largeImageURL,
  });
}
