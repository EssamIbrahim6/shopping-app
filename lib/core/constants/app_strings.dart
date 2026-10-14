abstract final class AppStrings {
  // =========================
  // App
  // =========================
  static const String appTitle = 'Shopping app';
  static const String appFontFamily = 'Inter';

  // =========================
  // Common
  // =========================
  static const String successTitle = 'Success';
  static const String errorTitle = 'Error';
  static const String ok = 'OK';
  static const String retry = 'Retry';
  static const String next = 'Next';
  static const String skip = 'Skip';
  static const String getStarted = 'Get Started';

  // =========================
  // Authentication
  // =========================
  static const String login = 'Login';
  static const String signUp = 'Sign Up';

  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String dontHaveAccount = "Don't have an account? ";

  static const String successRegisterToastMessage = 'Register successfully';
  static const String successRegisterMessage =
      'Your account has been created successfully.';
  static const String loginSuccessMessage = 'Login successfully';

  // =========================
  // Form Labels
  // =========================
  static const String userName = 'User Name';
  static const String email = 'Email';
  static const String phoneNumber = 'Phone Number';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';

  // =========================
  // Form Hints
  // =========================
  static const String enterUserName = 'Enter your user name';
  static const String enterEmail = 'Enter your email';
  static const String enterPhoneNumber = 'Enter your phone number';
  static const String enterPassword = 'Enter your password';
  static const String enterConfirmPassword = 'Enter your confirm password';

  // =========================
  // Home
  // =========================
  static const String homeGreeting = "Hi !\nLet's Start Your Day";
  static const String searchProductsHint = 'Search for your products';
  static const String startTypingToSearchProducts =
      'Start typing to search for products.';

  // =========================
  // Products
  // =========================
  static const String reviews = 'reviews';
  static const String addToCart = 'Add to Cart';
  static const String addedToCart = 'Added to cart successfully';

  static const String noProductsFound = 'No products found';
  static const String noProductsFoundDesc =
      'No products available in this category at the moment.';
  static const String noProductsAvailable = 'No products available';
  static const String noMoreProducts = 'No more products';
  static const String noMoreData = 'No more data';

  // =========================
  // Account
  // =========================
  static const String accountTitle = 'My Account';
  static const String accountName = 'Name';
  static const String accountEmail = 'Email';
  static const String accountPhone = 'Phone';
  static const String accountAddress = 'Address';
  static const String accountSubmit = 'Submit';

  static const String accountSuccessMessage = 'Account updated successfully';
  static const String accountErrorMessage = 'Failed to update account';
  static const String accountTryAgain = 'Please try again later';

  // =========================
  // Cart
  // =========================
  static const String cartTitle = 'My Cart';
  static const String cartEmptyState = 'Your cart is empty.';
  static const String cartShippingFee = 'Shipping fee';
  static const String cartSubTotal = 'Sub total';
  static const String cartTotal = 'Total';
  static const String cartCheckout = 'Checkout';
  static const String cartCheckoutMessage = 'Checkout feature coming soon!';
  static const String cartCheckoutSuccessTitle = 'Success !';
  static const String cartCheckoutSuccessMessage =
      'Your payment was successful.\n'
      'A receipt for this purchase has\n'
      'been sent to your email.';

  // =========================
  // Error / Empty States
  // =========================
  static const String errorOccurred = 'An unexpected error occurred';
  static const String unknownError =
      'An unknown error occurred. Please try again later.';

  // =========================
  // 404
  // =========================
  static const String lostInSpaceTitle = 'Lost in Space!';
  static const String lostInSpaceDesc =
      'The page you are looking for seems to be missing. '
      'Please go back or visit the homepage.';
  static const String backToHome = 'Back to home';

  // =========================
  // Maintenance
  // =========================
  static const String underMaintenanceTitle = 'Under Maintenance!';
  static const String underMaintenanceDesc =
      'We are currently performing scheduled maintenance. '
      'Please check back later. Thank you for your patience.';
  // =========================
  // Validation
  // =========================
  static const String emailCannotBeEmpty = 'Email cannot be empty';
  static const String invalidEmail = 'Enter a valid email address';

  static const String passwordCannotBeEmpty = 'Password cannot be empty';
  static const String invalidPassword = 'Enter a valid password';

  static const String confirmPasswordNotMatch =
      'Confirm password must match the password';

  static const String nameCannotBeEmpty = 'Name cannot be empty';

  static const String phoneCannotBeEmpty = 'Phone number cannot be empty';
  static const String invalidPhoneNumber = 'Enter a valid phone number';

  static const String codeCannotBeEmpty = 'Code cannot be empty';
  static const String invalidCode = 'Code should be at least 6 digits';
}
