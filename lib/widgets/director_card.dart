import 'package:flutter/material.dart';
import '../models/director.dart';

class DirectorCard extends StatelessWidget {
  final Director director;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  DirectorCard({
    required this.director,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: director.image != null && director.image!.isNotEmpty
              ? NetworkImage(director.image!)
              : AssetImage('assets/images/default.png') as ImageProvider,
        ),
        title: Text(director.name),
        subtitle: Text(director.bio),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
