import 'package:flutter/material.dart';
import '../widgets/sos_button.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSafe = true;
  String _lastUpdated = 'Just now';
  
  void _handleSosPressed() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('SOS Alert'),
        content: const Text(
          'This will send an emergency alert to your emergency contacts with your current location. Do you want to proceed?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _sendSosAlert();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Send Alert'),
          ),
        ],
      ),
    );
  }

  void _sendSosAlert() {
    // Show a snackbar to indicate the alert was sent
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Emergency alert sent to your contacts'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ),
    );
    
    // In a real app, this would trigger an API call to send the alert
  }

  void _toggleSafetyStatus() {
    setState(() {
      _isSafe = !_isSafe;
      _lastUpdated = 'Just now';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empower Guard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // User greeting
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 24,
                              backgroundColor: Color(0xFFE1BEE7),
                              child: Icon(
                                Icons.person,
                                color: Color(0xFF6A1B9A),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello, Jane',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  'Stay safe today!',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Safety status card
                Card(
                  color: _isSafe ? Colors.green.shade50 : Colors.orange.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Current Status',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'Updated: $_lastUpdated',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              _isSafe ? Icons.check_circle : Icons.warning,
                              color: _isSafe ? Colors.green : Colors.orange,
                              size: 36,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              _isSafe ? 'You are safe' : 'Be cautious',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: _isSafe ? Colors.green : Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _toggleSafetyStatus,
                          icon: Icon(_isSafe ? Icons.warning : Icons.check_circle),
                          label: Text(_isSafe ? 'Set to Cautious' : 'Set to Safe'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isSafe ? Colors.orange : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // SOS Button
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'Emergency SOS',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Press in case of emergency',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SosButton(
                        onPressed: _handleSosPressed,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Quick actions
                Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildQuickActionCard(
                      context,
                      'Track Loved Ones',
                      Icons.people,
                      () => Navigator.pushNamed(context, '/tracked_loved_ones'),
                    ),
                    _buildQuickActionCard(
                      context,
                      'Share Location',
                      Icons.share_location,
                      () => Navigator.pushNamed(context, '/share_location'),
                    ),
                    _buildQuickActionCard(
                      context,
                      'File Complaint',
                      Icons.report_problem,
                      () => Navigator.pushNamed(context, '/complaint_form'),
                    ),
                    _buildQuickActionCard(
                      context,
                      'Nearby Police',
                      Icons.local_police,
                      () => Navigator.pushNamed(context, '/police_stations'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

