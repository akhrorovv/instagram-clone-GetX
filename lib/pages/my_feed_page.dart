import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controllers/feed_controller.dart';
import '../model/post_model.dart';
import '../views/item_feed.dart';

class MyFeedPage extends StatefulWidget {
  final PageController? pageController;

  const MyFeedPage({Key? key, this.pageController}) : super(key: key);

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  final feedController = Get.find<FeedController>();

  @override
  void initState() {
    super.initState();
    feedController.apiLoadFeeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Instagram",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Billabong',
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.pageController!.animateToPage(
                2,
                duration: const Duration(microseconds: 200),
                curve: Curves.easeIn,
              );
            },
            icon: const Icon(Icons.camera_alt),
            color: const Color.fromRGBO(193, 53, 132, 1),
          ),
        ],
      ),
      body: GetBuilder<FeedController>(
        builder: (_) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: feedController.items.length,
                itemBuilder: (ctx, index) {
                  return itemOfFeedPost(
                      feedController.items[index], feedController, context);
                },
              ),
              feedController.isLoading
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
