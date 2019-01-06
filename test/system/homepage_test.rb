require 'application_system_test_case'

class HomepageTest < ApplicationSystemTestCase
  test 'homepage can recover if no page exists' do
    pages(:home).destroy
    visit root_path
    assert_selector 'article.page-home', text: ''
  end

  test 'homepage has page content' do
    visit root_path
    assert_selector 'article.page-home', text: pages(:home).content
  end
end
