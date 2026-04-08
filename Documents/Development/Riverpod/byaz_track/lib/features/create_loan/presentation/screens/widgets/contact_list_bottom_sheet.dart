import 'package:byaz_track/core/enum/the_states.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/create_loan/presentation/controllers/create_loan_controller.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactListBottomSheet extends StatefulWidget {
  final Function(Contact) onContactSelected;

  const ContactListBottomSheet({super.key, required this.onContactSelected});

  @override
  State<ContactListBottomSheet> createState() => _ContactListBottomSheetState();
}

class _ContactListBottomSheetState extends State<ContactListBottomSheet> {
  final createLoanController = Get.find<CreateLoanController>();
  @override
  void initState() {
    super.initState();
    createLoanController.loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select Contact',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AppTextFormField(
            labelText: 'Search Contact',
            textInputType: TextInputType.text,
            prefixIcon: Icon(Icons.search, color: AppColors.appGreen),
            onChanged: (value) {
              createLoanController.searchContacts(value);
            },
          ),
          const SizedBox(height: 10),
          Obx(
            () => Expanded(
              child:
                  createLoanController.loadContactState.value ==
                          TheStates.loading
                      ? const Center(child: CircularProgressIndicator())
                      : !createLoanController.hasContactPermission.value
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Permission Denied'),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => openAppSettings(),
                              child: const Text('Open Settings'),
                            ),
                          ],
                        ),
                      )
                      : createLoanController.contacts.isEmpty
                      ? const Center(child: Text('No Contacts Found'))
                      : ListView.builder(
                        itemCount: createLoanController.contacts.length,
                        itemBuilder: (context, index) {
                          final contact = createLoanController.contacts[index];
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                contact.displayName.isNotEmpty
                                    ? contact.displayName[0].toUpperCase()
                                    : '?',
                              ),
                            ),
                            title: Text(contact.displayName),
                            subtitle:
                                contact.phones.isNotEmpty
                                    ? Text(contact.phones.first.number)
                                    : null,
                            onTap: () {
                              widget.onContactSelected(contact);
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
