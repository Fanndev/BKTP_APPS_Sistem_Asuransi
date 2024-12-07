import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAnsuransiPage extends StatefulWidget {
  const AddAnsuransiPage({super.key});

  @override
  _AddAnsuransiPageState createState() => _AddAnsuransiPageState();
}

class _AddAnsuransiPageState extends State<AddAnsuransiPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedIcon = 'health';

  final _icons = {
    'health': Icons.favorite,
    'car': Icons.directions_car,
    'life': Icons.person,
    'home': Icons.home,
  };

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('insurance').add({
        'name': _titleController.text,
        'price': _priceController.text,
        'description': _descriptionController.text,
        'icon': _selectedIcon,
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Insurance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField(
                value: _selectedIcon,
                items: _icons.keys.map((key) {
                  return DropdownMenuItem(
                    value: key,
                    child: Row(
                      children: [
                        Icon(_icons[key]),
                        const SizedBox(width: 8.0),
                        Text(key.toUpperCase()),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedIcon = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Select Icon',
                ),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Insurance'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
