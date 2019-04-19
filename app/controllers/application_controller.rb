class ApplicationController < ActionController::Base
  @wallets

  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

  private

    def record_not_unique(error)
      redirect_to authenticated_root_path, flash: {alert: 'Record Already exists.'}
    end
end
