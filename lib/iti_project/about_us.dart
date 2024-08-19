import 'package:flutter/material.dart';

class AboutUS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Application'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'About Our App',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Market App is an online market That contain differient categories of products.'
                  'Our Flutter application is a cross-platform mobile app that provides a great user experience. We\'ve used the latest features of the Flutter framework to create a beautiful and responsive UI.',
            ),
            SizedBox(height: 20.0),
            Text(
              'Meet the Developers',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 10.0),
            DeveloperCard(
              image: 'assets/images/me.jpg',
              name: 'Abdulrahman Ashraf Mokhtar',
              role: 'Flutter Developer',
              bio: 'Abdulrahman is an experienced Flutter developer with a passion for creating innovative mobile apps.',
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '© 2024 Our Flutter Application. All rights reserved.',
            style: TextStyle(color: Colors.white),
          ),
        ),
        color: Colors.orange,
      ),
    );
  }
}

class DeveloperCard extends StatelessWidget {
  final String image;
  final String name;
  final String role;
  final String bio;

  DeveloperCard({
    required this.image,
    required this.name,
    required this.role,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(image),
              radius: 40.0,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    role,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Row(children: [
                    Icon(Icons.phone,color: Colors.green,size: 18),
                    Text(" 01032671164")
                  ],),
                  SizedBox(height: 8.0),
                  Text(bio),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}