class RolesController < ApplicationController
  filter_access_to :all

  before_action :set_role, only: [:show, :edit, :update, :destroy]

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  def add_user
    user = User.find(params[:user_id])
    role = Role.find(params[:id])
    role.users << user unless role.users.include?(user)
    redirect_to role_path(role)
  end

  def remove_user
    user = User.find(params[:user_id])
    role = Role.find(params[:id])
    role.users.delete(user)
    redirect_to role_path(role)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:title)
    end
end
