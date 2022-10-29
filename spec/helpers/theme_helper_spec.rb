require 'rails_helper'

RSpec.describe ThemeHelper do
  subject { helper }

  its(:themes_path) { is_expected.to eq Rails.root.join('app/views/themes') }
  its(:theme_suffix) { is_expected.to eq '' }
  its(:theme_prefix) { is_expected.to eq 'theme-' }
  its(:default_theme) { is_expected.to eq 'default' }
  its(:default_backend_theme) { is_expected.to eq 'default' }
  its(:current_theme) { is_expected.to eq Setting.current_theme }
  its(:current_backend_theme) { is_expected.to eq Setting.current_backend_theme }

  its(:current_theme_path) do
    is_expected.to eq "#{Rails.root}/app/views/themes/theme-#{Setting.current_theme}"
  end

  its(:current_backend_theme_path) do
    is_expected.to eq "#{Rails.root}/app/views/themes/theme-#{Setting.current_backend_theme}"
  end
end
