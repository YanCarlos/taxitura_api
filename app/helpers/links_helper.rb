module LinksHelper
	def icon_link_to text, path, icon
		icon = content_tag(:i, '', class: "fa #{icon}")
		link_to "#{icon} #{text}".html_safe, path, class: 'option-icon' 
	end

	def icon_link_to_delete text, path
		icon = content_tag(:i, '', class: "fa fa-trash")
		link_to(
			"#{icon} #{text}".html_safe, 
			path,
			class: 'option-icon',
			method: :delete,
			data: {
					confirm: '¿Seguro que deseas eliminar el registro?',
					title: 'Eliminando',
					commit: 'Eliminar',
					cancel: 'Cancelar'
			}
		)
	end
end