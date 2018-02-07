class Prospect
  include Mongoid::Document
  field :fullname, type: String
  field :email, type: String
  field :phone, type: Integer
  field :location, type: String
  field :stage_id, type: Integer
  field :managed_by, type: Integer

  belongs_to :user, foreign_key: :managed_by
  belongs_to :stage

  before_create :assign_stage_id
  after_create :create_customer

  def assign_stage_id
  	if self.stage_id == nil
  		stage = Stage.find_by(name: "New Opportunity")
  		#binding.pry
  		self.stage_id = stage.id
  	end
  end

  def create_customer
  	stage = Stage.find_by(name: "Won")
  	if self.stage_id == stage.id
  		Customer.create(fullname: self.fullname, email: self.email, phone: self.phone, location: self.location, managed_by: self.managed_by)
  	end
  end
end
