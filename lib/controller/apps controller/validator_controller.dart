class ValidatorController {
  String? authValidator(String valueName, String? value) {
    if (value == null || value.trim().isEmpty && value.trim().length <= 2) {
      return '$valueName must be at least 6 character';
    }
    return null;
  }
}
