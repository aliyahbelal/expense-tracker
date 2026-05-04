import 'package:flutter/material.dart';
import 'transactions_model.dart';
import 'transaction_tile.dart';

// ===== شاشة كل المصاريف =====
// دي الشاشة الكاملة اللي إنتي مسؤولة عنها

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ===== بيانات وهمية للتجربة =====
    // لما شيماء وعلا يخلصوا الـ Database، هنجيب البيانات منه
    // بس دلوقتي بنحط بيانات ثابتة عشان نشوف الشكل

    final List<TransactionModel> transactions = [
      TransactionModel(
        category: 'أكل',
        amount: 50,
        date: DateTime.now(),
        icon: '🍔',
      ),
      TransactionModel(
        category: 'مواصلات',
        amount: 30,
        date: DateTime.now(),
        icon: '🚗',
      ),
      TransactionModel(
        category: 'تسوق',
        amount: 200,
        date: DateTime.now().subtract(const Duration(days: 1)),
        icon: '🛍️',
      ),
      TransactionModel(
        category: 'صحة',
        amount: 80,
        date: DateTime.now().subtract(const Duration(days: 1)),
        icon: '💊',
      ),
      TransactionModel(
        category: 'تعليم',
        amount: 150,
        date: DateTime.now().subtract(const Duration(days: 2)),
        icon: '📚',
      ),
      TransactionModel(
        category: 'ترفيه',
        amount: 60,
        date: DateTime.now().subtract(const Duration(days: 3)),
        icon: '🎬',
      ),
    ];

    // ===== حساب الإجمالي =====
    // fold = بيجمع كل الأرقام مع بعض
    final double total = transactions.fold(
      0,
      (sum, item) => sum + item.amount,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF), // لون الخلفية

      body: Column(
        children: [

          // ===== الهيدر العلوي البنفسجي =====
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 60,
              left: 20,
              right: 20,
              bottom: 32,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                // تدرج من بنفسجي لأزرق
                colors: [Color(0xFF7C3AED), Color(0xFF4F46E5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                // زوايا دايرية بس من تحت
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان
                const Text(
                  'كل المصاريف',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                // الإجمالي
                Text(
                  'الإجمالي: ${total.toStringAsFixed(0)} ج',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          // ===== قايمة المصاريف =====
          Expanded(
            // Expanded = بيملا باقي الشاشة
            child: ListView.builder(
              // ListView = بيعمل قايمة قابلة للتمرير
              padding: const EdgeInsets.only(top: 16, bottom: 20),
              itemCount: transactions.length, // عدد العناصر
              itemBuilder: (context, index) {
                // بيعمل كارت لكل معاملة
                return TransactionTile(
                  transaction: transactions[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
