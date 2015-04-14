class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :cors_preflight_check
  after_action :cors_set_access_control_headers
  before_action :normalize_params!

  # For all responses, return the CORS access control headers.

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = %w{Origin Accept Content-Type X-Requested-With auth_token X-CSRF-Token}.join(',')
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == "OPTIONS"
      headers['Access-Control-Allow-Origin'] = 'http://localhost'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = %w{Origin Accept Content-Type X-Requested-With auth_token X-CSRF-Token}.join(',')
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

  # replaces params with a version where all the parent keys are lowercase
  # does not include children hashes
  def normalize_params!
    if params.is_a? Hash
      # create a new array with the lowercase key and values and convert to hash
      new_hash = params.map{ | key, value | [key.downcase, value] }.to_h
    else
      # raise error informative error
      raise TypeError, 'Not a Hash'
    end
    # replace the old hash with the new values
    params.replace(new_hash)
  end

end
