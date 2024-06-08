import 'package:adminonthego/pages/borroworreserve.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final studentbase = FirebaseFirestore.instance;

class StudentDetails extends StatefulWidget {
  const StudentDetails({Key? key}) : super(key: key);

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  late Future<QuerySnapshot> studentsFuture;

  @override
  void initState() {
    super.initState();
    studentsFuture = studentbase.collection('users').get();
  }

  Future<List<String>> getDetails(String userid) async {
    final studentData =
        await FirebaseFirestore.instance.collection('users').doc(userid).get();
    if (studentData.exists && studentData.id != 'admin') {
      final imageURL = studentData['imageUrl'] ?? '';
      final name = studentData['username'] ?? '';
      final rollNo = studentData['rollNo'] ?? '';
      final contact = studentData['contact'] ?? '';
      final email = studentData['email'] ?? '';
      final yos = studentData['yos'] ?? '';
      final branch = studentData['branch'] ?? '';
      return [imageURL, name, rollNo, contact, email, yos, branch];
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
          image: AssetImage('assets/images/DTU.png'),
          opacity: 0.3,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<QuerySnapshot>(
          future: studentsFuture,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<List<String>>(
                    future: getDetails(documents[index].id),
                    builder: (context, detailsSnapshot) {
                      if (detailsSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (detailsSnapshot.hasError) {
                        return Center(
                          child: Text('Error: ${detailsSnapshot.error}'),
                        );
                      } else if (detailsSnapshot.hasData) {
                        List<String>? details = detailsSnapshot.data;
                        if (details == null || details.isEmpty) {
                          return const Text(' ');
                        }
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BorrowOrReserve(
                                                          userId:
                                                              documents[index]
                                                                  .id)));
                                        },
                                        icon: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black, width: 5),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(details[0]),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 250,
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
                                                  const SizedBox(width: 10),
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        details[1],
                                                        style: const TextStyle(
                                                            fontSize: 20),
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
                                                'Roll No.: ${details[2]}',
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                'Email ID: ${details[4]}',
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                'Contact: +91 ${details[3]}',
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                'Branch: ${details[6]}',
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                'Year of Study: ${details[5]}',
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  );
                },
              );
            }
            return const Center(
              child: Text(
                'No data available',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            );
          },
        ),
      ),
    );
  }
}
