import 'package:flutter/material.dart';

class AddExpenseForm extends StatefulWidget {
  const AddExpenseForm({super.key});

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  String? selectedCategory;
  final List<String> categories = ['Food', 'Transport', 'Shopping', 'Health'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Date"),
        _buildInputField(hint: "April 30, 2024", icon: Icons.calendar_today_outlined),
        const SizedBox(height: 20),

        _buildLabel("Category"),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(30),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Select the category"),
              value: selectedCategory,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: categories.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() => selectedCategory = newValue);
              },
            ),
          ),
        ),
        const SizedBox(height: 20),

        _buildLabel("Amount"),
        _buildInputField(hint: "USD 26,00", keyboardType: TextInputType.number),
        const SizedBox(height: 20),

        _buildLabel("Expense Title"),
        _buildInputField(hint: ""),
        const SizedBox(height: 20),

        _buildLabel("Enter Message"),
        _buildInputField(hint: "", maxLines: 4),
        const SizedBox(height: 40),

        // Save Button
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: () {
             //State Management 
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007BFF),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text("Save", style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ),
      ],
    );
  }

  // WidgetLabels
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 5),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF003366))),
    );
  }

  Widget _buildInputField({required String hint, IconData? icon, TextInputType? keyboardType, int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
        filled: true,
        fillColor: const Color(0xFFE3F2FD),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(maxLines > 1 ? 20 : 30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}