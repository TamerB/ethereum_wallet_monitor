module WalletRequest
  require 'net/http'
  require 'json'

  def getWallets(wallet_addresses)
    begin
      data = make_request("https://api.etherscan.io/api?module=account&action=balancemulti&address=" + wallet_addresses + "&tag=latest&apikey=YourApiKeyToken")
      if data['message'] == "OK"
        @wallets_list.each_with_index do |w, index|
          balance = data['result'][index]['balance'].to_f / 1000000000000000000
          @wallets << {wallet: w, balance: balance, transactions: getTransactions(w.wallet_address)}
        end
      end
    rescue
      flash.now[:alert] = "Service not available"
      @wallets = []
    end
  end

  def getTransactions(account)
    begin
      uri = URI("http://api.etherscan.io/api?module=account&action=txlist&address=" + account + "&startblock=0&endblock=99999999&sort=desc&apikey=YourApiKeyToken")
      req = Net::HTTP::Get.new(uri)

      response = Net::HTTP.start(uri.hostname, uri.port) {|http|
        http.request(req)
      }

      data = JSON.parse(response.body)

      if data['message'] == "OK"
        data['result']
      else
        []
      end
    rescue
      aflash.now[:alert] = "Service not available"
      []
    end
  end

  def getPln()
    begin
      data = make_request("https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=PLN")
      data['PLN']
    rescue
      flash.now[:alert] = "Service not available"
      false
    end
  end

  def getWallet(wallet)
    begin
      data = make_request("https://api.etherscan.io/api?module=account&action=balance&address=" + wallet + "&tag=latest&apikey=YourApiKeyToken")

      if data['message'] == "OK"
        data['result'].to_f / 1000000000000000000
      else
        false
      end
    rescue
      flash.now[:alert] = "Service not available"
      false
    end
  end

  def make_request(request_url)
    uri = URI.parse(request_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.get(uri.request_uri)

    return JSON.parse(response.body)
  end
end
