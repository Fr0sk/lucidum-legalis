class Version {
  final int major;
  final int minor;
  final int incremental;

  const Version(this.major, this.minor, this.incremental);

  factory Version.parse(String version) {
    final splitted = version.split('.');
    if (splitted.length != 3) {
      return const Version(0, 0, 0);
    }
    return Version(
      int.parse(splitted[0]),
      int.parse(splitted[1]),
      int.parse(splitted[2]),
    );
  }

  operator >(Version other) =>
      major > other.major ||
      (major == other.major && minor > other.minor) ||
      (major == other.major &&
          minor == other.minor &&
          incremental > other.incremental);

  @override
  bool operator ==(other) =>
      other is Version &&
      major == other.major &&
      minor == other.minor &&
      incremental == other.incremental;

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() => '$major.$minor.$incremental';
}
