/// 如果 value <= 0, 抛出异常
checkIsPositive(num value, [String name, String message]) {
  if (value <= 0) throw ArgumentError.value(value, name, message);
}
