import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(

          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/fad.png',
              width: 200,
              height: 100,
            ),
            const SizedBox(height: 50),
            Container(
              width: 300, // Adjust the width based on your layout
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(
                    () => DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: controller.selectedOption.value.isEmpty
                        ? null
                        : controller.selectedOption.value,
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller.setSelectedOption(newValue);
                      }
                    },
                    items: <String>['Option 1', 'Option 2', 'Option 3']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      )  );
  }
}
