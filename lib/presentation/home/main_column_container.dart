import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ism_test/presentation/controllers/image_controller.dart';
import 'package:ism_test/presentation/home/custom_text_form_field.dart';
import 'package:styled_widget/styled_widget.dart';

import '../image/image_container.dart';

class MainColumnContainer extends StatelessWidget {
  const MainColumnContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем экземпляр контроллера.
    final ImageController controller = Get.find();

    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: HexColor('C3C4BF'),
            width: 2,
          ),
          color: HexColor('F2F1EF')),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          // Поле ввода для поиска по категориям.
          const CustomTextFormField(),
          Builder(builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) {
                if (!controller.hasFetched) {
                  controller.hasFetched = true;
                  controller.fetchImages();
                }
              },
            );
            // Список изображений.
            return Obx(
              () {
                if (controller.images.isEmpty && controller.isLoading.value) {
                  // Показываем индикатор загрузки при начальной загрузке.
                  return const Center(child: CircularProgressIndicator())
                      .padding(top: 20);
                } else if (controller.images.isEmpty) {
                  // Показываем сообщение, если список пуст.
                  return const Center(
                    child: Text('No Images'),
                  );
                } else {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: double.infinity,
                      child: SingleChildScrollView(
                        controller: controller.scrollController,
                        child: Wrap(
                          runSpacing: 10,
                          spacing: 10,
                          alignment: WrapAlignment
                              .spaceAround, // Установи нужное выравнивание
                          children: [
                            for (int i = 0; i < controller.images.length; i++)
                              ImageContainer(
                                image: controller.images[i],
                              ),
                            if (controller.isLoading.value)
                              const Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          }),
        ],
      ),
    );
  }
}
