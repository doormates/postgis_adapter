module PostgisAdapter
module Functions

    #
    # Class Methods
    #
    module ClassMethods

      #
      # Returns the closest record
      def closest_to(p, opts = {})
        srid = opts.delete(:srid) || 4326
        opts.merge!(:order => "ST_Distance(#{default_geometry}, ST_GeomFromText('POINT(#{p.x} #{p.y})', #{srid}))")
        find(:first, opts)
      end

      #
      # Order by distance
      def close_to(p, opts = {})
        srid = opts.delete(:srid) || 4326
        opts.merge!(:order => "ST_Distance(geom, ST_GeomFromText('POINT(#{p.x} #{p.y})', #{srid}))")
        find(:all, opts)
      end

      def by_length opts = {}
        sort = opts.delete(:sort) || 'asc'
        opts.merge!(:order => "ST_length(geom) #{sort}")
        find(:all, opts)
      end

      def longest
        find(:first, :order => "ST_length(geom) DESC")
      end

      def contains(p, srid=4326)
        find(:all, :conditions => ["ST_Contains(#{postgis_geoms.to_s}, ST_GeomFromText('POINT(#{p.x} #{p.y})', #{srid}))"])
      end

      def contain(p, srid=4326)
        find(:first, :conditions => ["ST_Contains(#{postgis_geoms.to_s}, ST_GeomFromText('POINT(#{p.x} #{p.y})', #{srid}))"])
      end

      def by_area sort='asc'
        find(:all, :order => "ST_Area(geom) #{sort}" )
      end

      def by_perimeter sort='asc'
        find(:all, :order => "ST_Perimeter(geom) #{sort}" )
      end

      def all_dwithin(other, margin=1)
        # find(:all, :conditions => "ST_DWithin(geom, ST_GeomFromEWKB(E'#{other.as_ewkt}'), #{margin})")
        # where "ST_DWithin(ST_GeomFromText(?, 4326), geometry, ?)", location_as_text, distance
        where "ST_DWithin(#{default_geometry}, ST_GeomFromEWKT(?), ?)", other.as_hex_ewkb, margin
      end

      def all_within(other)
        find(:all, :conditions => "ST_Within(geom, ST_GeomFromEWKT(E'#{other.as_hex_ewkb}'))")
      end

      def by_boundaries sort='asc'
        find(:all, :order => "ST_Boundary(geom) #{sort}" )
      end

    end

end
end
