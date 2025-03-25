import 'package:flutter/material.dart';
import 'quote.dart';

class QuoteDialog extends StatefulWidget {
  final Quote? quote; // Optional quote for editing mode
  final Function(String author, String text) onSubmit;

  const QuoteDialog({super.key, this.quote, required this.onSubmit});

  @override
  State<QuoteDialog> createState() => _QuoteDialogState();
}

class _QuoteDialogState extends State<QuoteDialog> {
  late TextEditingController _authorController;
  late TextEditingController _quoteController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _authorController = TextEditingController(text: widget.quote?.author ?? '');
    _quoteController = TextEditingController(text: widget.quote?.text ?? '');
  }

  @override
  void dispose() {
    _authorController.dispose();
    _quoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.quote == null ? 'Add New Quote' : 'Update Quote'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _authorController,
              decoration: const InputDecoration(
                hintText: 'Author',
                labelText: 'Author Name',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _quoteController,
              decoration: const InputDecoration(
                hintText: 'Quote',
                labelText: 'Quote Text',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(widget.quote == null ? 'Add' : 'Update'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onSubmit(
                        _authorController.text.trim(),
                        _quoteController.text.trim(),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}