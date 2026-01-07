import 'package:byaz_track/features/dashboard/presentation/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:byaz_track/features/create/presentation/controllers/create_screen_controller.dart';

class CreateScreen extends StatelessWidget {
  final CreateScreenController controller = Get.find<CreateScreenController>();

  CreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.refreshContacts(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: const InputDecoration(
                labelText: 'Search by name or phone',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // Contact list
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!controller.hasPermission.value) {
                return Center(
                  child: Text(
                    controller.errorMessage.value.isEmpty
                        ? 'Permission required to access contacts'
                        : controller.errorMessage.value,
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (controller.filteredContacts.isEmpty) {
                return const Center(child: Text('No contacts found'));
              }

              return ListView.builder(
                itemCount: controller.filteredContacts.length,
                itemBuilder: (context, index) {
                  final contact = controller.filteredContacts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          contact.photoOrThumbnail != null
                              ? MemoryImage(contact.photoOrThumbnail!)
                              : null,
                      child:
                          contact.photoOrThumbnail == null
                              ? Text(
                                contact.displayName.isNotEmpty
                                    ? contact.displayName[0].toUpperCase()
                                    : '?',
                              )
                              : null,
                    ),
                    title: Text(contact.displayName),
                    subtitle:
                        contact.phones.isNotEmpty
                            ? Text(contact.phones.first.number)
                            : const Text('No phone number'),
                    onTap: () {
                      print("contact");
                      // Get.back(
                      //   result: {
                      //     'name': contact.displayName,
                      //     'phone':
                      //         contact.phones.isNotEmpty
                      //             ? contact.phones.first.number
                      //             : '',
                      //     'contactId': contact.id,
                      //   },
                      // );
                      print(contact.displayName);
                      controller.selectedContact.value = contact;
                      print(controller.selectedContact.value.displayName);
                      Get.to(DashboardScreen(initialIndex: 2));
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
