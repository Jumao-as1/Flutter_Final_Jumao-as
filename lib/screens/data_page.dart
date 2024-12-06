import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/director.dart';
import '../widgets/director_card.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  List<Director> directors = [];
  bool isLoading = true;
  String? errorMessage;
  Dio dio = Dio();

  // Fetch directors from API using Dio
  Future<void> fetchDirectors() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await dio.get(
        'https://jsonplaceholder.typicode.com/users', // Example API for testing
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data; // Dio's response.data
        setState(() {
          directors = data.map((item) {
            return Director.fromJson(item); // Assuming Director has a fromJson constructor
          }).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch directors: ${response.statusCode}');
      }
    } on DioError catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching data: ${e.message}';
      });
      print('DioError: ${e.message}');
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching data: $error';
      });
      print('Error: $error');
    }
  }

  // Delete a director via API using Dio
  Future<void> deleteDirector(int index) async {
    final director = directors[index];
    try {
      final response = await dio.delete(
        'https://jsonplaceholder.typicode.com/users/${director.id}', // Use valid ID for deletion
      );

      if (response.statusCode == 200) {
        setState(() {
          directors.removeAt(index);
        });
      } else {
        throw Exception('Failed to delete director: ${response.statusCode}');
      }
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting director: ${e.message}')),
      );
      print('DioError: ${e.message}');
    }
  }

  // Edit a director
  Future<void> editDirector(int index) async {
    final director = directors[index];
    final nameController = TextEditingController(text: director.name);
    final bioController = TextEditingController(text: director.bio);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Director'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: bioController,
                decoration: InputDecoration(labelText: 'Bio'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                try {
                  final response = await dio.put(
                    'https://jsonplaceholder.typicode.com/users/${director.id}', // Replace with actual ID
                    data: {
                      'name': nameController.text,
                      'company': {
                        'catchPhrase': bioController.text, // Updating bio as catchPhrase
                      },
                    },
                  );

                  if (response.statusCode == 200) {
                    setState(() {
                      directors[index] = Director(
                        id: director.id,
                        name: nameController.text,
                        bio: bioController.text,
                        image: director.image,
                      ); // Replace old director with updated one
                    });
                    Navigator.of(context).pop();
                  } else {
                    throw Exception('Failed to update director: ${response.statusCode}');
                  }
                } on DioError catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating director: ${e.message}')),
                  );
                  print('DioError: ${e.message}');
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchDirectors(); // Fetch data when page is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Directors')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text('Error: $errorMessage'))
              : ListView.builder(
                  itemCount: directors.length,
                  itemBuilder: (context, index) {
                    return DirectorCard(
                      director: directors[index],
                      onDelete: () => deleteDirector(index),
                      onEdit: () => editDirector(index),
                    );
                  },
                ),
    );
  }
}
