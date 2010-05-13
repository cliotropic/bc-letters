class CreatePlaces < ActiveRecord::Migration
  def self.up   
    create_table	 :places do |p|
			p.string :address
			p.string :city
			p.string :state
			p.string :country
			p.string :postalcode
    	
    	p.timestamps
    	{:id => true}
    end

  end

  def self.down
    drop_table :places
  end
end
