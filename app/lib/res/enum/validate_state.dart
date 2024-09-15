enum ValidateEmailState {
  none,
  invalid,
  notCorrect,
}

enum ValidatePasswordState {
  none,
  invalid,
  notCorrect,
  short,
  noEmpty,
  inEmpty,
  passNewCorrect,
  passOldCorrect
}

enum ValidateOTPState {
  none,
  invalid,
  notCorrect,
}

enum ValidatePhoneState {
  none,
  invalid,
  notCorrect,
}

enum ValidateState { none, invalid }

enum CompareTimeState { none, invalid }
