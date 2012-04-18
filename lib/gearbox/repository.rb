module Gearbox
  class Repository < ::SPARQL::Client::Repository
    
    MAX_TRIES = 10
    
    attr_reader :data_uri, :update_uri, :status_uri, :size_uri
    
    def initialize(endpoint="http://localhost:8000", options = {})
      super
      assert_uris!
    end
    
    def each(&block)
      raise NotImplemented, "each is not yet implemented in Gearbox::Adapter"
    end
    
    # def insert_statement
    #   raise NotImplemented, "insert_statement is not yet implemented in Gearbox::Adapter"
    # end
    
    # def delete_statement
    #   raise NotImplemented, "delete_statement is not yet implemented in Gearbox::Adapter"
    # end
    
    attr_writer :load_handler
    def load_handler
      @load_handler ||= lambda do |*args|
        filename = args.shift
        options = args.shift
        options ||= {}
        uri = options[:context] ? File.join(data_uri, options[:context]) : File.join(data_uri, "file://#{File.expand_path(filename)}")
        content = open(filename).read
        begin
          request = Net::HTTP::Put.new(uri.path)
          Net::HTTP.start(uri.host, uri.port) do |http|
            http.request(request, content)
          end
        rescue Errno::ECONNRESET, Errno::ECONNREFUSED, TimeoutError
          retries ||= 0
          retries += 1
          retries <= MAX_TRIES ? retry : raise
        end
      end
    end
    
    def load(*args)
      load_handler.call(*args)
    end
    alias :load! :load

    private
      def assert_uris!
        uri = self.client.url.to_s
        @data_uri = File.join(uri, 'data', '/')
        @update_uri = File.join(uri, 'update', '/')
        @status_uri = File.join(uri, 'status', '/')
        @size_uri = File.join(uri, 'size', '/')
      end
  end
end
