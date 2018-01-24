class Question < ApplicationRecord
  enum tipo: [ :taxistas, :usuarios]
end
