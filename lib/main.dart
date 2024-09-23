import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_test/application/application.dart';
import 'package:ism_test/data/providers/piaxabay_api_provider.dart';
import 'package:ism_test/data/repositories/image_repo.dart';
import 'package:ism_test/domain/repositories/image_use_case.dart';
import 'package:ism_test/presentation/controllers/image_controller.dart';

void main() {
  final apiProvider = PiaxabayApiProvider();
  final imageRepo = ImageRepo(apiProvider: apiProvider);
  final getImagesUseCase = ImageUseCase(repo: imageRepo);

  Get.put(getImagesUseCase);
  Get.put(ImageController(getImagesUseCase: getImagesUseCase));

  runApp(const Application());
}
