import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/controllers/likes_controller.dart';

import '../model/post_model.dart';

Widget itemOfLikesPost(
    Post post, LikesController likesController, BuildContext context) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        const Divider(),
        //#user info
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: post.img_user.isEmpty
                        ? const Image(
                            image: AssetImage("assets/images/ic_person.png"),
                            width: 40,
                            height: 40,
                          )
                        : Image.network(
                            post.img_user,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.fullname,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        post.date,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
              post.mine
                  ? IconButton(
                      icon: const Icon(Icons.more_horiz),
                      onPressed: () {
                        likesController.dialogRemovePost(post, context);
                      },
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        //#post image
        const SizedBox(height: 8),
        GestureDetector(
          onDoubleTap: () {
            likesController.apiPostUnLike(post);
          },
          child: CachedNetworkImage(
            width: MediaQuery.of(context).size.width,
            imageUrl: post.img_post,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),

        //#like share
        Row(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    likesController.apiPostUnLike(post);
                  },
                  icon: post.liked
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                ),
              ],
            )
          ],
        ),

        //#caption
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: RichText(
            softWrap: true,
            overflow: TextOverflow.visible,
            text: TextSpan(
              text: post.caption,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    ),
  );
}
