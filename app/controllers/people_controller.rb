class PeopleController < ApplicationController
  def edit
    @person = current_person
  end

  def update
    @person = current_person
    Person.editable_attributes.each do |attr|
      @person.send("#{attr}=", params[:person][attr])
    end
    @person.save!
    redirect_to dashboard_path
  end

  def create
    @person = Person.new(:user_id => current_user.id)
    Person.editable_attributes.each do |attr|
      @person.send("#{attr}=", params[:person][attr])
    end
    @person.save!
    redirect_to dashboard_path
  end

  def new
    @creating_person = true
    @person = Person.new
  end
end
