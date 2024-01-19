import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        if (viewModel.communityList == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.communityList?.length,
              itemBuilder: (context, index) {
                final diary = viewModel.communityList?[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(diary?.title ?? ''),
                      subtitle: Image(
                        image: NetworkImage(diary?.diaryImage ?? ''),
                      ),
                      onTap: () {
                        Get.to(() => DiaryReadScreen(diary!.diaryId));
                      }
                    )
                  ]
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