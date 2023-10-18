import 'package:flutter/material.dart';

Widget buildTextField({
  required String label,
  required String hint,
  required String value,
  required Function(String) onChanged,
}) {
  return Column(
    children: [
      Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintTextDirection: TextDirection.rtl,
            labelText: label,
            hintText: hint,
            labelStyle: const TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            contentPadding: const EdgeInsets.all(16.0),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onChanged: onChanged,
          controller: TextEditingController(text: value),
        ),
      ),
      const SizedBox(height: 16.0),
    ],
  );
}
