import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../widgets/custom_drawer.dart';

class TrackedLovedOnesScreen extends StatefulWidget {
  const TrackedLovedOnesScreen({Key? key}) : super(key: key);

  @override
  State<TrackedLovedOnesScreen> createState() => _TrackedLovedOnesScreenState();
}

class _TrackedLovedOnesScreenState extends State<TrackedLovedOnesScreen> {
  final List<Contact> _contacts = [
    Contact(
      id: '1',
      name: 'Mom',
      phone: '1234567890',
      relationship: 'Mother',
      isTracking: true,
      isEmergencyContact: true,
    ),
    Contact(
      id: '2',
      name: 'Dad',
      phone: '0987654321',
      relationship: 'Father',
      isTracking: true,
      isEmergencyContact: true,
    ),
    Contact(
      id: '3',
      name: 'Sister',
      phone: '5556667777',
      relationship: 'Sister',
      isTracking: false,
      isEmergencyContact: true,
    ),
    Contact(
      id: '4',
      name: 'Best Friend',
      phone: '9998887777',
      relationship: 'Friend',
      isTracking: true,
      isEmergencyContact: false,
    ),
  ];

  void _addContact() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Contact'),
        content: const Text('This feature will be implemented soon.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _toggleTracking(String id) {
    setState(() {
      final index = _contacts.indexWhere((contact) => contact.id == id);
      if (index != -1) {
        final contact = _contacts[index];
        _contacts[index] = Contact(
          id: contact.id,
          name: contact.name,
          phone: contact.phone,
          relationship: contact.relationship,
          isTracking: !contact.isTracking,
          isEmergencyContact: contact.isEmergencyContact,
        );
      }
    });
  }

  void _toggleEmergencyContact(String id) {
    setState(() {
      final index = _contacts.indexWhere((contact) => contact.id == id);
      if (index != -1) {
        final contact = _contacts[index];
        _contacts[index] = Contact(
          id: contact.id,
          name: contact.name,
          phone: contact.phone,
          relationship: contact.relationship,
          isTracking: contact.isTracking,
          isEmergencyContact: !contact.isEmergencyContact,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracked Loved Ones'),
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Trusted Contacts',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'These are the people who can track your location and receive emergency alerts.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: _contacts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No contacts added yet',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Add trusted contacts to keep you safe',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[500],
                                  ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _contacts.length,
                        itemBuilder: (context, index) {
                          final contact = _contacts[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                                        child: Text(
                                          contact.name[0],
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              contact.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              contact.relationship,
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.more_vert),
                                        onPressed: () {
                                          // Show options menu
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        contact.phone,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SwitchListTile.adaptive(
                                          title: const Text('Location Tracking'),
                                          contentPadding: EdgeInsets.zero,
                                          value: contact.isTracking,
                                          onChanged: (value) {
                                            _toggleTracking(contact.id);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: SwitchListTile.adaptive(
                                          title: const Text('Emergency Contact'),
                                          contentPadding: EdgeInsets.zero,
                                          value: contact.isEmergencyContact,
                                          onChanged: (value) {
                                            _toggleEmergencyContact(contact.id);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addContact,
        child: const Icon(Icons.add),
      ),
    );
  }
}

