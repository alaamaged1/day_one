import 'package:day_one/controller/data_base.dart';
import 'package:day_one/controller/database.dart';
import 'package:day_one/controller/user_model.dart';
import 'package:day_one/model/news_model.dart';
import 'package:flutter/material.dart';

import 'auth/register.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NewsController newsController = NewsController();
  SqlDb sqlDb = SqlDb();
  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: Drawer(
            child: FutureBuilder(
              future: readData(),
              builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Text(snapshot.data![index]['email'].toString());
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          appBar: AppBar(title: const Text('News App'), actions: [
            Builder(builder: (context) {
              return InkWell(
                  onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage())),
                  child: const Text('Sign Out'));
            }),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SafeArea(
                child: SingleChildScrollView(
              child: Center(
                child: FutureBuilder(
                    future: newsController.fetchNews(),
                    builder: (context, AsyncSnapshot<List<Articles>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          List<Articles>? articles = snapshot.data;
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: articles!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    color: Colors.blue[100],
                                    child: ListTile(
                                      title: InkWell(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (_) => DetailsPage(
                                                        articles:
                                                            articles[index],
                                                      ))),
                                          child: Text(
                                              articles[index].content == null
                                                  ? "No data"
                                                  : articles[index]
                                                      .content
                                                      .toString())),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      );
                    }),
              ),
            )),
          ),
        ));
  }
}
