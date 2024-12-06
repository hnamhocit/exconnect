// class Validators {
//   static String? isRequired(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'This field is required!';
//     }

//     return null;
//   }

//   static String? email(String? value) {
//     final RegExp emailRegex = RegExp(r'/^\S+@\S+\.\S+$/');

//     if (value == null || value.isEmpty) {
//       return 'This field is required!';
//     }

//     if (!emailRegex.hasMatch(value)) {
//       return 'Please enter valid email!';
//     }

//     return null;
//   }

//   static String? password(String? value) {
//     final RegExp passwordRegex = RegExp(
//         r'/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/');

//     if (value == null || value.isEmpty) {
//       return 'This field is required!';
//     }

//     if (!passwordRegex.hasMatch(value)) {
//       return '1 upper, 1 lower, 1 special characters and 1 number!';
//     }

//     return null;
//   }
// }

class Validators {
  static String? isRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required!';
    }
    return null;
  }

  static String? email(String? value) {
    final RegExp emailRegex = RegExp(r'^\S+@\S+\.\S+$');

    if (value == null || value.isEmpty) {
      return 'This field is required!';
    }

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email!';
    }

    return null;
  }

  static String? password(String? value) {
    final RegExp passwordRegex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');

    if (value == null || value.isEmpty) {
      return 'This field is required!';
    }

    if (!passwordRegex.hasMatch(value)) {
      return 'Must include 1 upper, 1 lower, 1 special character, and 1 number!';
    }

    return null;
  }
}
