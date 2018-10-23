require 'money'
require 'eu_central_bank'
# Money.locale_backend = :i18n
eu_bank = EuCentralBank.new
Money.default_bank = eu_bank
# cache = File.join(Rails.root, 'app', 'files', "Sheet.csv")
cache = "app/files/exchange_rates.xml"
eu_bank.save_rates(cache)
eu_bank.update_rates(cache)

if !eu_bank.rates_updated_at || eu_bank.rates_updated_at < Time.now - 1.days
  eu_bank.save_rates(cache)
  eu_bank.update_rates(cache)
end
