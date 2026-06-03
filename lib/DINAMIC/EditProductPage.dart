import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProductPage extends StatefulWidget {
  final DocumentSnapshot product;
  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  late TextEditingController categoryController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.product['title']);
    priceController = TextEditingController(text: widget.product['price']);
    descriptionController = TextEditingController(
      text: widget.product['description'],
    );
    categoryController = TextEditingController(
      text: widget.product['category'],
    );
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.product.id)
          .update({
            'title': titleController.text.trim(),
            'price': priceController.text.trim(),
            'description': descriptionController.text.trim(),
            'category': categoryController.text.trim(),
          });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "✅ Product added successfully",
            style: TextStyle(
              color: Color.fromARGB(255, 248, 246, 246),
            ), 
          ),
          backgroundColor: const Color(0xFFCAB273), // اللون الذهبي
          behavior:
              SnackBarBehavior.floating, // يخليها تطلع بشكل أنيق فوق المحتوى
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // حواف دائرية
          ),
        ),
      );

      Navigator.pop(context);
    }
  }

  InputDecoration _inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Product",
          style: TextStyle(color: Color.fromARGB(255, 248, 246, 246)),
        ),

        backgroundColor: const Color(0xFFCAB273),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: _inputStyle("Title"),
                validator: (value) =>
                    value!.isEmpty ? "Enter product title" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: priceController,
                decoration: _inputStyle("Price"),
                validator: (value) =>
                    value!.isEmpty ? "Enter product price" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descriptionController,
                decoration: _inputStyle("Description"),
                validator: (value) =>
                    value!.isEmpty ? "Enter product description" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: categoryController,
                decoration: _inputStyle("Category"),
                validator: (value) =>
                    value!.isEmpty ? "Enter product category" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCAB273),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
