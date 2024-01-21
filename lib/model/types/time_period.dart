enum TimePeriod implements Comparable<TimePeriod> {
  seven(7),
  thirty(30),
  ;

  final int value;

  const TimePeriod(this.value);

  @override
  compareTo(TimePeriod other) => value.compareTo(other.value);

  @override
  toString() => value.toString();
}
