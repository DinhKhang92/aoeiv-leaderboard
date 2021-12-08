enum Spacing { xxs, xs, s, m, l, xl }

extension SpacingExtension on Spacing {
  double get spacing {
    switch (this) {
      case Spacing.xxs:
        return 5.0;
      case Spacing.xs:
        return 7.0;
      case Spacing.s:
        return 8.0;
      case Spacing.m:
        return 15.0;
      case Spacing.l:
        return 20.0;
      case Spacing.xl:
        return 30.0;
    }
  }
}
