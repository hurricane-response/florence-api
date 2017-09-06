json.extract! amazon_product, :need, :asin, :amazon_title, :detail_url,
                       :priority, :category_specific, :category_general,
                       :price_in_cents
json.price number_to_currency((amazon_product.price_in_cents/100.0))
