import 'package:flutter/material.dart';

import 'about_us.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/person.jpg'), // يمكنك تغيير الصورة هنا
            ),
            SizedBox(height: 20),
            Text(
              'Beter kol', // اسم المستخدم
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Beter.kol@gamil.com', // البريد الإلكتروني
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.phone,color: Colors.green),
              title: Text('Phone'),
              subtitle: Text('+123 456 7890'),
            ),
            ListTile(
              leading: Icon(Icons.location_on,color: Colors.orange),
              title: Text('Address'),
              subtitle: Text('123 Market Street, City, Country'),
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Payment Methods'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height *0.1),
           GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder:
                    (context) => AboutUS()));},
              child: Container(
                width: MediaQuery.of(context).size.height *0.14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                ),
                
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.business),
                      Text('  About us',
                        textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.orange[700]
                      )),
                      SizedBox(width: 10,)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
