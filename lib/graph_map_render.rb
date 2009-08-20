# Renders the map as SVG or bitmap based on the map options passed
class GraphMapRender

  # Common actions to SVG map and bitmap map. Called by both of them.
  def self.make_map_base(map, options = {})
    map.identify_countries
    if options[:range_function] == 'log' || options[:range_function].nil?
      base = options[:log_base] || 10
      map.make_ranges_log base
    elsif options[:range_function] == 'linear'
      map.make_ranges_linear
    else
      raise "Unrecognizable range function '#{options[:range_function]}'"
    end
    map.title = options[:title]
    map.make_colors
    map.map_values
    map.make_legend unless options[:legend] == false
  end

  # Calls DataMap::WorldMap.new to render a map with the options[:map] and data passed to plot_svg_map
  def self.make_svg_map(data = {}, options = {})
    m = DataMap::WorldMap.new options.merge({ :data => data, :js => [ GraphMapConfig.js + '/graph_map.js' ] }) 
    m.add_js unless options[:use_js] == false
    make_map_base(m, options)
    output = options[:output] || GraphMapConfig.output
    m.save_file File.join(GraphMapConfig.maps_dir, output + '.svg')
    GraphMapConfig.maps_path + '/' + output + '.svg'
  end

  # Calls DataMap::WorldMap.new to render a map with the options[:map] and data passed to plot_bitmap_map
  def self.make_bitmap_map(data = {}, options = {})
    format = options[:format] || GraphMapConfig.default_output_format
    m = DataMap::WorldMap.new options.merge({ :data => data })
    make_map_base(m, options)
    output = options[:output] || GraphMapConfig.output
    m.save_file File.join(GraphMapConfig.maps_dir, output + '.' + format), :quality => options[:quality], :size => options[:size]
    GraphMapConfig.maps_path + '/' + output + '.' + format
  end

end
