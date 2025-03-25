import 'package:flutter/material.dart';
import 'quote.dart';
import 'quote_card.dart';
import 'quote_dialog.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(MaterialApp(home: QuoteList()));

class QuoteList extends StatefulWidget {
  const QuoteList({super.key});

  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  static final _uuid = Uuid();
  late List<Quote> quotes;

  @override
  void initState() {
    super.initState();
    quotes = [
      Quote(
        author: 'Oscar Wilde',
        text: 'Be yourself; everyone else is already taken',
        id: _uuid.v4(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Quote(
        author: 'Oscar Wilde',
        text: 'I have nothing to declare except my genius',
        id: _uuid.v4(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Quote(
        author: 'Oscar Wilde',
        text: 'The truth is rarely pure and never simple',
        id: _uuid.v4(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return QuoteDialog(
                    onSubmit: (author, text) {
                      setState(() {
                        quotes.add(
                          Quote(author: author, text: text, id: _uuid.v4(), createdAt: DateTime.now(), updatedAt: DateTime.now()),
                        );
                      });
                    },
                  );
                },
              );
            },
            tooltip: 'Create Quote',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: quotes
              .map((quote) => QuoteCard(
                    quote: quote,
                    update: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return QuoteDialog(
                            quote: quote,
                            onSubmit: (newAuthor, newQuoteText) {
                              setState(() {
                                quotes[quotes.indexOf(quote)] = Quote(
                                  author: newAuthor,
                                  text: newQuoteText,
                                  id: quote.id,
                                  createdAt: quote.createdAt,
                                  updatedAt: DateTime.now(),
                                );
                              });
                            },
                          );
                        },
                      );
                    },
                    delete: () {
                      setState(() {
                        quotes.remove(quote);
                      });
                    },
                  ))
              .toList()
            ..sort((a, b) => b.quote.updatedAt.compareTo(a.quote.updatedAt)),
        ),
      ),
    );
  }
}
