module ThemeHelper
  def themes_path
    THEMES_PATH
  end

  def theme_suffix
    THEME_SUFFIX
  end

  def theme_prefix
    THEME_PREFIX
  end

  def default_theme
    DEFAULT_THEME
  end

  def default_backend_theme
    DEFAULT_BACKEND_THEME
  end

  def current_theme
    Setting.current_theme || default_theme
  end

  def current_backend_theme
    Setting.current_backend_theme || default_backend_theme
  end

  def current_theme_path
    "#{themes_path}/#{theme_prefix}#{current_theme}#{theme_suffix}"
  end

  def current_backend_theme_path
    "#{themes_path}/#{theme_prefix}#{current_backend_theme}#{theme_suffix}"
  end

  def themes
    Dir.glob("#{themes_path}/#{theme_prefix}*#{theme_suffix}").map do |entry|
      File.basename(entry).gsub(/#{[theme_prefix, theme_suffix].join('|')}/, '')
    end
  end
end
