import 'package:flutter/material.dart';
import 'package:tokma_weather_app/extensions/context_extensions.dart';

class LocationInput extends StatefulWidget {
  final String? initialLocation;
  final Function(String) onSubmit;

  const LocationInput({
    super.key,
    this.initialLocation,
    required this.onSubmit,
  });

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialLocation ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Location',
                hintText: 'Enter city name',
                prefixIcon: Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => widget.onSubmit(_controller.text.trim()),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                foregroundColor: context.colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(_controller.text.isEmpty ? 'Save' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
