# Useful for a Pry session.

include Gearbox

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

def model_directory
  @model_directory ||= "/tmp"
end
attr_writer :model_directory
