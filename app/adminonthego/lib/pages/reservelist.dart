// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final reservedbookdatabase = FirebaseFirestore.instance;

class ReservedList extends StatefulWidget {
  const ReservedList({super.key, required this.userId});
  final String userId;

  @override
  State<ReservedList> createState() {
    return _ReservedListState();
  }
}

class _ReservedListState extends State<ReservedList> {
  @override
  void initState() {
    super.initState();
    print(widget.userId);
  }

  Future<List<String>> getDetails(String id) async {
    final details =
        await FirebaseFirestore.instance.collection('Reserved').doc(id).get();
    final bookID = details['bookID'];
    final bookData =
        await FirebaseFirestore.instance.collection('books').doc(bookID).get();
    if (bookData.exists) {
      // print(details['userID']);
      return [
        bookData['imageURL'].toString(),
        bookData['Name'].toString(),
        bookData['Author'].toString(),
        bookData['bookID'].toString(),
        bookData['Edition'].toString(),
        details['userID'].toString(),
      ];
    } else {
      return [];
    }
  }

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
          future: reservedbookdatabase.collection('Reserved').get(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                    future: getDetails(documents[index].id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        List<String>? details = snapshot.data;
                        if (details == null || details[5] != widget.userId) {
                          print('object');
                          return const Text(' ');
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
                                                      details[3],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
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
                },
              );
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
}
