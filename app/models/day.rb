class Day < ActiveRecord::Base
  belongs_to :week
  has_many :line_eats, :dependent => :destroy
  has_many :line_pas, :dependent => :destroy
end
