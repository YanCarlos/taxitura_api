module ApplicationHelper
	
	def is_this_menu_item_active? controller
		controller_name.to_sym == controller ? 'active' : ''
	end
end
