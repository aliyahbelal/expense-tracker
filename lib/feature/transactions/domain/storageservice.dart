import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'expense_model.dart';

class StorageService {
  // حفظ قائمة المصاريف
  static Future<void> saveExpenses(List<ExpenseModel> expenses) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data = expenses.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('my_expenses', data);
  }

  // جلب قائمة المصاريف
  static Future<List<ExpenseModel>> getExpenses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? data = prefs.getStringList('my_expenses');
      if (data == null) return [];
      return data.map((item) => ExpenseModel.fromJson(jsonDecode(item))).toList();
    } catch (e) {
      print('Error loading expenses: $e');
      return [];
    }
  }
}