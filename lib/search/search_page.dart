import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mindplex_app/utils/colors.dart';

import '../blogs/blogs_controller.dart';
import '../blogs/screens/blog_detail_page.dart';
import '../blogs/widgets/blog_card.dart';
import '../blogs/widgets/blog_shimmer.dart';
import '../mindplex_profile/about/about_mindplex.dart';
import '../mindplex_profile/moderators/moderators_page.dart';
import '../profile/user_profile_controller.dart';
import '../routes/app_routes.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  BlogsController blogsController = Get.put(BlogsController());

  GlobalKey<ScaffoldState> _globalkey = GlobalKey<ScaffoldState>();

  ProfileController profileController = Get.put(ProfileController());
  TextEditingController _searchController = TextEditingController();
  bool isIntialLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF0c2b46),
    key: _globalkey,
    drawer: Drawer(
    child: BackdropFilter(
    blendMode: BlendMode.srcOver,
    filter: ImageFilter.blur(
    sigmaX: 13.0, sigmaY: 13.0, tileMode: TileMode.clamp),
    child: Container(
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF062f46), Color(0xFF1d253d)],
    )),
    child: ListView(
    padding: EdgeInsets.only(top: 20, left: 20),
    children: [
    Obx(
    () => Container(
    height: 200,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Container(
    height: 50,
    width: 50,
    margin:
    EdgeInsets.only(top: 40, left: 10, bottom: 15),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    color: Color(0xFF0c2b46),
    image: DecorationImage(
    fit: BoxFit.cover,
    image: NetworkImage(profileController
        .authenticatedUser.value.image ??
    ""),
    ),
    ),
    child: Container()),
    Container(
    margin: const EdgeInsets.only(left: 5),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    profileController
        .authenticatedUser.value.firstName ??
    " " +
    '${profileController.authenticatedUser.value.lastName}' ??
    " ",
    style: TextStyle(
    fontSize: 30,
    color: Colors.white,
    fontWeight: FontWeight.bold),
    ),
    SizedBox(
    height: 10,
    ),
    Text(
    profileController
        .authenticatedUser.value.username ??
    " ",
    style:
    TextStyle(fontSize: 15, color: Colors.grey),
    ),
    SizedBox(
    height: 10,
    ),
    Row(
    children: [
    Row(
    children: [
    Text(
    profileController
        .authenticatedUser.value.friends
        .toString(),
    style: TextStyle(
    fontSize: 10,
    color: Colors.white,
    fontWeight: FontWeight.bold),
    ),
    Text(
    " Friends",
    style: TextStyle(
    fontSize: 10, color: Colors.grey),
    ),
    ],
    ),
    SizedBox(
    width: 5,
    ),
    Row(
    children: [
    Text(
    profileController
        .authenticatedUser.value.followings
        .toString(),
    style: TextStyle(
    fontSize: 10,
    color: Colors.white,
    fontWeight: FontWeight.bold),
    ),
    Text(
    " Following",
    style: TextStyle(
    fontSize: 10, color: Colors.grey),
    ),
    ],
    ),
    SizedBox(
    width: 5,
    ),
    Row(
    children: [
    Text(
    profileController
        .authenticatedUser.value.followers
        .toString(),
    style: TextStyle(
    fontSize: 10,
    color: Colors.white,
    fontWeight: FontWeight.bold),
    ),
    Text(
    " Followers",
    style: TextStyle(
    fontSize: 10, color: Colors.grey),
    ),
    ],
    ),
    ],
    )
    ],
    ),
    )
    ],
    ),
    ),
    ),
    const SizedBox(
    height: 20,
    ),
    Container(
    padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
    margin: const EdgeInsets.only(right: 40),
    decoration: const BoxDecoration(
    color: Color(0xFF0f3e57),
    borderRadius: BorderRadius.all(Radius.circular(20))),
    child: ListTile(
    leading: const Icon(
    Icons.person,
    color: Colors.white,
    size: 25,
    ),
    title: const Text(
    'Profile',
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white),
    ),
    onTap: () {
    Navigator.of(context).pop();
    Get.toNamed(AppRoutes.profilePage,
    parameters: {"me": "me", "username": ""});
    // ...
    },
    ),
    ),
    const SizedBox(
    height: 10,
    ),
    ListTile(
    leading: const Icon(
    Icons.upgrade_rounded,
    size: 25,
    color: Color(0xFFf55586),
    ),
    title: const Text(
    'Upgrade',
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xFFf55586)),
    ),
    onTap: () {
    // ...
    },
    ),
    ListTile(
    leading: const Icon(
    Icons.description_outlined,
    size: 25,
    color: Colors.white,
    ),
    title: const Text(
    'Read',
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white),
    ),
    onTap: () {
    blogsController.filterBlogsByPostType(postType: 'text');
    Navigator.pop(context);
    },
    ),
    ListTile(
    leading: const Icon(
    Icons.videocam,
    size: 25,
    color: Colors.white,
    ),
    title: const Text(
    'Watch',
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white),
    ),
    onTap: () {
    blogsController.filterBlogsByPostType(postType: 'video');
    Navigator.pop(context);
    },
    ),
    ListTile(
    leading: const Icon(
    Icons.headphones,
    size: 25,
    color: Colors.white,
    ),
    title: const Text(
    'Listen',
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white),
    ),
    onTap: () {
    blogsController.filterBlogsByPostType(postType: 'audio');
    Navigator.pop(context);
    },
    ),
    ListTile(
    leading: const Icon(
    Icons.new_label_rounded,
    size: 25,
    color: Colors.white,
    ),
    title: const Text(
    'News',
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white),
    ),
    onTap: () {
    // ...
    },
    ),
    ListTile(
    leading: const Icon(
    FontAwesome.cube,
    size: 25,
    color: Colors.white,
    ),
    title: const Text(
    'Topics',
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white),
    ),
    onTap: () {
    // ...
    },
    ),
    ListTile(
    leading: const Icon(
    Icons.help_outline,
    size: 25,
    color: Colors.white,
    ),
    title: const Text(
    'FAQ',
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white),
    ),
    onTap: () {},
    ),
    ListTile(
    leading: const Icon(
    Icons.people_alt_sharp,
    size: 25,
    color: Colors.white,
    ),
    title: const Text(
    'Moderators',
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white),
    ),
    onTap: () {
    Navigator.of(context).pop();
    Get.to(() => ModeratorsPage());
    },
    ),
    ListTile(
    leading: const Icon(
    Icons.people_alt_sharp,
    size: 25,
    color: Colors.white,
    ),
    title: const Text(
    'About Us',
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white),
    ),
    onTap: () {
    Navigator.of(context).pop();
    Get.to(() => AboutMindPlex());
    },
    ),
    SizedBox(
    height: 40,
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
    Text(
    "© 2023 MindPlex. All rights reserved",
    style: TextStyle(color: Colors.white),
    ),
    SizedBox(
    width: 10,
    ),
    InkWell(
    child: Icon(
    Icons.settings,
    size: 32,
    color: Colors.white,
    ),
    onTap: () {
    Navigator.of(context).pop();
    Get.toNamed(AppRoutes.settingsPage);
    },
    ),
    SizedBox(
    width: 15,
    )
    ],
    ),
    SizedBox(
    height: 60,
    )
    ],
    ),
    ),
    ),
    ),
    body:Container(
      height: 2000,
      child: SingleChildScrollView(
          child: Column(
              children: [
              Container(
              height: 110,
              child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              GestureDetector(
              onTap: () => {_globalkey.currentState!.openDrawer()},
              child: Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.only(left: 40),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFF0c2b46),
              image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
              profileController.authenticatedUser.value.image ??
              ""),
              ),
              ),
              ),
              ),
                SizedBox(width: 30),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _searchController,
                        textAlign: TextAlign.center,
                        onFieldSubmitted: (String value){

                        },
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.grey),
                      ),
                        onChanged: (value) {},
                        validator: (value) {},
                      ),
                      Positioned(
                        right: 55,
                        child: Icon(Icons.search,color: Colors.grey,size: 20,),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                InkWell(
                  child: Icon(
                    Icons.settings,
                    size: 38,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.toNamed(AppRoutes.settingsPage);
                  },
                ),
                SizedBox(width: 30),
              ],
              ),
              ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(alignment:Alignment.centerLeft,child: Text("Trends for you",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),)),
                ),
                _container("News Trending", "Crypto", "2.9"),
                _container("Trending in USA", "AI", "1"),
                _container("Development Trending", "Machine learning", "1"),
                _container("Crypto News Trending", "Crypto currency", "4.5"),
                 InkWell(
                   onTap: (){

                   },
                   child: Container(
                     padding: EdgeInsets.all(18),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("Show More",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.blue,fontSize: 18),),
                         InkWell(child: Icon(Icons.arrow_forward_ios,color: Colors.blue,size: 30,),)
                       ],
                     ),
                   ),
                 ),
                Divider(thickness: 2.0,color: Colors.white,indent: 18,endIndent: 18,),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,top: 8),
                  child: Container(alignment:Alignment.centerLeft,child: Text("Articles for you",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 8),
                  child: Container(alignment:Alignment.centerLeft,child: Text("Check out these popular and trending articles for you",style: TextStyle(fontWeight: FontWeight.w200,color: Colors.white,fontSize: 15),)),
                ),
               SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for(int i = 0;i <5;i++)
                          ArticleCard(blogsController: blogsController, index: i)
                      ],
                    ),
                  ),
                SizedBox(height: 80,)
              ]
              ),
        ),
    ),
    );
  }
  Widget _container(String header,String mainContent,String posts){
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(header,style: TextStyle(fontWeight: FontWeight.w200,color: Colors.white,fontSize: 16),),
            SizedBox(height: 10,),
            Text(mainContent,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
            SizedBox(height: 6,),
            Text(posts + "k posts",style: TextStyle(fontWeight: FontWeight.w100,color: Colors.white,fontSize: 15),)
          ],),
            InkWell(
              child: Icon(
                Icons.more_horiz,
                size: 22,
                color: Colors.white,
              ),
              onTap: () {
              },
            ),
        ],),
      ),
    );
  }
}
class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.blogsController,
    required this.index,
  });

  final BlogsController blogsController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white),
        color: blogContainerColor
      ),
      width: 260,
        height: 250,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(blogsController
                                .filteredBlogs[index]
                                .thumbnailImage ??
                                ""))),
                    height: 100,
                    width: 300,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(top: 1, right: 8.0),
                      child: Container(
                          height: 60,
                          width: 35,
                          margin: EdgeInsets.only(left: 10, top: 0),
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin:
                                const EdgeInsets.only(bottom: 10),
                                child: blogsController
                                    .filteredBlogs[index]
                                    .postTypeFormat ==
                                    "text"
                                    ? const Icon(
                                  Icons.description_outlined,
                                  color: Color(0xFF8aa7da),
                                  size: 20,
                                )
                                    : blogsController
                                    .filteredBlogs[index]
                                    .postTypeFormat ==
                                    "video"
                                    ? const Icon(
                                  Icons.videocam,
                                  color: Color.fromARGB(
                                      255, 185, 127, 127),
                                  size: 20,
                                )
                                    : const Icon(
                                  Icons.headphones,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              )
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
            Row(children: [
              SizedBox(width: 10,),
              GestureDetector(
                onTap: () {
                  //  will be modified in detail .

                  Get.toNamed(AppRoutes.profilePage, parameters: {
                    "me": "notme",
                    "username":
                    blogsController.filteredBlogs[index].authorUsername ??
                        ""
                  });
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      blogsController.filteredBlogs[index].authorAvatar ??
                          ""),
                  radius: 15,
                  backgroundColor: Colors.black,
                ),
              ),
              SizedBox(width: 10,),
              Text(
                blogsController
                    .filteredBlogs[index].authorDisplayName ??
                    "",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 20,),
              Text(
                blogsController
                    .filteredBlogs[index].publishedAt ??
                    "",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    blogsController.filteredBlogs[index].postTitle ??
                        ""),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    blogsController.filteredBlogs[index].overview ??
                        ""),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                Text(
                  blogsController.filteredBlogs[index].minToRead ?? "",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 20,),
                  Text(
                    "19.9k views",
                    style: TextStyle(color: Colors.white),
                  ),
              ],),
            )
          ],
        ),
    );
  }
}