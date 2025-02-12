import 'package:flutter/material.dart';
import 'package:timid/widgets/top_nav_bar.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(
        text: "People",
      ),
    );
  }
}
