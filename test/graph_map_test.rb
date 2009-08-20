require 'test_helper'
require 'rails_generator'
require 'rails_generator/scripts/generate'

class GraphMapTest < ActiveSupport::TestCase

  def setup
    @helper = ActionView::Base.new
  end

  def test_include_helpers
    assert_not_nil GraphMapViewHelper
    assert @helper.methods.include? 'plot_svg_map'
    assert @helper.methods.include? 'plot_bitmap_map'
    assert @helper.methods.include? 'plot_table'
  end

end
