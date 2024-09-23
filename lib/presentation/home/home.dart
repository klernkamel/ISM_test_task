import 'package:flutter/material.dart';
import 'package:ism_test/presentation/appbar/custom_appbar.dart';
import 'package:ism_test/presentation/home/main_column_container.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const Scaffold(
        appBar: CustomAppBar(),
        body: SafeArea(
          child: MainColumnContainer(),
        ),
      ),
    );
  }
}
