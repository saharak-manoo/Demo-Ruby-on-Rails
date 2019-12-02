class HomesController < ApplicationController
  before_action :authenticate_user!
end
