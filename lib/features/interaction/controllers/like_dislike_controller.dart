import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:mindplex/features/blogs/controllers/blogs_controller.dart';
import 'package:mindplex/features/blogs/models/blog_model.dart';
import 'package:mindplex/services/api_services.dart';
import 'package:mindplex/utils/constatns.dart';

class LikeDislikeConroller extends GetxController {
  RxBool isLoading = true.obs;
  final apiService = ApiService().obs;
  RxBool showEmoji = false.obs;
  RxBool reactedWithEmoji = false.obs;
  RxBool hasVoted = false.obs;
  RxBool hasBookMarked = false.obs;
  RxList currentEmoji = [
    "😅",
  ].obs;

  Future<void> likeDislikeArticle(
      {required int index,
      required Blog blog,
      required String articleSlug,
      required String interction}) async {
    apiService.value
        .likeDislikeArticle(articleSlug: articleSlug, interction: interction);
    final BlogsController blogsController = Get.find();

// logic for incrementing and decrmenting like and dislike counter realtime
    if (blog.isUserLiked.value == true && interction == "D") {
      blog.likes.value -= 1;
    } else if (blog.isUserDisliked.value == true && interction == "L") {
      blog.likes.value += 1;
    } else if (blog.isUserDisliked.value == false &&
        blog.isUserLiked.value == false) {
      if (interction == "L") {
        blog.likes.value += 1;
      }
    }

    if (interction == "D") {
      blog.isUserDisliked.value = true;

      blog.isUserLiked.value = false;

      blogsController.blogs[index] = blog;
    } else {
      blog.isUserDisliked.value = false;
      blog.isUserLiked.value = true;
      blogsController.blogs[index] = blog;
    }
  }

  void reactWithEmoji(
      {required int emojiIndex, required int blogIndex, required Blog blog}) {
    final BlogsController blogsController = Get.find();

    apiService.value.reactWithEmoji(
        articleSlug: blog.slug ?? "", emoji_value: emojiCodes[emojiIndex]);

    blog.interactedEmoji.value = emojiCodes[emojiIndex];

    blogsController.blogs[blogIndex] = blog;

    showEmoji.value = !showEmoji.value;
  }

  void addVote() {
    hasVoted.value = !hasVoted.value;
  }

  void addToBookmark() {
    hasBookMarked.value = !hasBookMarked.value;
  }

  Future<void> removePreviousInteraction(
      {required int index,
      required Blog blog,
      required String articleSlug,
      required String interction}) async {
    final BlogsController blogsController = Get.find();

    apiService.value.removePreviousInteraction(
        articleSlug: articleSlug, interction: interction);

    if (blog.isUserLiked.value == true && interction == "L") {
      blog.likes.value -= 1;
    }

    blog.isUserDisliked.value = false;
    blog.isUserLiked.value = false;
    blogsController.blogs[index] = blog;
  }
}
