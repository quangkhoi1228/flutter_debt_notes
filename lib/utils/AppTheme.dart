enum TemplateTheme { light, dark }

class AppTheme {
  static TemplateTheme defaultTheme = TemplateTheme.dark;
  static TemplateTheme currentTheme = TemplateTheme.light;

  static void changeTheme(TemplateTheme templateTheme) {
    AppTheme.currentTheme =
        (templateTheme == null) ? AppTheme.defaultTheme : templateTheme;
  }
}
