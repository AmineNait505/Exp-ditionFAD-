// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController textController = TextEditingController();
    final FocusNode focusNode = FocusNode();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/fad.png',
          width: screenWidth * 0.3,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Obx(() {
                  final details = controller.chargement.value;

                  if (controller.loading.isTrue) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: details == null
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                        size: 60,
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        "Problème de connexion",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 16),
                                      ElevatedButton(
                                        onPressed: () {
                                          controller.getChargementDetails();
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
                              )
                            : SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Make the TextField invisible but keep it in the view
                                      Visibility(
                                        visible: false,
                                        child: TextField(
                                          controller: textController,
                                          focusNode: focusNode,
                                          autofocus: true,
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              controller.updateZoneText(value);
                                              textController.clear();
                                            }
                                          },
                                          style: const TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: focusNode.hasFocus ? Colors.green : Colors.red,
                                                width: 2,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.green,
                                                width: 2,
                                              ),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Circuit : ',
                                              style: TextStyle(
                                                color: Colors.green[600],
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '${details.circuitName}\n',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Chauffeur : ',
                                              style: TextStyle(
                                                color: Colors.green[600],
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '${details.nomChauffeur}\n',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Véhicule : ',
                                              style: TextStyle(
                                                color: Colors.green[600],
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " ${details.vehicle} \n",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Chargement Code : ',
                                              style: TextStyle(
                                                color: Colors.green[600],
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: controller.code.value,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Container(
                                        width: double.infinity,
                                        height: 50,
                                        color: Colors.grey[300],
                                        child: Center(
                                          child: Text(
                                            controller.zoneText.value.isEmpty
                                                ? 'Code de colis à scanner'
                                                : controller.zoneText.value,
                                            style: const TextStyle(
                                                fontSize: 16, color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        controller.hintext.value,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: controller.hintTextColor.value,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
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
                  );
                }),
              ),
            ],
          ),
          // Hidden TextField off-screen to avoid taking space
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 0,
              height: 0,
              child: TextField(
                controller: textController,
                focusNode: focusNode,
                autofocus: true,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    controller.updateZoneText(value);
                    textController.clear();
                  }
                },
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: focusNode.hasFocus ? Colors.green : Colors.red,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
