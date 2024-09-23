import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ism_test/generated/l10n.dart';
import 'package:ism_test/presentation/controllers/image_controller.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageController controller = Get.find<ImageController>();

    return SizedBox(
      width: double.maxFinite,
      height: 50,
      child: TextFormField(
        autofocus: false,
        cursorColor: HexColor('173187'),
        decoration: InputDecoration(
          labelText: S.of(context).text_form_field_label,
        ),
        onChanged: (value) {
          controller.setCategory(value.trim());
        },
      ),
    );
  }
}
