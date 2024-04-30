import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controllers/likes_controller.dart';
import '../model/post_model.dart';
import '../views/item_likes.dart';

class MyLikesPage extends StatefulWidget {
  const MyLikesPage({Key? key}) : super(key: key);

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  final likesController = Get.find<LikesController>();

  @override
  void initState() {
    super.initState();
    likesController.apiLoadLikes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Likes",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Billabong',
            fontSize: 30,
          ),
        ),
      ),
      body: GetBuilder<LikesController>(
        builder: (_) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: likesController.items.length,
                itemBuilder: (ctx, index) {
                  return itemOfLikesPost(
                      likesController.items[index], likesController, context);
                },
              ),
              likesController.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}
