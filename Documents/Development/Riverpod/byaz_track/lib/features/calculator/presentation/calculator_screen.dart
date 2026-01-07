import 'package:byaz_track/features/create/presentation/controllers/create_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Obx(
              () => Text(
                Get.find<CreateScreenController>()
                    .selectedContact
                    .value
                    .displayName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
