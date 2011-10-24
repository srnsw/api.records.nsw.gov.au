module PurchaseHelper

  def can_order_copy series
    [9590, 12462, 13495, 13660, 19348].include? series
  end

  def can_pre_order_copy series
    not [13278, 15244].include? series
    #[475, 9590, 12462, 13495, 13660, 15051, 19348].include? series
  end
  
end