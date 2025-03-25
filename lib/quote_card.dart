import 'package:flutter/material.dart';
import 'quote.dart';

class QuoteCard extends StatelessWidget {

  final Quote quote;
  final Function delete;
  final Function update;
  const QuoteCard({super.key,  required this.quote, required this.delete, required this.update });

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                quote.text,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                quote.author,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8.0),
              ElevatedButton.icon(
                onPressed: () => delete(),
                label: Text('delete quote'),
                icon: Icon(Icons.delete),
              ),
              ElevatedButton.icon(
                onPressed: () => update(),
                label: Text('update quote'),
                icon: Icon(Icons.update),
              ),
              Text(
                "Created At: ${quote.createdAt.toString().substring(0, 19)}",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.right
              ),
              Text(
                "Updated At: ${quote.updatedAt.toString().substring(0, 19)}",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        )
    );
  }
}