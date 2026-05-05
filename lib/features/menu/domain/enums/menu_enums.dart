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

enum SpiceLevel { none, medium, hot }

enum PortionSize {
  small,
  regular,
  large,
} //snack, light, regular, filling, feast }

enum MealStyle { classic, adventurous }

enum PrepTime { quick, normal, long }

enum HealthGoal { highProtein, lowSugar, balanced, tasty }
