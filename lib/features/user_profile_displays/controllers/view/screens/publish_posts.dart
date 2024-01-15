import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindplex/features/user_profile_displays/controllers/publishedPostsController.dart';
import 'package:mindplex/features/user_profile_displays/view/widgets/blog_shimmer.dart';
import "../widgets/blog-widget.dart";
import 'package:mindplex/utils/status.dart';

class PublishedPosts extends StatelessWidget {
  PublishedPosts({super.key});

  final PublishPostController publishPostController =
      Get.put(PublishPostController());

  @override
  Widget build(BuildContext context) {
    publishPostController.loadBlogs();
    return Container(
      child: Obx(() {
        return publishPostController.status == Status.loading
            ? ListView.builder(
                itemCount: 3,
                itemBuilder: (ctx, inx) => const BlogSkeleton(),
              )
            : publishPostController.status == Status.error
                ? Center(
                    child: Icon(Icons.error),
                  )
                : ListView.separated(
                    controller: publishPostController.scrollController,
                    itemCount: publishPostController.blogs.length + 1,
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      if (publishPostController.status == Status.loadingMore &&
                          index == publishPostController.blogs.length) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (ctx, inx) => const BlogSkeleton(),
                        );
                      } else if (publishPostController.status !=
                              Status.loadingMore &&
                          index == publishPostController.blogs.length) {
                        return SizedBox(height: 10);
                      }

                      return BlogWidget(
                          publishedPost: publishPostController.blogs[index]);
                    });
      }),
    );
  }
}


// email: email@mindplex.ai
// password: QQ!!qq11QQ!!qq11