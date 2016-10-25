# Product has information about product itself, its price and shop
# with this price
class Product
  attr_reader :name, :price, :shop

  def initialize(name, price, shop)
    @price = price.to_f
    @shop = shop
    @name = name
  end

  def to_s
    " * #{@name}  -> (#{@price})"
  end
end

# Shop represents shop with products
class Shop
  attr_accessor :name, :products

  def initialize(name, products = nil)
    @products = []
    @name = name
    @products << products
    @products.compact!
  end

  def includes_all_products?(cart)
    cart - products_names_list == []
  end

  def sum_of_cart(cart)
    if includes_all_products?(cart)
      products_list = select_products_for_sum(cart)
      products_list.map(&:price).inject(:+)
    end
  end

  def select_products_for_sum(cart)
    products_list = @products - [[]]
    products_list.compact.select { |item| cart.include? item.name }
  end

  private

  def products_names_list
    products_names = @products - [[]]
    products_names.compact.map(&:name)
  end

  def to_s
    "#{@name}:"
  end
end

# InputReader - Class for read and parse input
class InputReader
  attr_accessor :market
  def initialize(input)
    @market = Market.new
    input.each do |product, shops|
      shops.each do |shop, price|
        shoptmp = pick_shop(shop)
        producttmp = Product.new(product, price, shoptmp)
        shoptmp.products << producttmp
        @market.shops << shoptmp unless shop_exists?(shop)
      end
    end
  end

  def shop_exists?(shop)
    @market.shops.map(&:name).include? shop
  end

  def pick_shop(shop)
    return Shop.new(shop) unless shop_exists?(shop)
    @market.shops.select { |item| item.name == shop }.first
  end
end

# Usefull for parsing output - represents ShoppingList ;)
class ShoppingList
  attr_accessor :shop, :products

  def initialize(shop, products)
    @shop = shop
    @products = products
  end

  def sum
    products.map(&:price).inject(:+)
  end
end

# update Array with sum I need
class Array
  def sum
    map(&:sum).inject(:+).round(2)
  end
end

# Market - Contener of Shops
class Market
  attr_accessor :shops

  def initialize
    @shops = []
  end

  def sort_shops_by_prices_sum(cart, shops = @shops)
    shops = shops.select { |shop| shop.includes_all_products?(cart) }
    shops_list = []
    shops.each do |shop|
      products = shop.select_products_for_sum(cart)
      shops_list << ShoppingList.new(shop, products)
    end
    print_shopping_list(shops_list, :sort)
  end

  def find_cheapest_products(cart)
    cheapest = select_and_group_cheapest_products(@shops, cart)
    print_shopping_list(prepare_products_shopping_list(cheapest))
  end

  def find_cheapest_products_in_n_shops_only(cart, nshops)
    shops_combs = prepare_shops_combinations_with_cart_products(cart, nshops)
    cheapest = []
    shops_combs.each do |shops|
      products = select_and_group_cheapest_products(shops, cart)
      cheapest << ShoppingList.new(shops, products)
    end
    cheapest_products = cheapest.sort_by(&:sum).first.products
    list = prepare_products_shopping_list(cheapest_products)
    print_shopping_list(list)
  end

  private

  def prepare_products_shopping_list(products)
    lists = []
    products.group_by(&:shop).each do |shop, items|
      lists << ShoppingList.new(shop, items)
    end
    lists
  end

  def all_products_from_n_shops(shops)
    shops.map(&:products).flatten
  end

  def all_products_from_n_shops_by_cart(shops, cart)
    all_products_from_n_shops(shops).select { |item| cart.include? item.name }
  end

  def shops_includes_all_products?(shops, cart)
    cart - all_products_from_n_shops(shops).map(&:name) == []
  end

  def prepare_shops_combinations_with_cart_products(cart, nshops)
    shops_combs = @shops.combination(nshops)
    shops_combs.select do |shops|
      shops_includes_all_products?(shops, cart)
    end
  end

  def choose_cheapest_product(products)
    products.min { |a, b| a.price <=> b.price }
  end

  def select_and_group_cheapest_products(shops, cart)
    cheapest = []
    all_products_from_n_shops_by_cart(shops, cart).group_by(&:name).each do |product|
      cheapest << choose_cheapest_product(product[1])
    end
    cheapest
  end

  def print_shopping_list(products, *opt)
    products.each do |item|
      puts item.shop
      item.products.each { |product| puts product }
      puts sumstr(item) if opt.include? :sort
    end
    puts sumstr(products) unless opt.include? :sort
  end

  def sumstr(item)
    sumpref = '====== suma: '
    sumpref + item.sum.to_s
  end
end
