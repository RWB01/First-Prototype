class CommunityController < ApplicationController

  # GET /communities
  # GET /communities.json
  def index
    @groups = Group.all
    @departments = Department.all
  end
end
