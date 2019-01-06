require 'test_helper'

class PageTest < ActiveSupport::TestCase
  test 'key is required' do
    @page = Page.new
    @page.valid?
    assert @page.errors[:key].any?
  end

  test 'key must be unique' do
    @page = Page.new
    @page.key = pages(:home).key
    @page.valid?
    assert @page.errors[:key].any?
  end
end
