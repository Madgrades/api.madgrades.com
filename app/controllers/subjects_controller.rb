class SubjectsController < ApplicationController
  def index
    @subjects = Subject.all
  end
end
