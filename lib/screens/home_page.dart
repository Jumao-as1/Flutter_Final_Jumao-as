import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Directors Info')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
  'assets/images/wallpaper.jpg',
  height: 300, width: 300,
  errorBuilder: (context, error, stackTrace) {
    return Text('Image not found');
  },
),

            ElevatedButton.icon(
              icon: Icon(Icons.person),
              label: Text('Profile'),
              onPressed: () => Navigator.pushNamed(context, '/profile'),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.list),
              label: Text('Directors'),
              onPressed: () => Navigator.pushNamed(context, '/data'),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.map),
              label: Text('Map'),
              onPressed: () => Navigator.pushNamed(context, '/map'),
            ),
          ],
        ),
      ),
    );
  }
}
