class Microgroup < ActiveRecord::Base
  belongs_to :owner
  belongs_to :group
end