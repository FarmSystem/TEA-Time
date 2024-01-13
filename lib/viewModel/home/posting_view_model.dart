import 'package:get/get.dart';

class PostingViewModel extends GetxController {
  RxString title = "".obs;
  RxString content = "".obs;
  RxString imageUrl = "".obs;

  void setTitle(String newTitle) {
    title.value = newTitle;
  }

  void setContent(String newContent) {
    content.value = newContent;
  }

  void setImageUrl(String newImageUrl) {
    imageUrl.value = newImageUrl;
  }

  String getTitle() {
    return title.value;
  }

  String getContent() {
    return content.value;
  }

  String getImageUrl() {
    return imageUrl.value;
  }

  void clear() {
    title.value = "";
    content.value = "";
    imageUrl.value = "";
  }
}