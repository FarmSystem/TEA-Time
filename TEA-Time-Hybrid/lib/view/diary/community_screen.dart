import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tea_time/view/base/base_screen.dart';
import 'package:tea_time/view/diary/diary_read_screen.dart';
import 'package:tea_time/viewModel/community/community_view_model.dart';
import 'package:tea_time/widget/base/default_appbar.dart';

class CommunityScreen extends BaseScreen<CommunityViewModel> {
  const CommunityScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        if (viewModel.communityList == null || viewModel.isLoading.isTrue) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.communityList?.length,
              itemBuilder: (context, index) {
                final diary = viewModel.communityList?[index];
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Column(
                              children: [
                                Row(
                                    children: [
                                      ClipOval(
                                          child: Image(
                                            image: NetworkImage(diary?.profileImage ?? ''),
                                            width: 50,
                                            height: 50,
                                          )
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(diary?.nickname ?? '',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                )
                                            ),
                                            Text(DateFormat('yyyy년 MM월 dd일').format(diary!.createdAt) ?? '',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey
                                              )
                                            ),
                                          ]
                                      )
                                    ]
                                ),
                                const SizedBox(height: 10),
                                Text(diary.title ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Image(
                                    image: NetworkImage(diary.diaryImage ?? ''),
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.width * 0.8
                                ),
                              ]
                          ),
                          onTap: () {
                            Get.to(() => DiaryReadScreen(diary.diaryId));
                          },
                        ),
                        const SizedBox(height: 20),
                      ]
                  ),
                );
              }
          );
        }
      })
    );
  }

  @override
  PreferredSize buildAppBar(BuildContext context) {
    return const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppBar(title: '커뮤니티')
    );
  }
}