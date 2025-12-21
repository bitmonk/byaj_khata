class InterestHelper {
  static double calculateInterest(double principal, int time, double rate) {
    return principal * rate * time;
  }

  static double calculateTotalAmount(double principal, int time, double rate) {
    return calculateInterest(principal, time, rate) + principal;
  }

  static double calculateMonthlyPayment(double principal,int time,double rate,) {
    return calculateTotalAmount(principal, time, rate) / time;
  }
}
