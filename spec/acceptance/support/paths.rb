module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def homepage
    "/"
  end
  
  def sign_in
    "/sign_in"
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
