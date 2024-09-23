import 'dart:convert';

import 'package:ism_test/data/models/image_model.dart';
import 'package:http/http.dart' as http;

/// Провайдер для взаимодействия с Pixabay API.
class PiaxabayApiProvider {
  /// Базовый URL для запросов к Pixabay API.
  final String _url = 'https://pixabay.com/api/';

  /// API ключ.
  final String _key = '46113368-4f97a20676cef19ab48f83f61';

  /// Метод для получения списка изображений.
  ///
  /// Принимает [page] и [perPage] для пагинации,
  /// а также [category] для поиска по категориям.
  Future<List<ImageModel>> fetchImages(
      {required int page, required int perPage, String? category}) async {
    // Формируем URL с параметром поиска, если он задан.
    String url = '$_url?key=$_key&page=$page&per_page=$perPage';

    if (category != null && category.isNotEmpty) {
      url += '&q=${Uri.encodeComponent(category)}';
    }
    // Выполняем GET запрос.
    final response = await http.get(Uri.parse(
      url,
    ));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<ImageModel> images = (data['hits'] as List)
          .map((json) => ImageModel.fromJson(json))
          .toList();
      return images;
    } else {
      throw Exception('Load Images Error');
    }
  }
}
