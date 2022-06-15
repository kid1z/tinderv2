class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # enum :address, [ :active, :archived]
end
