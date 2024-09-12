class ErrorSerializer
  def initialize(errors_object)
    @errors_object = errors_object
  end

  def serialize_json
    {
      "errors": [
        {
          detail: @errors_object.message
        }
      ]
    }
  end
end