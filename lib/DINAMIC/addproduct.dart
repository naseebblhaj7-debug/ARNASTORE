import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection("products").add({
        "title": titleController.text.trim(),
        "price": priceController.text.trim(),
        "description": descriptionController.text.trim(),
        "category": categoryController.text.trim(),
        "createdAt": FieldValue.serverTimestamp(),
      });

    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
                          backgroundColor: Color(0xFFCAB273),
                          content: const Text("✅ Order added successfully"),
  
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
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product",
       style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),),),
       
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
                decoration: _inputStyle("Product Title"),
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
                onPressed: _addProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCAB273),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Add Product",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ,color: Color.fromARGB(255, 255, 255, 255),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
