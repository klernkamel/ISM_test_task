import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_test/domain/repositories/image_use_case.dart';
import '../../domain/entities/image_entity.dart';

/// Контроллер для управления состоянием изображений и поиском.
class ImageController extends GetxController {
  /// Use Case для получения изображений.
  final ImageUseCase getImagesUseCase;

  /// Список изображений.
  var images = <ImageEntity>[].obs;

  /// Флаг загрузки данных.
  var isLoading = false.obs;

  /// Текущий номер страницы для пагинации.
  var page = 1;

  /// Количество изображений на странице.
  final perPage = 50;

  /// Контроллер прокрутки для отслеживания достижения конца списка.
  late ScrollController scrollController;

  /// Текущий поисковый запрос.
  String? searchQuery;

  /// Таймер для реализации debounce при поиске.
  Timer? _debounce;

  // Флаг для отслеживания первого вызова загрузки
  bool hasFetched = false;

  // Список ключей для новых изображений
  List<GlobalKey> newImageKeys = [];

  /// Конструктор с требованием [ImageUseCase].
  ImageController({required this.getImagesUseCase});

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();

    // Добавляем слушатель прокрутки для подгрузки новых изображений.
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isLoading.value) {
        fetchImages();
      }
    });
    // Начальная загрузка изображений.
    fetchImages();
  }

  @override
  void onClose() {
    scrollController.dispose();
    _debounce?.cancel();
    super.onClose();
  }

  /// Устанавливает категорию для поиска с использованием debounce.
  ///
  /// [category] - введённая пользователем категория.
  void setCategory(String category) {
    // Отменяем предыдущий таймер, если он активен
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    // Устанавливаем новый таймер
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      // Если категория изменилась, сбрасываем страницу и список изображений
      if (searchQuery != category) {
        searchQuery = category;
        page = 1;
        images.clear();
        fetchImages();
      }
    });
  }

  /// Метод для получения изображений.
  ///
  /// Загружает изображения из API с учётом текущей категории и пагинации.
  void fetchImages() async {
    if (isLoading.value) return;

    isLoading.value = true;

    // Сохраняем текущую позицию скролла
    double currentScrollOffset =
        scrollController.hasClients ? scrollController.offset : 0.0;

    try {
      // Получаем список изображений через Use Case.
      var newImages =
          await getImagesUseCase.execute(page, perPage, category: searchQuery);

      // Создаем ключи для новых изображений
      newImageKeys = List.generate(newImages.length, (_) => GlobalKey());

      // Добавляем новые изображения
      images.addAll(newImages);
      page++;

      // Даем время фрейму перестроиться
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!scrollController.hasClients) return;

        // Рассчитываем высоту новых элементов
        double newContentHeight = 0;
        for (var key in newImageKeys) {
          final context = key.currentContext;
          if (context != null) {
            final box = context.findRenderObject() as RenderBox;
            newContentHeight += box.size.height;
          }
        }

        // Устанавливаем новую позицию скролла
        scrollController.jumpTo(currentScrollOffset + newContentHeight);
      });
    } catch (e) {
      print(e.toString());
      Get.snackbar('Ошибка', e.toString());
      Get.snackbar(
        'Ошибка',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
