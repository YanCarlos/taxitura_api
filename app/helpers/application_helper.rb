module ApplicationHelper
	
	def is_this_menu_item_active? controller
		controller_name.to_sym == controller ? 'active' : ''
	end

	def random_color
		'%06x' % (rand * 0xffffff)
	end

	def get_short_name name
		name.split.map(&:chr).join[0..1].upcase
	end
end
