//When your Json stars from Array then Previous Approaches will be followed and if Json starts from Object and
// then this approach will will be followed.
//1) https://webhook.site/d24f9761-dfba-47...
//2) http://jsonviewer.stack.hu(Use to find API Structure after hitting in Postman)

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled2/model/Product_Model.dart';

class ComplecObjecApi extends StatefulWidget {
  const ComplecObjecApi({super.key});

  @override
  State<ComplecObjecApi> createState() => _ComplecObjecApiState();
}

class _ComplecObjecApiState extends State<ComplecObjecApi> {
  Future<ProductModel> getproduct() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/904702dd-5b69-4845-bc3e-66bcc316cae1'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return ProductModel.fromJson(data);
    } else {
      return ProductModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithRoundedBorder(),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ProductModel>(
                  future: getproduct(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(snapshot
                                      .data!.data![index].shop!.name
                                      .toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: Text(snapshot
                                      .data!.data![index].shop!.shopemail
                                      .toString()),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(snapshot
                                        .data!.data![index].shop!.image
                                        .toString()),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .3,
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.data!.length,
                                      itemBuilder: (context, position) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .25,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .5,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          snapshot
                                                              .data!
                                                              .data![index]
                                                              .images![position]
                                                              .url
                                                              .toString())))),
                                        );
                                      }),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(snapshot.data!.data![index]
                                                .inWishlist! ==
                                            true
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(Icons.comment),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(Icons.send),
                                  ],
                                )
                              ],
                            );
                          });
                    } else {
                      return const Text('Loading');
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}


class AppBarWithRoundedBorder extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWithRoundedBorder({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + .0); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
      child: AppBar(
        title: const Text('REST APIs'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        // Add other AppBar properties as needed
      ),
    );
  }
}