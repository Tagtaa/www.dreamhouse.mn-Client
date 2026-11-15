abstract final class ApiPaths {
  // Base API URL

  // Health & Welcome
  static const String health = '/health';
  // Website/app settings from the dashboard (deposit bank account, app links …)
  static const String publicSettings = '/public-settings';
  static const String welcome = '/';

  // Auth Routes
  static const String sendVerificationCode = '/auth/send-code';
  static const String verifyCode = '/auth/verify-code';
  static const String signup = '/auth/signup';
  static const String login = '/auth/login';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String getCurrentUser = '/auth/me';
  static const String subscriptions = '/subscriptions';

  // User Routes
  static const String getUserProfile = '/user/profile';
  static const String updateUserProfile = '/user/profile';
  static const String getUserCalculations = '/user/calculations';
  static const String getPurchasedIdeas = '/user/purchased-ideas';
  static const String getUserWallet = '/user/wallet';
  static const String getUserMembership = '/user/membership';
  static const String deleteUserAccount = '/user/account';
  static const String updateUserAccount = '/user/account-info';
  static const String uploadUserAvatar = '/user/upload-avatar';

  // Messaging
  static const String messagesSend = '/messages/send';
  static const String messagesSendImage = '/messages/send-image';
  static const String messagesUserMessages = '/messages/user-messages';

  // Anonymous Messaging
  static const String anonymousMessagesSend = '/messages/anonymous/send';
  static const String anonymousMessagesSendImage = '/messages/anonymous/send-image';
  static const String anonymousMessagesUserMessages = '/messages/anonymous/messages';

  // Calculation Routes
  static const String calculations = '/calculations';
  static const String calculationsTypes = '/calculations/types';
  static const String calculationsChooseTypes = '/calculations/:type/choose-types';
  static const String calculationsWallThicknessTypes = '/calculations/wall/thickness';
  static const String calculationsRoofShapesTypes = '/calculations/roof/choose-shapes';
  static const String calculationsChooseMaterials = '/calculations/:type/choose-materials';
  static const String calculationsIngredients = '/calculations/:type/ingredients';
  static const String calculateWall = '/calculations/wall';
  static const String calculateFundament = '/calculations/fundament';
  static const String calculateRoof = '/calculations/roof';
  static const String calculateInnerWall = '/calculations/inner-wall';
  static const String calculateUnderfloor = '/calculations/underfloor';
  static const String calculateFloorTiles = '/calculations/floor-tiles';
  static const String calculateWallDecoration = '/calculations/wall-decoration';
  static const String getCalculationHistory = '/calculations/history';
  static const String getCalculationById = '/calculations/:id';
  static const String updateCalculation = '/calculations/:id';
  static const String deleteCalculation = '/calculations/:id';
  static const String toggleCalculationBookmark = '/calculations/:id/bookmark';
  static const String shareCalculation = '/calculations/:id/share';
  static const String getCalculationStatistics = '/calculations/statistics/summary';

  // Idea Routes
  static const String getIdeas = '/ideas';
  static const String getIdeaCategories = '/ideas/categories';
  static const String getIdeaSizeRanges = '/ideas/size-ranges';
  static const String getFeaturedIdeas = '/ideas/featured';
  static const String getPopularIdeas = '/ideas/popular';
  static const String searchIdeas = '/ideas/search';
  static const String getIdeaById = '/ideas/:id';
  static const String incrementIdeaView = '/ideas/:id/view';
  static const String purchaseIdea = '/ideas/:id/purchase';
  static const String toggleIdeaLike = '/ideas/:id/like';
  static const String createIdea = '/ideas';
  static const String updateIdea = '/ideas/:id';
  static const String deleteIdea = '/ideas/:id';
  static const String toggleIdeaFeatured = '/ideas/:id/featured';
  static const String userPurchasedIdea = '/user/purchased-ideas';

  // Material Routes
  static const String getMaterials = '/materials';
  static const String getMaterialCategories = '/materials/parent-categories';
  static const String updateMaterialLikes = '/materials/:id/toggle-like';
  static const String getPopularMaterials = '/materials/popular';
  static const String searchMaterials = '/materials/search';
  static const String getMaterialById = '/materials/:id';
  static const String incrementMaterialView = '/materials/:id/view';
  static const String createMaterial = '/materials';
  static const String updateMaterial = '/materials/:id';
  static const String deleteMaterial = '/materials/:id';

  // Payment Routes
  static const String chargeWallet = '/payments/charge-wallet';
  static const String purchaseMembership = '/payments/purchase-membership';
  static const String getPaymentTransactions = '/payments/transactions';
  static const String getMembershipPlans = '/payments/membership-plans';
  static const String handlePaymentWebhook = '/payments/webhook';
  static const String getTransactionById = '/payments/transaction/:id';

  // Admin Routes
  static const String getDashboardAnalytics = '/admin/dashboard';
  static const String getUsers = '/admin/users';
  static const String getUserById = '/admin/users/:id';
  static const String updateUserStatus = '/admin/users/:id/status';
  static const String getAllMaterialsAdmin = '/admin/materials';
  static const String getAllIdeasAdmin = '/admin/ideas';
  static const String getUserAnalytics = '/admin/analytics/users';
  static const String getCalculationAnalytics = '/admin/analytics/calculations';
  static const String getRevenueAnalytics = '/admin/analytics/revenue';
  static const String getSystemStats = '/admin/system/stats';
  static const String cleanupSystem = '/admin/system/cleanup';

  // SMS Parser Routes
  static const String verifyOtp = '/sms-parser/verify-otp';
  static const String handleBankTransaction = '/sms-parser/bank-transaction';
  static const String getBankTransactions = '/sms-parser/transactions';
  static const String retryBankTransaction = '/sms-parser/transactions/:id/retry';
  static const String getSmsParserStats = '/sms-parser/responses/stats';
  static const String getSmsParserErrors = '/sms-parser/responses/errors';
  static const String getSmsParserResponses = '/sms-parser/responses';
  static const String cleanupSmsParserResponses = '/sms-parser/responses/cleanup';

  // Upload Routes
  static const String uploadProfileImage = '/upload/profile-image';
  static const String uploadMaterialImage = '/upload/material-image';
  static const String uploadIdeaImage = '/upload/idea-image';
  static const String deleteFile = '/upload/:path';
  static const String getSignedUrl = '/upload/signed-url';

  // Documentation
  static const String apiDocs = '/api-docs';
}
