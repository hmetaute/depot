class Product < ActiveRecord::Base
default_scope :order => 'title'
has_many :line_items
before_destroy :ensure_not_referenced_by_any_line_item
# ensure that there are no line items referencing this product
def ensure_not_referenced_by_any_line_item
	if line_items.count.zero?
		return true
	else
		errors[:base] << "Line Items present"
		return false
	end
end

#validations
validates_presence_of :title, :description, :image_url, :message => "el titulo no debe ser vacio"
validates_length_of :title, :minimum => 10, :message => "el titulo debe tener como minimo 10 chars long"
validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
validates :title, :uniqueness => true
validates :image_url, :format => {
	:with => %r{\.(gif|jpg|png)$}i,
	:message => 'must be a URL for GIF, JPG or PNG image.'
}
 
end
