import 'package:flutter/material.dart';
import 'package:timid/widgets/top_nav_bar.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(
        text: "Chats",
      ),
    );
  }
}
