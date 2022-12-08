import 'package:day_one/model/news_model.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Articles articles;
  const DetailsPage({
    Key? key,
    required this.articles,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Center(
        child: Container(
          height: 100,
          width: double.infinity,
          color: Colors.blue[100],
          child: Text(widget.articles.content.toString()),
        ),
      ),
    );
  }
}
