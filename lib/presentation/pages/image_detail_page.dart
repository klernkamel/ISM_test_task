import 'package:flutter/material.dart';
import '../../domain/entities/image_entity.dart';

/// Страница для отображения изображения во весь экран с анимированной кнопкой назад.
class ImageDetailPage extends StatefulWidget {
  /// Изображение для отображения.
  final ImageEntity image;

  const ImageDetailPage({super.key, required this.image});

  @override
  // ignore: library_private_types_in_public_api
  _ImageDetailPageState createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    // Инициализация контроллера анимации для кнопки назад
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    // Запуск анимации после первого построения виджета
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Прозрачный фон для полного экрана
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Центрируем изображение
          Center(
            child: Hero(
              tag: widget.image.id, // Уникальный тег для Hero
              child: InteractiveViewer(
                  // Позволяет пользователю масштабировать и перемещать изображение
                  child: Image.network(
                widget.image.largeImageURL,
                fit: BoxFit.fill,
              )),
            ),
          ),
          // Анимированная кнопка назад
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: FloatingActionButton(
                backgroundColor: Colors.black54,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _animationController.reverse().then((value) {
                    Navigator.of(context).pop();
                  });
                },
                mini: true,
                elevation: 0,
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
