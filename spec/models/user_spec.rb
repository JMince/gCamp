require "rails_helper"

describe User do
   it "requires a first name" do
     user = User.create( first_name: "Jeff", last_name: "Mince", email: "jeff@jeff.com" )
     expect(user).to be_valid
   end
 end
