class WalletsController < ApplicationController

  def index
    @wallets = []
    @wallets_list = current_user.wallets.order(created_at: :desc)
    wallets = []
    @wallets_list.each do |w|
      wallets << w.wallet_address
    end

    wallets_string = wallets.join(",")
    getWallets(wallets_string)
  end

  def show
    begin
      pln = 1
      @currency = 'ETH'
      @wallet = current_user.wallets.find(params[:id])


      @transactions = getTransactions(@wallet.wallet_address)

      if params[:currency] == 'PLN'
        @currency = 'PLN'
        pln = getPln()
      end

      @balance = getWallet(@wallet.wallet_address) * pln

      @transactions.each do |t|
        t['value'] = t['value'].to_f * pln / 1000000000000000000
        t['gas'] = t['gas'].to_f * pln / 1000000000000000000
        t['gasPrice'] = t['gasPrice'].to_f * pln / 1000000000000000000
      end
    rescue
      flash.now[:alert] = "Service not available"
      redirect_to wallets_path
    end
  end

  def new
  end

  def create
    begin
      if getWallet(wallet_params[:wallet_address]) != false
        @wallet = current_user.wallets.create(wallet_params)
        if @wallet.save
          redirect_to @wallet
        else
          redirect_to new_wallet_path
        end
      else
        redirect_to new_wallet_path
      end
    rescue
      redirect_to new_wallet_path
    end
  end

  def destroy
    begin
      @wallet = current_user.wallets.find(params[:id])
      @wallet.destroy
    ensure
      redirect_to wallets_path
    end
  end

  private
    def wallet_params
      params.permit(:wallet_address)
    end
end
