require File.dirname(__FILE__) + '/../lib/graph_map_config'
require 'fileutils'
namespace :graph_map do

  desc 'Install GraphMap'
  task :install => ['graph_map:install_all']

  desc 'Install the GraphMap script into the public/javascripts directory of this application'
  task :add_js => ['graph_map:add_or_replace_graph_map_js']

  desc 'Install the SortTable script into the public/javascripts directory of this application'
  task :add_js => ['graph_map:add_or_replace_sorttable_js']

  desc 'Install flag images at public/flags'
  task :add_flags => ['graph_map:add_flags_dir']

  desc 'Create directory for maps'
  task :create_maps => ['graph_map:create_maps_dir']

  desc 'Clear cache'
  task :clear => ['graph_map:clear_cache']

  task :install_all do
    Rake::Task['graph_map:add_or_replace_graph_map_js'].invoke
    Rake::Task['graph_map:add_or_replace_sorttable_js'].invoke
    Rake::Task['graph_map:add_flags'].invoke
    Rake::Task['graph_map:create_maps_dir'].invoke
  end

  task :clear_cache do
    dest = "#{GraphMapConfig.root}/public/graph_maps"
    if File.exists?(dest)
      begin
        puts "#{dest} exists. Clearing..."
        FileUtils.rm_rf dest
        FileUtils.mkdir dest
        puts "#{dest} cleared."
      rescue
        puts "ERROR: Problem clearing GraphMap cache. Please clear #{dest} manually."
      end
    else
      # do nothing
      begin
        puts "#{dest} doesn't exist. Nothing to do."
      rescue
        puts "ERROR: Problem checking GraphMap. Please check manually if #{dest} exists before clearing it."
      end
    end
  end

  task :create_maps_dir do
    dest = "#{GraphMapConfig.root}/public/graph_maps"
    if File.exists?(dest)
      # do nothing
      begin
        puts "#{dest} already exists. Nothing to do."
      rescue
        puts "ERROR: Problem checking GraphMap. Please check manually if #{dest} exists."
      end
    else
      # install
      begin
        puts "Installing GraphMap to #{dest}..."
        FileUtils.mkdir dest
        puts "Successfully installed GraphMap."
      rescue
        puts "ERROR: Problem installing GraphMap. Please manually create #{dest}."
      end
    end
  end

  task :add_flags_dir do
    dest = "#{GraphMapConfig.root}/public/flags"
    if File.exists?(dest)
      # upgrade
      begin
        puts "Removing directory #{dest}..."
        FileUtils.rm_rf dest
        puts "Installing GraphMap to #{dest}..."
        FileUtils.cp_r "#{GraphMapConfig.root}/vendor/plugins/graph_map/public/flags", dest
        puts "Successfully updated GraphMap."
      rescue
        puts "ERROR: Problem updating GraphMap. Please manually copy "
        puts "#{GraphMapConfig.root}/vendor/plugins/graph_map/public/flags"
        puts "to"
        puts "#{dest}"
      end
    else
      # install
      begin
        puts "Installing GraphMap to #{dest}..."
        FileUtils.cp_r "#{GraphMapConfig.root}/vendor/plugins/graph_map/public/flags", dest
        puts "Successfully installed GraphMap."
      rescue
        puts "ERROR: Problem installing GraphMap. Please manually copy "
        puts "#{GraphMapConfig.root}/vendor/plugins/graph_map/public/flags"
        puts "to"
        puts "#{dest}"
      end
    end
  end

  task :add_or_replace_graph_map_js do
    dest = "#{GraphMapConfig.root}/public/javascripts/graph_map.js"
    if File.exists?(dest)
      # upgrade
      begin
        puts "Removing file #{dest}..."
        FileUtils.rm_rf dest
        puts "Installing GraphMap to #{dest}..."
        FileUtils.cp_r "#{GraphMapConfig.root}/vendor/plugins/graph_map/public/javascripts/graph_map.js", dest
        puts "Successfully updated GraphMap."
      rescue
        puts "ERROR: Problem updating GraphMap. Please manually copy "
        puts "#{GraphMapConfig.root}/vendor/plugins/graph_map/public/javascripts/graph_map.js"
        puts "to"
        puts "#{dest}"
      end
    else
      # install
      begin
        puts "Installing GraphMap to #{dest}..."
        FileUtils.cp_r "#{GraphMapConfig.root}/vendor/plugins/graph_map/public/javascripts/graph_map.js", dest
        puts "Successfully installed GraphMap."
      rescue
        puts "ERROR: Problem installing GraphMap. Please manually copy "
        puts "#{GraphMapConfig.root}/vendor/plugins/graph_map/public/javascripts/graph_map.js"
        puts "to"
        puts "#{dest}"
      end
    end
  end

  task :add_or_replace_sorttable_js do
    dest = "#{GraphMapConfig.root}/public/javascripts/sorttable.js"
    if File.exists?(dest)
      # upgrade
      begin
        puts "Removing file #{dest}..."
        FileUtils.rm_rf dest
        puts "Installing SortTable to #{dest}..."
        FileUtils.cp_r "#{GraphMapConfig.root}/vendor/plugins/graph_map/public/javascripts/sorttable.js", dest
        puts "Successfully updated SortTable."
      rescue
        puts "ERROR: Problem updating SortTable. Please manually copy "
        puts "#{GraphMapConfig.root}/vendor/plugins/graph_map/public/javascripts/sorttable.js"
        puts "to"
        puts "#{dest}"
      end
    else
      # install
      begin
        puts "Installing SortTable to #{dest}..."
        FileUtils.cp_r "#{GraphMapConfig.root}/vendor/plugins/graph_map/public/javascripts/sorttable.js", dest
        puts "Successfully installed SortTable."
      rescue
        puts "ERROR: Problem installing SortTable. Please manually copy "
        puts "#{GraphMapConfig.root}/vendor/plugins/graph_map/public/javascripts/sorttable.js"
        puts "to"
        puts "#{dest}"
      end
    end
  end

end
