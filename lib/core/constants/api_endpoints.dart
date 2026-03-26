abstract final class ApiEndpoints {
  static const baseUrl = 'http://127.0.0.1:8000/api/v1';

  static const login = '/auth/login';
  static const register = '/auth/register';
  static const profile = '/profile';
  static const doctors = '/doctors';
  static const home = '/home';
  static const appointments = '/appointments';
  static const notifications = '/notifications';
  static const paymentMethods = '/payments/methods';
  static const checkout = '/payments/checkout';
  static const inboxThreads = '/inbox/threads';
}
