
String? validateNickname(String? value) {
  if (value == null || value.isEmpty) {
    return '닉네임을 입력해주세요.';
  } else if (value.contains(' ')) {
    return '닉네임에 공백을 포함할 수 없습니다.';
  } else {
    return null;
  }
}

String? validateEmail(String? email) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";

  RegExp regex = RegExp(pattern);

  if (email == null || email.isEmpty || !regex.hasMatch(email)) {
    return '유효한 이메일을 입력해주세요.';
  } else {
    return null;
  }
}

String? validatePassword(String? value) {
  String pattern =
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
  RegExp regex = RegExp(pattern);

  if (value == null || value.isEmpty) {
    return '비밀번호를 입력해주세요.';
  } else if (value.length < 8) {
    return '비밀번호는 8글자 이상입니다.';
  } else if (!regex.hasMatch(value)) {
    return '비밀번호는 최소 1개의 대문자, 소문자, 숫자, 특수문자를 포함해야 합니다.';
  } else {
    return null;
  }
}