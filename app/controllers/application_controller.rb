class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :setup_environment
  before_action :setup_main_menu

  helper_method :admin?

  def admin?
    user_signed_in? && current_user.admin?
  end

  def authenticate_json_api_token!
    request.headers['Authorization'] == "Bearer #{ENV['JSON_API_KEY']}"
  end

  def authenticate_admin!
    unless admin?
      redirect_to request.referrer || root_path, notice: 'Admins Only! :|'
    end
  end

  def authenticate_user!
    if !user_signed_in?
      redirect_to request.referrer || root_path, notice: "Please sign up or sign in!  Thanks!"
    end
  end

private

  def setup_environment
    @application_name = ENV.fetch('CANONICAL_NAME', 'Disaster API')
  end

  def setup_main_menu
    #TODO: This isn't the most elaborate or pretty method, but it is straightforward.
    #      @main_menu contains all the top level items on the left side of the navbar.
    #      Each item is either a link or a dropdown menu that may be a link or test.
    #      Only 1 level of depth is supported.
    @main_menu = [
      { text: 'Home', path: root_path },
      { text: 'Shelters', path: shelters_path, submenu: [
        { text: 'Help Call Shelters', path: outdated_shelters_path }
      ] },
      { text: 'Distribution Points', path: distribution_points_path, submenu: [
        { text: 'Outdated Distribition Centers', path: outdated_distribution_points_path }
      ] },
      { text: 'Needs', path: needs_path, submenu: [] }
    ]
    if admin?
      # Shelters Admin Menu Items
      @main_menu[1][:submenu] += [
        { text: 'Shelters Update Queue', path: drafts_shelters_path },
        { text: 'Archived Shelters', path: archived_shelters_path }
      ]

      # Distribution Points Admin Menu Items
      @main_menu[2][:submenu] += [
        { text: 'Distribution Points Update Queue', path: drafts_distribution_points_path },
        { text: 'Archived Distribution Points', path: archived_distribution_points_path }
      ]

      # Needs Admin Menu Items
      @main_menu[3][:submenu] += [
        { text: 'Needs Update Queue', path: drafts_needs_path }
      ]

      # Admin Menu Items
      @main_menu << { text: 'Admin', submenu: [
        { text: 'Users', path: users_path },
        { text: 'AmazonProducts', path: amazon_products_path },
        { text: 'Charitable Organizations', path: charitable_organizations_path },
        { text: 'Pages', path: pages_path },
        { text: 'Trash', path: trash_index_path }
      ] }
    end
  end
end
