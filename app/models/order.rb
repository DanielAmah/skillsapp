class Order < ApplicationRecord

  before_validation :generate_uuid!, :on => :create
  belongs_to :user
  belongs_to :payment_option
  scope :completed, -> { where(completed: "true") }
  self.primary_key = 'uuid'


  def self.prefill!(options = {})
    @order                = Order.new
    @order.name           = options[:name]
    @order.user_id        = options[:user_id]
    @order.price          = options[:price]
    @order.number         = Order.next_order_number
    @order.payment_option = options[:payment_option] if !options[:payment_option].nil?
    @order.save!

    @order
  end

  def self.paypal_checkout!(option={})
    values = {
      :business => 'dannj@gmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => option[:return_url],
      :rm => 2,
      :invoice => option[:uuid],
      :notify_url => option[:notify_url]
    }

    values.merge! ({
      "amount_1" => option[:price],
      "item_name_1" => option[:name],
      "item_number_1" => option[:uuid],
      "quantity_1" => '1'
    })

    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

  def self.next_order_number
    if Order.count > 0
      Order.order("number DESC").limit(1).first.number.to_i + 1
    else
      1
    end
  end

  def generate_uuid!
    begin
      self.uuid = SecureRandom.hex(16)
    end while Order.find_by(:uuid => self.uuid).present?
  end

  def self.goal
    Settings.project_goal
  end

  def self.percent
    (Order.revenue.to_f / Order.goal.to_f) * 100.to_f
  end

  def self.backers
    Order.completed.count
  end

  def self.revenue
    if Settings.use_payment_options
      Order.where(completed: "true").pluck(:price).map(&:to_f).inject(0, :+)
    else
      Order.completed.pluck(:price).map(&:to_f).inject(0, :+)
    end
  end

  validates_presence_of :name, :price, :user_id
end
