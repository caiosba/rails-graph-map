require File.dirname(__FILE__) + '/test_helper.rb'
include GraphMapViewHelper

class ViewHelpersTest < Test::Unit::TestCase
  
  def setup
    @data = { "br" => 100 }
    @template = File.dirname(__FILE__) + '/test_template.svg'
    @helper = ActionView::Base.new
  end

  def test_plot_svg_map_raise
    exception = assert_raise RuntimeError do
      @helper.plot_svg_map @data, :map => { :template => @template, :tag => 'div' }
    end
    assert_equal "It's not possible to insert SVG inside a 'div' tag!", exception.message
  end

  def test_plot_svg_map_default
    result = @helper.plot_svg_map @data, :map => { :template => @template }
    assert_match /^<iframe/, result
  end

  def test_plot_svg_map_embed
    result = @helper.plot_svg_map @data, :map => { :template => @template, :tag => 'embed' }, :html => { :class => 'test' }
    src = GraphMapConfig.maps_path + '/' + GraphMapConfig.output + '.svg'
    assert_equal "<embed class=\"test\" pluginspage=\"http://www.adobe.com/svg/viewer/install/\" src=\"#{src}\" type=\"image/svg+xml\"></embed>", result
  end

  def test_plot_svg_map_iframe
    result = @helper.plot_svg_map @data, :map => { :template => @template, :tag => 'iframe' }, :html => { :width => '100', :height => '50' }
    src = GraphMapConfig.maps_path + '/' + GraphMapConfig.output + '.svg'
    assert_equal "<iframe height=\"50\" src=\"#{src}\" width=\"100\"></iframe>", result
  end

  def test_plot_svg_map_object
    result = @helper.plot_svg_map @data, :map => { :template => @template, :tag => 'object' }, :html => { :id => 'test' }
    src = GraphMapConfig.maps_path + '/' + GraphMapConfig.output + '.svg'
    assert_equal "<object codebase=\"http://www.adobe.com/svg/viewer/install/\" data=\"#{src}\" id=\"test\" type=\"image/svg+xml\"></object>", result
  end

  def test_plot_bitmap_map_default
    result = @helper.plot_bitmap_map @data, :map => { :template => @template }, :html => { :id => 'test' }
    src = GraphMapConfig.maps_path + '/' + GraphMapConfig.output + '.' + GraphMapConfig.default_output_format
    assert_equal "<img id=\"test\" src=\"#{src}\"></img>", result
  end

  def test_plot_bitmap_map
    result = @helper.plot_bitmap_map @data, :map => { :template => @template, :format => 'gif' }, :html => { :id => 'test' }
    src = GraphMapConfig.maps_path + '/' + GraphMapConfig.output + '.gif'
    assert_equal "<img id=\"test\" src=\"#{src}\"></img>", result
  end

  def test_plot_table
    result = @helper.plot_table( { "br" => 100, "us" => 50 }, { :flag => 'Symbol' }, { :width => '100%' } )
    assert_equal '<script src="/javascripts/sorttable.js" type="text/javascript"></script><table class="sortable" width="100%"><thead><tr><th class="sorttable_nosort">Symbol</th><th>Country</th><th>Value</th></tr></thead><tbody><tr><td><img alt="br" src="/flags/br.png"></img></td><td>Brazil</td><td>100</td></tr><tr><td><img alt="us" src="/flags/us.png"></img></td><td>United States</td><td>50</td></tr></tbody><tfoot><tr class="sortbottom"><td></td><td><b>Total</b></td><td><b>150</b></td></tr></tfoot></table>', result
  end

  def test_link_to_map_svg
    result = @helper.link_to_map 'Some link text', @data, :html => { :class => 'some' }, :map => { :format => 'svg', :output => 'file' }
    assert_equal '<a class="some" href="' + GraphMapConfig.maps_path + '/file.svg">Some link text</a>', result
  end

  def test_link_to_map_bitmap
    result = @helper.link_to_map 'Bitmap', @data, :map => { :format => 'gif', :output => 'file' }
    assert_equal '<a href="' + GraphMapConfig.maps_path + '/file.gif">Bitmap</a>', result
  end

end
