--this is a lua script for use in conky
require 'cairo'

--main function for conky
function conky_main()
	
	--test if conky window exists
  if conky_window == nil then
        return
  end
  
  --init cairo
  cr = init_cairo()
  local updates=tonumber(conky_parse('${updates}'))
  
  --drawing
  image_path_head="Images/Necron_head.png"
  image_path_tail="Images/Necron_tail.png"
  image_height=100
  start_position_x=0
  start_position_y=0
--  if updates>5 then
      load_image(image_path_head,cr,0,0)
      load_image(image_path_tail,cr,start_position_x,start_position_y+image_height)
--  end

  --destroy cairo
  destroy_cairo()
  cr=nil
  return ""
end

--loads image
function load_image(path,cr,position_x,position_y)
	image = cairo_image_surface_create_from_png (path);
	width = cairo_image_surface_get_width (image);
	height = cairo_image_surface_get_height (image);
	cairo_set_source_surface (cr, image, position_x, position_y);
	cairo_paint (cr);
end

--init cairo
function init_cairo()
	local cs = cairo_xlib_surface_create(conky_window.display,
                                       conky_window.drawable,
                                       conky_window.visual,
                                       conky_window.width,
                                       conky_window.height)
  return cairo_create(cs)
end

--destroy cairo--
function destroy_cairo()
	cairo_destroy(cr)
  cairo_surface_destroy(cs)
end

