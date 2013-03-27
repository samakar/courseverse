class PeopleController < ApplicationController
	  autocomplete :person, :lastname

  def new
  end
end
