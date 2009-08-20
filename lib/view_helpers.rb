require 'data_map/data_map'
# View helpers available to make maps
module GraphMapViewHelper

  # Plots a map in SVG format. Returns an HTML tag with an SVG map inside it.
	# data: Hash whose pairs are in format '<country code> => <value>'. 
	# Example: { "us" => 125, "es" => 254 }
	# Default: {}
  #
	# options: Can be HTML options or map options.
	# 	
	# 	html: Options for the tag that will be rendered. Any HTML attribute can be passed.
	# 	Example: { :style => 'border: 0', :id => 'my_map', :class => 'some class' }
	# 	Default: {}
	# 	Possible values: Any HTML attribute
  #
	# 	map: Options for the map. Some of them are the same as the ones accepted by the DataMap lib.
	# 	Example: { :tag => 'embed', :title => 'Title of my map' }
	# 	Default: {}
	# 	Possible values:
	# 		tag: Which tag will be rendered to show the SVG map. If some strange value is passed, an exception will be raised.
	# 				 Possible values: 'embed', 'iframe' and 'object'
	# 				 Default: 'iframe'
  #
	# 		use_js: If the map must be dynamic or not. Dynamic means that when the mouse is over a country, this country is highlighted
	# 						and a tooltip is shown, with the country name, flag and value.
	# 						Possible values: true or false
	# 						Default: true
  #
	# 		range_function: What function will be used to make the values ranges. An exception will be raised if the function name
	# 										is not recognized.
	# 										Possible values: 'log' or 'linear'
	# 										Default: 'log'
  #
	# 		log_base: What is the base of the log function, if the chosen range function is log.
	# 							Possible values: Any integer
	# 							Default: 10
  #
	#  		title: Title of the map.
	# 					 Possible values: Any string
	# 					 Default: No title
  #
	# 		legend: If the legend must be shown or not.
	# 						Possible values: true or false
	# 						Default: true
  #
	# 		palette: What color palette will be used.
	# 						 Possible values: The path for a color palette file. This file must be a plain text file with each line being 
	# 						 a color in RGB format. See the default one as an example.
	# 						 Default: WorldMap.default_palette (data_map/palettes/tango.color)
  #
	# 		lang: In what language the country names will be shown.
	# 					Possible values: A string representing a language. The directory data_map/lang/<language> must be present, with the proper
	# 					files inside it. See data_map/lang/en for example.
	# 					Default: WorldMap.default_language (en)
  #
	# 		template: The SVG template that will be used.
	# 							Possible values: The path for an SVG file.
	# 							Default: WorldMap.default_template (default_world_map.svg)
  #
	# 		output: The output filename (without the .svg extension).
	# 						Possible values: Any string
	# 						Default: GraphMapConfig.output
  def plot_svg_map(data = {}, options = { :html => {}, :map => {} })
    map_options = options[:map] || {}
    html_options = options[:html] || {}
    map = GraphMapRender.make_svg_map data, map_options
    returning "" do |result|
      tag = map_options[:tag] || 'iframe'
      case tag
        when 'embed'
          result << content_tag(:embed, nil, { :src => map, 
                                               :type => 'image/svg+xml', 
                                               :pluginspage => 'http://www.adobe.com/svg/viewer/install/'}.merge(html_options))
        when 'iframe'
          result << content_tag(:iframe, nil, { :src => map }.merge(html_options))
        when 'object'
          result << content_tag(:object, nil, { :data => map, 
                                                :type => 'image/svg+xml', 
                                                :codebase => 'http://www.adobe.com/svg/viewer/install/'}.merge(html_options))
        else
          raise "It's not possible to insert SVG inside a '#{tag}' tag!"
      end
    end
  end
  
  # Plots a map in some bitmap format. Returns a img tag with the map.
  #
	# data: Hash whose pairs are in format '<country code> => <value>'. 
	# Example: { "us" => 125, "es" => 254 }
	# Default: {}
  #
	# options: Can be HTML options or map options.
	# 	
	# 	html: Options for the img tag that will be rendered. Any HTML attribute can be passed.
	# 	Example: { :style => 'border: 0', :id => 'my_map', :class => 'some class' }
	# 	Default: {}
	# 	Possible values: Any HTML attribute
  #
	# 	map: Options for the map. Some of them are the same as the ones accepted by the DataMap lib.
	# 	Example: { :title => 'Title of my map', :format => 'pdf' }
	# 	Default: {}
	# 	Possible values:
	# 		format: Which format will be used to render the map.
	#  					  Possible values: The ones accepted by RMagick
	# 				 	  Default: GraphMapConfig.default_output_format
  #
	# 		range_function: What function will be used to make the values ranges. An exception will be raised if the function name
	# 										is not recognized.
	# 										Possible values: 'log' or 'linear'
	# 										Default: 'log'
  #
	# 		log_base: What is the base of the log function, if the chosen range function is log.
	# 							Possible values: Any integer
	# 							Default: 10
  #
	# 		title: Title of the map.
	# 					 Possible values: Any string
	# 					 Default: No title
  #
	# 		legend: If the legend must be shown or not.
	# 						Possible values: true or false
	# 						Default: true
  #
	# 		palette: What color palette will be used.
	# 						 Possible values: The path for a color palette file. This file must be a plain text file with each line being 
	# 						 a color in RGB format. See the default one as an example.
	# 						 Default: WorldMap.default_palette (data_map/palettes/tango.color)
  #
	# 		lang: In what language the country names will be shown.
	# 					Possible values: A string representing a language. The directory data_map/lang/<language> must be present, with the proper
	# 					files inside it. See data_map/lang/en for example.
	# 					Default: WorldMap.default_language (en)
  #
	# 		template: The SVG template that will be used.
	# 							Possible values: The path for an SVG file.
	# 							Default: WorldMap.default_template (default_world_map.svg)
  #
	# 		output: The output filename (without the file extension).
	# 						Possible values: Any string
	# 						Default: GraphMapConfig.output
  #
	# 		quality: Quality of the image.
	# 						 Possible values: Any integer from 0 to 100
	# 						 Default: 100
  #
	# 		size: Dimensions of the image.
	# 					Possible values: A size string accepted by RMagick
	# 					Default: Size of the chosen template
  def plot_bitmap_map(data = {}, options = { :html => {}, :map => {} })
    map_options = options[:map] || {}
    html_options = options[:html] || {}
    map = GraphMapRender.make_bitmap_map data, map_options
    returning "" do |result|
      result << content_tag(:img, nil, { :src => map }.merge(html_options))
    end
  end
  
  # Links to a map. Returns an <a> tag pointing to the map.
  #
	# link_to_map(link_text = 'Download', data = {}, options = { :html => {}, :map => {} })
  #
	# The 'data' and 'options' parameters works as the same as above.
	# If the options[:map][:format] parameter is set as 'svg', an SVG map will be generated, so use the same map options as plot_svg_map.
	# Else, a bitmap map will be generated, so use the same map options as plot_bitmap_map.
  #
	# link_text: The text link.
	#					 Possible values: Any string
	#					 Default: 'Download'
  def link_to_map(link_text = 'Download', data = {}, options = { :html => {}, :map => {} })
    map_options = options[:map] || {}
    html_options = options[:html] || {}
    map = map_options[:format] == 'svg' ? GraphMapRender.make_svg_map(data, map_options) : GraphMapRender.make_bitmap_map(data, map_options)
    returning "" do |result|
      result << content_tag(:a, link_text, { :href => map }.merge(html_options))
    end
  end

  # Plots a table showing each value by country. Returns a <table> tag. 
  # The first column are the flags, then the country names and finally the values. 
  # The countries column and the values column are sortable (by Javascript). 
  # The sum of all the values is shown in the last row of the table. 
  # The country name depends on the language set in DataMap.
  #
	# data: Hash whose pairs are in format '<country code> => <value>'. 
	# Example: { "us" => 125, "es" => 254 }
	# Default: {}
  #
	# header: How the columns will be named. The keys are:
	# 	flag: How to call the flags column. Default: 'Flag'
	# 	country: How to call the countries column. Default: 'Country'
	# 	value: How to call the values column. Default: 'Value'
	# 	country: How to call the total row. Default: 'Total'
  #
	# html_options: Options for the img tag that will be rendered. Any HTML attribute can be passed.
	# Example: { :style => 'border: 0', :id => 'my_map', :class => 'some class' }
	# Default: {}
	# Possible values: Any HTML attribute
  def plot_table(data = {}, header = {}, html_options = {})

    strings = { :flag => 'Flag', :country => 'Country', :value => 'Value', :total => 'Total' }.merge(header)

    total = 0

    head = [content_tag(:thead, content_tag(:tr,
      [
        content_tag(:th, strings[:flag], :class => 'sorttable_nosort'),
        content_tag(:th, strings[:country]),
        content_tag(:th, strings[:value]),
      ]
    ))]

    body = []
    data.each do |code,value|
      row = []
      name = DataMap::WorldMap.country_name(code)
      name = name.split.collect{ |w| w.capitalize! }.join(' ') unless name.nil?
      row << content_tag(:td, content_tag(:img, nil, :alt => code, :src => '/flags/' + code + '.png'))
      row << content_tag(:td, name)
      row << content_tag(:td, value)
      body << content_tag(:tr, row.join)
      total += value
    end

    foot = [content_tag(:tfoot, content_tag(:tr,
      [
        content_tag(:td, nil),
        content_tag(:td, "<b>#{strings[:total]}</b>"),
        content_tag(:td, "<b>#{total}</b>")
      ], :class => 'sortbottom'
    ))]

    table = [head, content_tag(:tbody, body), foot]

    returning "" do |result|
      result << content_tag(:script, nil, :type => 'text/javascript', :src => '/javascripts/sorttable.js')
      result << content_tag(:table, table.join, { :class => 'sortable' }.merge(html_options))
    end

  end

end
