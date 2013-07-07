module CoordsafeApi
  class Response
    attr_accessor :status, :body

    def initialize(request)
      @status, @body = request.headers, request.response.body
    end

    def status
      #T0D0
    end

    def body
      #T0D0
    end
  end
end

