class AbstractSecurityController < ApplicationController
  
  # before_filter :set_account
  before_filter :must_be_logged_in
  
  private
  
  # def set_account
  #   @account = Account.find_by_name(params[:account_name])
  # end
  
  def must_be_logged_in
    # @current_user ||= Person.find_by_id_and_account_id(session[:user], session[:account])
    case request.format
    when Mime::XML, Mime::ATOM
      @account = Account.find_by_name(get_account_name_from_request)
      if user = authenticate_with_http_basic { |u, p| @account.people.basic_authenticate(u, p) }
        @current_user = user
      else
        request_http_basic_authentication
      end
    else
      if logged_in?
        # @account ||= Account.find(session[:account])
        @account ||= @current_user.account
        @other_account_people = Person.find_all_by_email_and_authenticated(@current_user.email,1) - [@current_user]
        return true
      else
        flash[:error] = 'Please log in'
        redirect_to :controller => '/login' and return false
      end
    end
  end
  
  def get_account_name_from_request
    'agileista'
  end
  # def authenticate
  #   case request.format
  #   when Mime::XML, Mime::ATOM
  #     if user = authenticate_with_http_basic { |u, p| @account.users.authenticate(u, p) }
  #       @current_user = user
  #     else
  #       request_http_basic_authentication
  #     end
  #   else
  #     if session_authenticated?
  #       @current_user = @account.users.find(session[:authenticated][:user_id])
  #     else
  #       redirect_to(login_url) and return false
  #     end
  #   end
  # end

  
  
end