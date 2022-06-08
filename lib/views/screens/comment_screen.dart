import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shorts/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../models/comment.dart';
import '../../utilities/const.dart';

class CommentScreen extends StatelessWidget {
  final String postId;
  String? profilePic;

  final TextEditingController controller = TextEditingController();
  final CommentController commentController = Get.put(CommentController());

  CommentScreen({
    required this.postId,
    this.profilePic,
  });

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(postId);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(top: 50),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: commentController.commentList.length,
                    itemBuilder: (context, index) {
                      final Comment comment =
                          commentController.commentList[index];

                      timeago.setLocaleMessages(
                          'en_short', timeago.EnShortMessages());
                      return ListTile(
                        leading: Container(
                          height: 40,
                          width: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: (comment.profilePhoto != null)
                                ? Image.network(
                                    comment.profilePhoto!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/defaultProfilePic.jpg'),
                          ),
                        ),
                        title: Row(
                          children: [
                            Text(
                              comment.username,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(comment.comment,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                )),
                          ],
                        ),
                        subtitle: Row(children: [
                          Text(
                              timeago.format(comment.datePublished.toDate(),
                                  locale: 'en_short'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                          SizedBox(width: 30),
                          Row(
                            children: [
                              Text('${comment.likes.length}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  )),
                              SizedBox(width: 2),
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 16,
                              )
                            ],
                          ),
                        ]),
                        trailing: InkWell(
                          onTap: () {
                            commentController.likeComment(comment.id);
                          },
                          child: comment.likes
                                  .contains(authController.getUser!.uid)
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                ),
                        ),
                      );
                    },
                  );
                }),
              ),
              Divider(
                color: Colors.white,
                thickness: 1,
              ),
              ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: (profilePic != null)
                        ? Image.network(
                            profilePic!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset('assets/images/defaultProfilePic.jpg'),
                  ),
                ),
                title: TextFormField(
                  controller: controller,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.red,
                  scrollPhysics: ClampingScrollPhysics(),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Comment',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.send_rounded,
                    color: Colors.blue[500],
                  ),
                  onPressed: () {
                    if (controller.text.isNotEmpty)
                      commentController.postComment(controller.text);
                    controller.clear();
                  },
                ),
              )
            ])),
      ),
    );
  }
}
