import 'package:flutter/material.dart';
import 'package:ism_test/domain/entities/image_entity.dart';
import 'package:ism_test/presentation/pages/image_detail_page.dart';
import 'package:styled_widget/styled_widget.dart';

/// Виджет для отображения отдельного изображения с обработкой нажатия.
class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.image,
  });
  final ImageEntity image;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      // Навигация на страницу с полноэкранным отображением изображения.
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ImageDetailPage(image: image),
          ),
        );
      },
      child: Hero(
        tag: image.id,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 180,
            maxHeight: 250,
          ),
          child: Container(
            padding: EdgeInsets.all(5),
            width: width * 0.4,
            height: height * 0.26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 1.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.maxFinite,
                  height: height * 0.19,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        image.largeImageURL,
                        fit: BoxFit.fill,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          image.likes.toString(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ).padding(right: 2),
                        Icon(
                          Icons.favorite_border_rounded,
                          size: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.visibility_outlined,
                          size: MediaQuery.of(context).size.height * 0.02,
                        ).padding(right: 2),
                        Text(
                          image.views.toString(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
