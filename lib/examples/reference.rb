module Gearbox
  class Reference
    attr_accessor :location
    attr_accessor :audience

    attr_writer :person_source
    attr_writer :theme_source
    
    def add_person(hash={})
      new_person = person_source.call(hash.merge(:reference => self))
      people << new_person
      new_person
    end
    
    def people
      @people ||= []
    end
    
    def add_theme(hash={})
      new_theme = theme_source.call(hash.merge(:reference => self))
      themes << new_theme
      new_theme
    end
    
    def themes
      @themes ||= []
    end
    
    private
      def person_source
        @person_source ||= Person.public_method(:new)
      end
      
      def theme_source
        @theme_source ||= Theme.public_method(:new)
      end
  end
end
