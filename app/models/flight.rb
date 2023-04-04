class Flight < ActiveRecord::Base
  paginates_per 3
end
