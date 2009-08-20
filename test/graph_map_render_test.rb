require File.dirname(__FILE__) + '/test_helper.rb'

class GraphMapRenderTest < Test::Unit::TestCase
  
  def setup
    @data = { "br" => 100 }
    @template = File.dirname(__FILE__) + '/test_template.svg'
    @map = DataMap::WorldMap.new :template => @template, :data => @data
  end

  def test_make_map_base_raise
    exception = assert_raise RuntimeError do
      GraphMapRender.make_map_base @map, :range_function => 'any'
    end
    assert_equal "Unrecognizable range function 'any'", exception.message
  end

  def test_make_map_base_makes_title
    GraphMapRender.make_map_base @map, :title => 'My Title'
    assert_equal 'My Title', @map.title
  end

  def test_make_svg_map
    GraphMapConfig.maps_dir = '/tmp'
    out = File.basename(Tempfile.new(rand(100)).path)
    GraphMapConfig.output = out
    GraphMapConfig.maps_path = '/maps'
    m = GraphMapRender.make_svg_map @data, :template => @template 
    assert_equal "/maps/#{out}.svg", m
    assert File.exists?("/tmp/#{out}.svg")
  end

  def test_make_svg_map_custom_output
    GraphMapConfig.maps_dir = '/tmp'
    out = File.basename(Tempfile.new(rand(100)).path)
    GraphMapConfig.output = 'out'
    GraphMapConfig.maps_path = '/maps'
    m = GraphMapRender.make_svg_map @data, :template => @template, :output => out
    assert_equal "/maps/#{out}.svg", m
    assert File.exists?("/tmp/#{out}.svg")
  end

  def test_make_bitmap_map_default
    GraphMapConfig.maps_dir = '/tmp'
    out = File.basename(Tempfile.new(rand(100)).path)
    GraphMapConfig.output = out
    GraphMapConfig.maps_path = '/maps'
    m = GraphMapRender.make_bitmap_map @data, :template => @template
    assert_equal "/maps/#{out}.png", m
    assert File.exists?("/tmp/#{out}.png")
    assert_equal "image/png\n", %x[file -bi /tmp/#{out}.png]
  end

  def test_make_bitmap_map_custom_output
    GraphMapConfig.maps_dir = '/tmp'
    out = File.basename(Tempfile.new(rand(100)).path)
    GraphMapConfig.output = 'out'
    GraphMapConfig.maps_path = '/maps'
    m = GraphMapRender.make_bitmap_map @data, :template => @template, :output => out
    assert_equal "/maps/#{out}.png", m
    assert File.exists?("/tmp/#{out}.png")
    assert_equal "image/png\n", %x[file -bi /tmp/#{out}.png]
  end

  def test_make_bitmap_map
    GraphMapConfig.maps_dir = '/tmp'
    out = File.basename(Tempfile.new(rand(100)).path)
    GraphMapConfig.output = out
    GraphMapConfig.maps_path = '/maps'
    m = GraphMapRender.make_bitmap_map @data, :template => @template, :format => "jpg"
    assert_equal "/maps/#{out}.jpg", m
    assert File.exists?("/tmp/#{out}.jpg")
    assert_equal "image/jpeg\n", %x[file -bi /tmp/#{out}.jpg]
  end

end
