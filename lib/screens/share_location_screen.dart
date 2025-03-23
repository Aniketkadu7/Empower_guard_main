import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/contact.dart';
import '../widgets/custom_drawer.dart';

class ShareLocationScreen extends StatefulWidget {
  const ShareLocationScreen({Key? key}) : super(key: key);

  @override
  State<ShareLocationScreen> createState() => _ShareLocationScreenState();
}

class _ShareLocationScreenState extends State<ShareLocationScreen> {
  final List<Contact> _contacts = [
    Contact(
      id: '1',
      name: 'Mom',
      phone: '1234567890',
      relationship: 'Mother',
    ),
    Contact(
      id: '2',
      name: 'Dad',
      phone: '0987654321',
      relationship: 'Father',
    ),
    Contact(
      id: '3',
      name: 'Sister',
      phone: '5556667777',
      relationship: 'Sister',
    ),
    Contact(
      id: '4',
      name: 'Best Friend',
      phone: '9998887777',
      relationship: 'Friend',
    ),
  ];

  final List<String> _selectedContactIds = [];
  final TextEditingController _durationController = TextEditingController(text: '60');
  String _locationLink = 'https://empowerguard.app/share/abc123';
  bool _isSharing = false;
  int _remainingMinutes = 0;

  @override
  void dispose() {
    _durationController.dispose();
    super.dispose();
  }

  void _toggleContactSelection(String id) {
    setState(() {
      if (_selectedContactIds.contains(id)) {
        _selectedContactIds.remove(id);
      } else {
        _selectedContactIds.add(id);
      }
    });
  }

  void _shareLocation() {
    if (_selectedContactIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one contact'),
        ),
      );
      return;
    }

    final duration = int.tryParse(_durationController.text);
    if (duration == null || duration <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid duration'),
        ),
      );
      return;
    }

    setState(() {
      _isSharing = true;
      _remainingMinutes = duration;
    });

    // In a real app, this would start a timer to update the remaining time
    // and make an API call to share the location with selected contacts

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Location shared with ${_selectedContactIds.length} contacts for $_remainingMinutes minutes',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _stopSharing() {
    setState(() {
      _isSharing = false;
      _remainingMinutes = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Location sharing stopped'),
      ),
    );
  }

  void _copyLink() {
    Clipboard.setData(ClipboardData(text: _locationLink));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link copied to clipboard'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Location'),
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status card
              if (_isSharing)
                Card(
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Location sharing active',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '$_remainingMinutes min',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Your location is being shared with ${_selectedContactIds.length} contacts',
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _stopSharing,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Stop Sharing'),
                        ),
                      ],
                    ),
                  ),
                ),

              if (!_isSharing) ...[
                Text(
                  'Share Your Location',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Select contacts and duration to share your real-time location',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 24),

                // Duration selector
                Text(
                  'Duration (minutes)',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _durationController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Enter duration in minutes',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _shareLocation,
                      child: const Text('Share Now'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Quick duration buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildQuickDurationButton('15 min', '15'),
                    _buildQuickDurationButton('30 min', '30'),
                    _buildQuickDurationButton('1 hour', '60'),
                    _buildQuickDurationButton('2 hours', '120'),
                  ],
                ),
                const SizedBox(height: 24),

                // Share link
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Share Link',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                _locationLink,
                                style: const TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: _copyLink,
                              tooltip: 'Copy link',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Contacts list
              Text(
                'Select Contacts',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) {
                    final contact = _contacts[index];
                    final isSelected = _selectedContactIds.contains(contact.id);
                    return CheckboxListTile(
                      title: Text(contact.name),
                      subtitle: Text(contact.relationship),
                      secondary: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                        child: Text(
                          contact.name[0],
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      value: isSelected,
                      onChanged: (value) {
                        _toggleContactSelection(contact.id);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickDurationButton(String label, String value) {
    return InkWell(
      onTap: () {
        setState(() {
          _durationController.text = value;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label),
      ),
    );
  }
}

