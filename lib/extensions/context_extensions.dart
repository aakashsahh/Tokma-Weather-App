import 'package:flutter/material.dart';

/// Extension methods on BuildContext for cleaner code
extension BuildContextExtensions on BuildContext {
  // ========================
  // Theme Access
  // ========================

  /// Get the current theme
  ThemeData get theme => Theme.of(this);

  /// Get the text theme
  TextTheme get textTheme => theme.textTheme;

  /// Get the color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get the primary color
  Color get primaryColor => colorScheme.primary;

  /// Get the secondary color
  Color get secondaryColor => colorScheme.secondary;

  /// Get the error color
  Color get errorColor => colorScheme.error;

  /// Get the surface color
  Color get surfaceColor => colorScheme.surface;

  /// Get the background color
  Color get backgroundColor => colorScheme.surface;

  // ========================
  // MediaQuery Access
  // ========================

  /// Get the screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Get the screen width
  double get screenWidth => screenSize.width;

  /// Get the screen height
  double get screenHeight => screenSize.height;

  /// Get the aspect ratio
  double get aspectRatio => screenWidth / screenHeight;

  /// Get the padding (includes system UI)
  EdgeInsets get padding => MediaQuery.of(this).padding;

  /// Get the view insets (e.g., keyboard)
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  /// Get the view padding
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => viewInsets.bottom > 0;

  /// Get the device pixel ratio
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// Get the text scale factor
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;

  // ========================
  // Responsive Helpers
  // ========================

  /// Check if device is mobile (< 600px)
  bool get isMobile => screenWidth < 600;

  /// Check if device is tablet (600px - 900px)
  bool get isTablet => screenWidth >= 600 && screenWidth < 900;

  /// Check if device is desktop (>= 900px)
  bool get isDesktop => screenWidth >= 900;

  /// Check if device is in landscape mode
  bool get isLandscape => screenWidth > screenHeight;

  /// Check if device is in portrait mode
  bool get isPortrait => screenHeight >= screenWidth;

  // ========================
  // Navigation Helpers
  // ========================

  /// Push a new page
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));
  }

  /// Push and remove all previous routes
  Future<T?> pushAndRemoveUntil<T>(Widget page) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  /// Pop the current page
  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// Check if can pop
  bool get canPop => Navigator.of(this).canPop();

  /// Pop until first route
  void popUntilFirst() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }

  // ========================
  // SnackBar Helpers
  // ========================

  /// Show a snackbar
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  /// Show an error snackbar
  void showErrorSnackBar(String message) {
    showSnackBar(message, backgroundColor: colorScheme.error);
  }

  /// Show a success snackbar
  void showSuccessSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.green);
  }

  /// Show a warning snackbar
  void showWarningSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.orange);
  }

  /// Hide current snackbar
  void hideSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }

  // ========================
  // Dialog Helpers
  // ========================

  /// Show an alert dialog
  Future<T?> showAlertDialog<T>({
    required String title,
    required String content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<T>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: () {
                context.pop();
                onCancel?.call();
              },
              child: Text(cancelText),
            ),
          if (confirmText != null)
            TextButton(
              onPressed: () {
                context.pop(true);
                onConfirm?.call();
              },
              child: Text(confirmText),
            ),
        ],
      ),
    );
  }

  /// Show a confirmation dialog
  Future<bool> showConfirmDialog({
    required String title,
    required String content,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) async {
    final result = await showAlertDialog<bool>(
      title: title,
      content: content,
      confirmText: confirmText,
      cancelText: cancelText,
    );
    return result ?? false;
  }

  /// Show a loading dialog
  void showLoadingDialog({String message = 'Loading...'}) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(child: Text(message)),
            ],
          ),
        ),
      ),
    );
  }

  /// Hide loading dialog
  void hideLoadingDialog() {
    if (canPop) pop();
  }

  // ========================
  // Focus Helpers
  // ========================

  /// Unfocus (hide keyboard)
  void unfocus() {
    FocusScope.of(this).unfocus();
  }

  /// Request focus for a node
  void requestFocus(FocusNode node) {
    FocusScope.of(this).requestFocus(node);
  }

  /// Get the current focus node
  FocusNode? get currentFocus => FocusScope.of(this).focusedChild;

  /// Check if any field has focus
  bool get hasFocus => FocusScope.of(this).hasFocus;

  // ========================
  // Bottom Sheet Helpers
  // ========================

  /// Show a modal bottom sheet
  Future<T?> showBottomSheet<T>(Widget child) {
    return showModalBottomSheet<T>(
      context: this,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => child,
    );
  }
}
