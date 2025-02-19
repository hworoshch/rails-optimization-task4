module Instrumentation
  def add_param_context(*keys)
    return if Rails.env.test?

    keys.each do |key|
      honeycomb_metadata[key] = params[key]
    end
  end

  def add_context(metadata)
    return if Rails.env.test?

    metadata.each do |key, value|
      honeycomb_metadata[key] = value
    end
  end

  def append_to_honeycomb(request, controller_name)
    return if Rails.env.test?
    return if honeycomb_metadata.nil?

    honeycomb_metadata["trace.trace_id"] = request.request_id
    honeycomb_metadata["trace.span_id"] = request.request_id
    honeycomb_metadata[:service_name] = "rails"
    honeycomb_metadata[:name] = controller_name
  end
end
