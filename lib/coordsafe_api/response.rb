module CoordsafeApi
  class Response
    attr_accessor :success, :body

    def initialize(request)
      @status, @body = request.response, request.response.body
    end

    def success
      if @status.class == Net::HTTPOK
        true
      else
        false
      end
    end

    def body
      JSON.parse @body
    end
  end
end

