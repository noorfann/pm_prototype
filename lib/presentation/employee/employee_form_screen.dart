import 'package:flutter/material.dart';

class EmployeeFormScreen extends StatefulWidget {
  const EmployeeFormScreen({super.key});

  @override
  State<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 600,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(top: 24),
            padding: const EdgeInsets.all(16.0),
            child: Form(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Employee Form', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Name'),
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface,
                          width: 2.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface,
                          width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Email'),
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface,
                          width: 2.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface,
                          width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Submit',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      )),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
