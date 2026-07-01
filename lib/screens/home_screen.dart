import 'package:book_library_mangement/models/book_model.dart';
import 'package:book_library_mangement/screens/add_book.dart';
import 'package:book_library_mangement/services/api_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiServices api = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Books"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<BookModel>(
        future: api.fetchingBooks(),
        builder: (context, snapshot) {
          final bookData = snapshot.data!.books!;

          return Expanded(
            child: ListView.builder(
              itemCount: bookData!.length,
              itemBuilder: (context, index) {
                final book = bookData[index];

                return ListTile(
                  leading: Text("${index + 1}"),
                  title: Text("${book.title}"),
                  subtitle: Text("${book.author}"),
                  trailing: Text("Published:${book.publishedYear}"),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBookScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.green),
      ),
    );
  }
}
