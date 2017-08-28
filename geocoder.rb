Rack::Request.send :include, Geocoder::Request
Geocoder.configure(

  timeout: 50,

)
