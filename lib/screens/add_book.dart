import 'package:book_library_mangement/services/api_services.dart';
import 'package:flutter/material.dart';

class AddBookScreen extends StatelessWidget {
  AddBookScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController publishedYearController = TextEditingController();
  ApiServices api = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Book")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: authorController,
              decoration: const InputDecoration(
                labelText: "Author",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: publishedYearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Published Year",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final pb = int.parse(publishedYearController.text);
                  await api.addBook(
                    title: titleController.text,
                    author: authorController.text,
                    category: categoryController.text,
                    publishedYear: pb,
                  );
                  Navigator.pop(context);
                },
                child: const Text("Add Book"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
