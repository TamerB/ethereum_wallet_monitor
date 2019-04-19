# Context:
This application helps users monitor their Ethereum wallets.

![app screenshot](https://github.com/exlabs/ruby_take_home_challenge/blob/master/public/repo_screenshot.png)



# App functionality:
* User can add existing Wallet address to list of monitored Wallet addresses
* User can see list of monitored Wallets addresses with most recently added at the top
* User can see details of Wallets including list of transactions, as well as total balances
* User can see how many non-empty wallets are registered on the site (see welcome screen for non-logged-in user)
* User can toggle between ETH and PLN currency on list of transactions

# 3rd party APIs:
* Ethereum API (https://etherscan.io/apis)
* For currency conversion between ETH and PLN I used (https://min-api.cryptocompare.com)

# How to run this thing
* This application is written in Ruby on Rails with a 2.5.1 Ruby version and 5.2.1. You need to install corresponding Ruby and Rails versions using version manager of your choosing
```
--- install ruby 2.5.1 and rails 5.2.1 ---
```
* Run gems installation
```
bundle install
```
* Create database
```
bundle exec rake db:setup
```
* Run server
```
bundle exec rails server
```
* Run tests
Not added yet.
