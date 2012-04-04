# Useful for a Pry session.

require 'forwardable'

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
  
  def load_model(name)
    raise "Directory does not exist" unless File.exist?(model_directory)
    filename = File.join(model_directory, "#{name}.rb")
    load filename
  end

  def model_directory
    @model_directory ||= File.expand_path("~/.gearbox") if File.exist?(File.expand_path("~/.gearbox"))
    @model_directory ||= File.expand_path("/tmp") if File.exist?("/tmp")
    @model_directory
  end
  attr_writer :model_directory
  
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
  :load_model
  
