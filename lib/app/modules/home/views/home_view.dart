import 'package:fadprod/app/data/models/Chargement.dart';
import 'package:fadprod/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Obx(() {
              if (controller.loading.isTrue) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.error.isNotEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Image.asset(
                            'assets/images/fad.png',
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.1,
                          ),
                        ),
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          controller.error.value,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            controller.getChargementOpen();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text(
                            'Réessayer',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/fad.png',
                        width: screenWidth * 0.6,
                        height: screenHeight * 0.1,
                      ),
                      const SizedBox(height: 50),
                      Container(
                        width: screenWidth * 0.8,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: Colors.grey[100],
                            isExpanded: true,
                            value: controller.selectedOption.value.isEmpty
                                ? null
                                : controller.selectedOption.value,
                            icon: const Icon(Icons.arrow_drop_down),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                controller.setSelectedOption(newValue);
                                final selectedChargement = controller.chargements.firstWhere(
                                  (chargement) => chargement.nom == newValue,
                                );
                                final selectedChargementCode = selectedChargement.code;
                                Get.toNamed(Routes.DETAILS, arguments: selectedChargementCode);
                              }
                            },
                            menuMaxHeight: screenHeight * 0.4,
                            items: controller.chargements.map<DropdownMenuItem<String>>((Chargement chargement) {
                              return DropdownMenuItem<String>(
                                value: chargement.nom,
                                child: Text(chargement.nom),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          
          // "Powered by" section at the bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Text(
                  'Powered by',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                Image.asset(
                  'assets/images/LogoTicOp.png',
                  width: screenWidth * 0.2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
