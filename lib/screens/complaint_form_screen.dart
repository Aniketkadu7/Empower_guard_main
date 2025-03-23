import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../widgets/custom_drawer.dart';

class ComplaintFormScreen extends StatefulWidget {
  const ComplaintFormScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintFormScreen> createState() => _ComplaintFormScreenState();
}

class _ComplaintFormScreenState extends State<ComplaintFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime _incidentDate = DateTime.now();
  TimeOfDay _incidentTime = TimeOfDay.now();
  String _selectedCategory = 'Harassment';
  bool _isAnonymous = false;
  bool _isSubmitting = false;

  final List<String> _categories = [
    'Harassment',
    'Stalking',
    'Theft',
    'Assault',
    'Suspicious Activity',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _incidentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _incidentDate) {
      setState(() {
        _incidentDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _incidentTime,
    );
    if (picked != null && picked != _incidentTime) {
      setState(() {
        _incidentTime = picked;
      });
    }
  }

  void _submitComplaint() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isSubmitting = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Complaint submitted successfully'),
            backgroundColor: Colors.green,
          ),
        );

        // Reset form
        _formKey.currentState!.reset();
        _titleController.clear();
        _descriptionController.clear();
        _locationController.clear();
        setState(() {
          _incidentDate = DateTime.now();
          _incidentTime = TimeOfDay.now();
          _selectedCategory = 'Harassment';
          _isAnonymous = false;
        });

        // Navigate back to home
        Navigator.pop(context);
      }
    }
  }

  void _getCurrentLocation() {
    // In a real app, this would use the device's GPS
    setState(() {
      _locationController.text = 'Current Location';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File a Complaint'),
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Non-Emergency Complaint',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Report an incident or suspicious activity in your area',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 24),
                
                // Incident category
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Incident Category',
                    prefixIcon: Icon(Icons.category),
                  ),
                  value: _selectedCategory,
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                  validator: (value) => Validators.validateRequired(value, 'Category'),
                ),
                const SizedBox(height: 16),
                
                // Incident title
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Incident Title',
                    hintText: 'Brief title of the incident',
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (value) => Validators.validateRequired(value, 'Title'),
                ),
                const SizedBox(height: 16),
                
                // Incident description
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Provide details of what happened',
                    prefixIcon: Icon(Icons.description),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 5,
                  validator: (value) => Validators.validateRequired(value, 'Description'),
                ),
                const SizedBox(height: 16),
                
                // Incident location
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    hintText: 'Where did this happen?',
                    prefixIcon: const Icon(Icons.location_on),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.my_location),
                      onPressed: _getCurrentLocation,
                      tooltip: 'Use current location',
                    ),
                  ),
                  validator: (value) => Validators.validateRequired(value, 'Location'),
                ),
                const SizedBox(height: 16),
                
                // Incident date and time
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(context),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          child: Text(
                            '${_incidentDate.day}/${_incidentDate.month}/${_incidentDate.year}',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectTime(context),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Time',
                            prefixIcon: Icon(Icons.access_time),
                          ),
                          child: Text(
                            '${_incidentTime.hour}:${_incidentTime.minute.toString().padLeft(2, '0')}',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Anonymous reporting
                SwitchListTile.adaptive(
                  title: const Text('Report Anonymously'),
                  subtitle: const Text('Your identity will not be disclosed'),
                  value: _isAnonymous,
                  onChanged: (value) {
                    setState(() {
                      _isAnonymous = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                
                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitComplaint,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Submit Complaint'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

