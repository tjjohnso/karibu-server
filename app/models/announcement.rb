class Announcement < ActiveRecord::Base

  belongs_to :announcer
  has_many :categories, :through => :categorizations
  has_many :categorizations

  acts_as_gmappable
  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
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

end
