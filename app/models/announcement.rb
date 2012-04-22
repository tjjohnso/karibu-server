class Announcement < ActiveRecord::Base

  belongs_to :announcer
  has_many :categories, :through => :categorizations
  has_many :categorizations

  # TODO:
  # Figure out a way to simply ignore properties that aren't recognized when creating an object.
  # Test to make sure object was created.
  # change package name to com.karibu instead of org.karibu
  # Add start and expiration date to model
  # On client side, I, at some point, remove a few properties from the announcement project before sending the JSON
  #   over to the server side for creation (or updating). Put that list of to-be-removed properties in an array at the
  #   top of the file and just cycle through the properties to remove them from the JSON.
  # Maybe the 406 Not Acceptable came about because the controller didn't respond to json.
  # When querying for announcements, return the categories from the query so you don't have to make several queries.
  # On client side, handle when no data comes back from server.
  # Validate parameters, especially longitude and latitude.
  # Remove unneeded attributes from JSON sent to server like announcer.
  # Figure out how to not do geocoding if the longitude and latitude values are present.
  # Figure out how to force geocoding on update if address changes. But maybe we won't want to do that. We'll see.
  # On client side, be able to handle when the response from saving or updating an announcement is not 200 OK. I think
  #   gmaps4rails sends back 406 when the announcement address is not valid.

  before_save :geocode_address
  acts_as_gmappable :process_geocoding => false
  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    address
  end

  def address
    "#{self.street}, #{self.city}, #{self.country}"
  end

  def self.search(params)

    range = params[:range] || 5 # 5 km
    longitude = params[:longitude]
    latitude = params[:latitude]
    results = scoped

    if !params.nil?
      if !longitude.nil? and !latitude.nil?
        results = within(range, :origin => [latitude, longitude])
      end
    end

    #if !params.nil?
    #  if !params[:longitude].nil?
    #    longitude = params[:longitude]
    #    long_min = Float(longitude) - range
    #    long_max = Float(longitude) + range
    #    results = results.where("longitude BETWEEN ? AND ?", long_min, long_max)
    #  end
    #
    #  if !params[:latitude].nil?
    #    latitude = params[:latitude]
    #    lat_min = Float(latitude) - range
    #    lat_max = Float(latitude) + range
    #    results = results.where("latitude BETWEEN ? AND ?", lat_min, lat_max)
    #  end
    #end

    results
  end

  # Special thanks to Chris Veness at Movable-Type.co.uk
  # http://www.movable-type.co.uk/scripts/latlong.html
  def self.get_longitude_bounds(long, lat, distance) # radius is in km
    pi = Math::PI
    earth_radius = 6371 # radius of the Earth in km
    bearing = pi/2;     # The bearing for getting the rightmost bound is PI/2 radians.
                        # A bearing of 0 radians points north.
    lat_max =  Math.asin( Math.sin(lat)*Math.cos(distance/earth_radius) + Math.cos(lat)*Math.sin(distance/earth_radius)*Math.cos(bearing) )
    puts lat_max
    long_delta = Math.atan2(Math.sin(bearing)*Math.sin(distance/earth_radius)*Math.cos(lat), Math.cos(distance/earth_radius)-Math.sin(lat)*Math.sin(lat_max))
    long_max = long + long_delta
    puts long_max
    long_min = long - long_delta

    #bearing =  (3*pi)/2
    #lat_min =  Math.asin( Math.sin(lat)*Math.cos(distance/earth_radius) + Math.cos(lat)*Math.sin(distance/earth_radius)*Math.cos(bearing) )
    #long_min = long + Math.atan2(Math.sin(bearing)*Math.sin(distance/earth_radius)*Math.cos(lat), Math.cos(distance/earth_radius)-Math.sin(lat)*Math.sin(lat_min))

    {:long_min => long_min, :long_max => long_max}
  end

  private

  def geocode_address
    if !(self.longitude.nil? or self.latitude.nil?) # If both the latitude and longitude are present, perform geocode
      begin
        data = Gmaps4rails.geocode(address).first
        self.latitude= data[:lat]
        self.longitude= data[:lng]
      rescue Gmaps4rails::GeocodeStatus
        puts "trying to rescue"
      end
    end
  end

end
