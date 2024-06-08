import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final bookdatabase = FirebaseFirestore.instance;
Future<QuerySnapshot> books = bookdatabase.collection('books').get();

class BookABook extends StatefulWidget {
  const BookABook({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BookABookState();
  }
}

class _BookABookState extends State<BookABook> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/images/DTU.png'), opacity: 0.3)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: books,
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future: getDetails(documents[index].id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else {
                          List<String>? details =
                              snapshot.data; // Change type to List<String>?
                          if (details == null || details.length < 5) {
                            return const Text('Invalid book details');
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 100,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                details[0],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 182,
                                        width: 200,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        documents[index].id,
                                                        style: const TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          details[1],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  'Author: ${details[2]}',
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  'Edition: ${details[4]}',
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  'No of Copies: ${details[3]}',
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    );
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(
              child: Text(
                'Loading...',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<List<String>> getDetails(String bookid) async {
    final bookData =
        await FirebaseFirestore.instance.collection('books').doc(bookid).get();
    if (bookData.exists) {
      final imageURL =
          bookData['imageURL'] != null ? bookData['imageURL'].toString() : '';
      final name = bookData['Name'] != null ? bookData['Name'].toString() : '';
      final author =
          bookData['Author'] != null ? bookData['Author'].toString() : '';
      final noOfCopies = bookData['NoOfCopies'] != null
          ? bookData['NoOfCopies'].toString()
          : '';
      final edition =
          bookData['Edition'] != null ? bookData['Edition'].toString() : '';
      return [imageURL, name, author, noOfCopies, edition];
    } else {
      return [];
    }
  }
}
