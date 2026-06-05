import 'package:appr/screens/base_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appr/DINAMIC/addproduct.dart';
import 'EditProductPage.dart';
import 'package:appr/widgets/app_bar.dart';
import '../widgets/snakbar.dart'; // استدعاء الكلاس الجديد

class DashboardPage extends StatelessWidget {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Dashboard",
        showBack: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              AppSnackBar.show(
                context,
                message: "🚪 Logged out successfully",
                icon: Icons.logout,
              );
              Navigator.pushReplacementNamed(context, "base_page");
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: products.orderBy("createdAt", descending: false).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var product = docs[index];
              return Card(
                child: ListTile(
                  title: Text(product['title']),
                  subtitle: Text("السعر: ${product['price']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditProductPage(product: product),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await products.doc(product.id).delete();
                          AppSnackBar.show(
                            context,
                            message: "🗑️ Product deleted",
                            icon: Icons.delete,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFCAB273),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductPage()),
          );
        },
      ),
    );
  }
}
