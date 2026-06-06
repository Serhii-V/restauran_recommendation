enum MenuCategory {
  all('All'),
  snacks('Snacks'),
  mainCourse('Main Course'),
  bowls('Bowls'),
  drinks('Drinks'),
  desserts('Desserts');

  final String label;
  const MenuCategory(this.label);
}

enum SpiceLevel {
  none('No spice'),
  medium('Medium'),
  hot('Hot');

  final String label;
  const SpiceLevel(this.label);
}

enum PortionSize {
  small('Small'),
  regular('Regular'),
  large('Large');

  final String label;
  const PortionSize(this.label);
}

enum PrepTime {
  quick('Quick'),
  normal('Normal'),
  long('Slow');

  final String label;
  const PrepTime(this.label);
}

enum HealthGoal {
  highProtein('High Protein'),
  lowSugar('Low Sugar'),
  balanced('Balanced'),
  tasty('Tasty');

  final String label;
  const HealthGoal(this.label);
}

enum KidsFriendly {
  yes('Yes'),
  maybe('Maybe'),
  no('No');

  final String label;
  const KidsFriendly(this.label);
}
