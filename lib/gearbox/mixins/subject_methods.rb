module Gearbox
  module SubjectMethods

    def id
      send(id_method)
    end
    
    def id_method(value=:_value_not_set)
      @id_method = value unless value == :_value_not_set
      @id_method ||= :object_id
    end
    
  end
end
