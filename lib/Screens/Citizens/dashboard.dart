import 'package:flutter/material.dart';

class Citizendashboard extends StatefulWidget {
  const Citizendashboard({super.key});

  @override
  State<Citizendashboard> createState() => _CitizendashboardState();
}

class _CitizendashboardState extends State<Citizendashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Citizen dashboard"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: Text("Hi Citizen"))
          ],
        ),
      ),
    );
  }
}
