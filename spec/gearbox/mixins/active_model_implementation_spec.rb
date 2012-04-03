require_relative '../../spec_helper'

include Gearbox

describe ActiveModelImplementation do
  
  before do
    @class = Class.new do
      include Gearbox::ActiveModelImplementation
    end
  end
  
  let(:model) { @class.new }
  subject { @class.new }
  
  # I need to get the Lint working with the spec format.  I'll need to read how they do that in MiniTest...

end
