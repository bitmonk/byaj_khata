import 'package:byaz_track/features/create/data/source/create_screen_remote_source.dart';
import 'package:get/get.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class CreateScreenController extends GetxController {
  CreateScreenController({required this.remoteSource});
  final CreateScreenRemoteSource remoteSource;
  // Reactive variables
  var contacts = <Contact>[].obs;
  var isLoading = true.obs;
  var hasPermission = false.obs;
  var errorMessage = ''.obs;

  final selectedContact = Contact().obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // loadContacts();
  // }

  Future<void> loadContacts() async {
    print('fetched ok');
    try {
      isLoading(true);

      // Request permission
      final permission = await FlutterContacts.requestPermission(
        readonly: true,
      );
      hasPermission(permission);

      if (!permission) {
        errorMessage('Contacts permission denied');
        return;
      }

      // Fetch contacts with properties (phones, emails) and thumbnail photo
      final fetchedContacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
        withThumbnail: true, // Smaller photo for list performance
      );

      if (fetchedContacts.isEmpty) {
        errorMessage('No contacts found');
        return;
      }

      // Sort by display name
      fetchedContacts.sort((a, b) => a.displayName.compareTo(b.displayName));

      contacts.assignAll(fetchedContacts);
    } catch (e) {
      errorMessage('Error loading contacts: $e');
    } finally {
      isLoading(false);
    }
  }

  // Optional: Search filter
  var searchQuery = ''.obs;

  List<Contact> get filteredContacts {
    if (searchQuery.isEmpty) return contacts;
    return contacts.where((contact) {
      return contact.displayName.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ||
          (contact.phones.isNotEmpty &&
              contact.phones.any((p) => p.number.contains(searchQuery.value)));
    }).toList();
  }

  // Refresh contacts (pull to refresh)
  Future<void> refreshContacts() async {
    await loadContacts();
  }
}
