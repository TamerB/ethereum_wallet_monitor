class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include WalletRequest

  @wallets
end
