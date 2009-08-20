# Basic configuration of the plugin
class GraphMapConfig

  # Gets plugin configuration
  def self.config
    @graph_map_config ||= {}
  end

  # Defines the root of your application
  def self.root=(params)
    config[:root] = params
  end 

  # Gets the root of your application. Default: RAILS_ROOT
  def self.root
    config[:root] || RAILS_ROOT
  end

  # Gets the default output filename. Default: 'graph_map'
  def self.output
    config[:output] || 'graph_map'
  end

  # Sets the default output filename
  def self.output=(params)
    config[:output] = params
  end

  # Gets where the generated maps will be saved. Default: /public/graph_maps
  def self.maps_dir
    config[:maps_dir] || File.join(root, 'public', 'graph_maps')
  end

  # Sets where the generated maps will be saved
  def self.maps_dir=(params)
    config[:maps_dir] = params
  end

  # Where to look for maps. Default: /graph_maps
  def self.maps_path
    config[:maps_path] || '/graph_maps'
  end

  # Sets where to look for maps
  def self.maps_path=(params)
    config[:maps_path] = params
  end

  # Gets where to look for javascript. Default: /javascripts
  def self.js
    config[:js] || '/javascripts'
  end

  # Sets where to look for javascript
  def self.js=(params)
    config[:js] = params
  end

  # Gets default map output format. Default: png
  def self.default_output_format
    config[:default_output_format] || 'png'
  end

  # Sets default map output format
  def self.default_output_format=(params)
    config[:default_output_format] = params
  end

end
