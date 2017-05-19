class AddCodeToAlgorithms < ActiveRecord::Migration[5.0]
  def change
  	add_attachment :algorithms, :code
  end
end
