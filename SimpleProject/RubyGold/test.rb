require "monetize"

Money.locale_backend = :currency

bargain_price = Monetize.from_numeric(99, "USD")
p bargain_price.format

