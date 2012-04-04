# Useful for a Pry session.

require 'forwardable'
require 'fileutils'

include Gearbox

class Utilities
  # Great for writing ad hoc models.
  # TODO: Make this work for several sessions. (Thread it?)
  def write_model(name)
    raise "Directory does not exist" unless File.exist?(model_directory)
    filename = File.join(model_directory, "#{name}.rb")
    raise "ENV['EDITOR'] not set" unless ENV['EDITOR']
    `#{ENV['EDITOR']} #{filename}`
    load filename
  end
  alias :update_model :write_model
  alias :build_model :write_model
  
  def edit_models
    raise "Directory does not exist" unless File.exist?(model_directory)
    raise "ENV['EDITOR'] not set" unless ENV['EDITOR']
    `#{ENV['EDITOR']} #{model_directory}`
    Dir.glob("#{model_directory}/*.rb").map { |filename| load filename}
  end
  
  def load_model(name)
    raise "Directory does not exist" unless File.exist?(model_directory)
    filename = File.join(model_directory, "#{name}.rb")
    load filename
  end

  def user_directory
    File.expand_path("~/.gearbox")
  end
  
  def user_model_directory
    @user_model_directory ||= File.join(user_directory, "models")
  end
  
  def model_directory
    return @model_directory if @model_directory
    if File.exists?(user_directory)
      FileUtils.mkdir(user_model_directory) unless File.exists?(user_model_directory)
      @model_directory = user_model_directory
    elsif File.exists?("/tmp")
      @model_directory = File.expand_path("/tmp") if File.exists?("/tmp")
    end
    @model_directory
  end
  attr_writer :model_directory
  
  def list_models
    Dir.glob("#{model_directory}/*.rb").map { |file| File.basename(file).split('.')[0..-2].join('.').to_sym}
  end
  
  def tmp_directory
    @tmp_directory ||= "/tmp"
  end
  attr_writer :tmp_directory
  
  require 'fileutils'
  # Great for writing descriptions without messing around with quotes and escapes and things
  # TODO: Make this work for several sessions. (Thread it?)
  def get_note(type="md")
    contents = nil
    begin
      filename = File.join(tmp_directory, "#{self.object_id}.#{type}")
      i = 0
      while File.exist?(filename)
        filename = File.join(tmp_directory, "#{self.object_id}#{i}.#{type}")
        i += 1
      end
      raise "ENV['EDITOR'] not set" unless ENV['EDITOR']
      `#{ENV['EDITOR']} #{filename}`
      contents = File.read(filename)
    ensure
      puts "Cleaning up temp file and exiting ..."
      FileUtils.rm_f(filename)
    end
  end
  
end

@utilities = Utilities.new
extend Forwardable
def_delegators :@utilities, 
  :write_model, 
  :update_model,
  :build_model, 
  :model_directory, 
  :model_directory=, 
  :tmp_directory,
  :tmp_directory=,
  :get_note,
  :load_model,
  :list_models,
  :edit_models
  
