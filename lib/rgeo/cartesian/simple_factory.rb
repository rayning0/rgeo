# -----------------------------------------------------------------------------
# 
# Geographic data factory implementation
# 
# -----------------------------------------------------------------------------
# Copyright 2010 Daniel Azuma
# 
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
# * Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
# * Neither the name of the copyright holder, nor the names of any other
#   contributors to this software, may be used to endorse or promote products
#   derived from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
# -----------------------------------------------------------------------------
;


module RGeo
  
  module Cartesian
    
    
    # This class implements the factory for the simple cartesian
    # implementation.
    
    class SimpleFactory
      
      include Features::Factory::Instance
      
      
      # Create a new simple cartesian factory.
      # 
      # Options supported are:
      # 
      # <tt>:srid</tt>::
      #   The SRID reported by features created by this factory.
      #   Default is 0.
      
      def initialize(opts_={})
        @srid = opts_[:srid].to_i
      end
      
      
      # Equivalence test.
      
      def eql?(rhs_)
        rhs_.is_a?(self.class) && @srid == rhs_.srid
      end
      alias_method :==, :eql?
      
      
      # Returns the SRID.
      
      def srid
        @srid
      end
      
      
      # See ::RGeo::Features::Factory#parse_wkt
      
      def parse_wkt(str_)
        ImplHelpers::Serialization.parse_wkt(str_, self)
      end
      
      
      # See ::RGeo::Features::Factory#parse_wkb
      
      def parse_wkb(str_)
        ImplHelpers::Serialization.parse_wkb(str_, self)
      end
      
      
      # See ::RGeo::Features::Factory#point
      
      def point(x_, y_)
        SimplePointImpl.new(self, x_, y_) rescue nil
      end
      
      
      # See ::RGeo::Features::Factory#line_string
      
      def line_string(points_)
        SimpleLineStringImpl.new(self, points_) rescue nil
      end
      
      
      # See ::RGeo::Features::Factory#line
      
      def line(start_, end_)
        SimpleLineImpl.new(self, start_, end_) rescue nil
      end
      
      
      # See ::RGeo::Features::Factory#linear_ring
      
      def linear_ring(points_)
        SimpleLinearRingImpl.new(self, points_) rescue nil
      end
      
      
      # See ::RGeo::Features::Factory#polygon
      
      def polygon(outer_ring_, inner_rings_=nil)
        SimplePolygonImpl.new(self, outer_ring_, inner_rings_) rescue nil
      end
      
      
      # See ::RGeo::Features::Factory#collection
      
      def collection(elems_)
        SimpleGeometryCollectionImpl.new(self, elems_) rescue nil
      end
      
      
      # See ::RGeo::Features::Factory#multi_point
      
      def multi_point(elems_)
        SimpleMultiPointImpl.new(self, elems_) rescue nil
      end
      
      
      # See ::RGeo::Features::Factory#multi_line_string
      
      def multi_line_string(elems_)
        SimpleMultiLineStringImpl.new(self, elems_) rescue nil
      end
      
      
      # See ::RGeo::Features::Factory#multi_polygon
      
      def multi_polygon(elems_)
        SimpleMultiPolygonImpl.new(self, elems_) rescue nil
      end
      
      
    end
    
  end
  
end