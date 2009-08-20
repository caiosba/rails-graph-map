require 'test_helper'

class GraphMapConfigTest < ActiveSupport::TestCase

  def test_config_is_a_hash
    assert_kind_of Hash, GraphMapConfig.config
  end

  def test_should_have_root_defined
    assert_not_nil GraphMapConfig.root

    GraphMapConfig.root = nil
    assert_not_nil GraphMapConfig.root

    GraphMapConfig.root = ''
    assert_not_nil GraphMapConfig.root
  end

  def test_should_have_rails_root_as_default_root
    GraphMapConfig.root = nil
    assert_equal RAILS_ROOT, GraphMapConfig.root
  end

  def test_should_define_a_root
    GraphMapConfig.root= '/some'
    assert_equal '/some', GraphMapConfig.root
  end

  def test_should_have_maps_dir_defined
    assert_not_nil GraphMapConfig.maps_dir

    GraphMapConfig.maps_dir = nil
    assert_not_nil GraphMapConfig.maps_dir

    GraphMapConfig.maps_dir = ''
    assert_not_nil GraphMapConfig.maps_dir
  end

  def test_should_have_public_maps_as_default_maps_dir
    GraphMapConfig.maps_dir = nil
    assert_equal "#{GraphMapConfig.root}/public/graph_maps", GraphMapConfig.maps_dir
  end

  def test_should_define_maps_dir
    GraphMapConfig.maps_dir= '/some'
    assert_equal '/some', GraphMapConfig.maps_dir
  end

  def test_should_have_default_maps_path
    GraphMapConfig.maps_path = nil
    assert_equal "/graph_maps", GraphMapConfig.maps_path
  end

  def test_should_define_maps_path
    GraphMapConfig.maps_path= '/some'
    assert_equal '/some', GraphMapConfig.maps_path
  end

  def test_should_have_default_js
    GraphMapConfig.js = nil
    assert_equal "/javascripts", GraphMapConfig.js
  end

  def test_should_define_js
    GraphMapConfig.js= '/some'
    assert_equal '/some', GraphMapConfig.js
  end

  def test_should_have_default_output
    GraphMapConfig.default_output_format = nil
    assert_equal "png", GraphMapConfig.default_output_format
  end

  def test_should_define_output
    GraphMapConfig.default_output_format= 'jpg'
    assert_equal 'jpg', GraphMapConfig.default_output_format
  end

end
