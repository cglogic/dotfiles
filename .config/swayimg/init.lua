-- General config
swayimg.mode = "viewer"             -- mode at startup
swayimg.antialiasing = true         -- anti-aliasing
swayimg.decoration = true           -- window title/buttons/borders
swayimg.overlay = false             -- window overlay mode
swayimg.exif_orientation = true     -- image orientation by EXIF
swayimg.dnd_button = "MouseRight"   -- drag-and-drop mouse button
swayimg.fullscreen = true           -- enable fullscreen mode

-- Image list configuration
swayimg.imagelist.order = "numeric" -- list order
swayimg.imagelist.reverse = false   -- reverse order
swayimg.imagelist.recursive = false -- recursive directory reading
swayimg.imagelist.adjacent = false  -- add adjacent files from same dir
swayimg.imagelist.fsmon = true      -- enable file system monitoring

-- Text overlay configuration
swayimg.text.visible = false         -- overlay visible state
swayimg.text.font = "monospace"      -- font name
swayimg.text.size = 24               -- font size in pixels
swayimg.text.spacing = 0             -- line spacing
swayimg.text.padding = 10            -- padding from window edge
swayimg.text.background = 0x00000000 -- text background color
swayimg.text.shadow = 0x0d000000     -- text shadow color
swayimg.text.timeout = 0             -- layer hide timeout
swayimg.text.status_timeout = 1      -- status message hide timeout

-- Image viewer mode
swayimg.viewer.default_scale = "optimal"      -- default image scale
swayimg.viewer.default_position = "center"    -- default image position
swayimg.viewer.drag_button = "MouseLeft"      -- mouse button to drag image
swayimg.viewer.autocenter = true              -- enable automatic centering
swayimg.viewer.loop = false                   -- disable image list loop mode
swayimg.viewer.preload = 1                    -- number of images to preload
swayimg.viewer.history = 1                    -- number of the history cache
swayimg.viewer.mark_color = 0xff808080        -- mark icon color
swayimg.viewer.pinch_factor = 1.0             -- pinch gesture factor
swayimg.viewer.set_window_background(0xff000000) -- window background color
swayimg.viewer.set_image_chessboard(20, 0xff333333, 0xff4c4c4c) -- chessboard
swayimg.viewer.set_text("topleft", {          -- top left text block scheme
  "File: {name}",
  "Format: {format}",
  "File size: {sizehr}",
  "File time: {time}"
})
swayimg.viewer.set_text("topright", {            -- top right text block scheme
  "Image: {list.index} of {list.total}",
  "Frame: {frame.index} of {frame.total}",
  "Size: {frame.width}x{frame.height}"
})
swayimg.viewer.set_text("bottomleft", {          -- bottom left text block scheme
  "Scale: {scale}"
})

-- bind i key for info
swayimg.viewer.on_key("i", function()
  swayimg.text.visible = !swayimg.text.visible
end)

-- bind Escape key for exit
swayimg.viewer.on_key("Escape", function()
  swayimg.exit()
end)
-- bind q key for exit
swayimg.viewer.on_key("q", function()
  swayimg.exit()
end)

swayimg.viewer.on_key("n", function()
  swayimg.viewer.open("next")
end)
swayimg.viewer.on_key("p", function()
  swayimg.viewer.open("prev")
end)

-- bind the left arrow key to move the image to the left by 1/10 of the application window size
swayimg.viewer.on_key("Left", function()
  local wnd = swayimg.get_window_size()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(math.floor(pos.x + wnd.width / 10), pos.y);
end)
-- bind mouse vertical scroll button with pressed Ctrl to zoom in the image at mouse pointer coordinates
swayimg.viewer.on_mouse("Ctrl-ScrollUp", function()
  local pos = swayimg.get_mouse_pos()
  local scale = swayimg.viewer.get_scale()
  scale = scale + scale / 10
  swayimg.viewer.set_abs_scale(scale, pos.x, pos.y);
end)


-- Slide show mode, same config as for viewer mode with the following defaults:
swayimg.slideshow.timeout = 5                       -- timeout to switch image
swayimg.slideshow.default_scale = "fit"             -- default image scale
swayimg.slideshow.history = 0                       -- number of the history cache
swayimg.slideshow.set_window_background("auto")     -- window background mode
swayimg.slideshow.set_text("topleft", { "{name}" }) -- top left text block scheme


-- Gallery mode
swayimg.gallery.aspect = "fill"                  -- thumbnail aspect ratio
swayimg.gallery.thumb_size = 200                 -- thumbnail size in pixels
swayimg.gallery.padding_size = 5                 -- padding between thumbnails
swayimg.gallery.border_size = 5                  -- border size for selected thumbnail
swayimg.gallery.border_color = 0xffaaaaaa        -- border color for selected thumbnail
swayimg.gallery.selected_scale = 1.15            -- scale for selected thumbnail
swayimg.gallery.selected_color = 0xff404040      -- background color for selected thumbnail
swayimg.gallery.unselected_color = 0xff202020    -- background color for unselected thumbnail
swayimg.gallery.window_color = 0xff000000        -- window background color
swayimg.gallery.pinch_factor = 100.0             -- pinch gesture factor
swayimg.gallery.cache = 100                      -- number of thumbnails stored in memory
swayimg.gallery.preload = false                  -- preloading invisible thumbnails
swayimg.gallery.pstore = false                   -- enable persistent storage for thumbnails
swayimg.gallery.set_text("topleft", {            -- top left text block scheme
  "File: {name}"
})
swayimg.gallery.set_text("topright", {           -- top right text block scheme
  "{list.index} of {list.total}"
})

-- bind q key for exit
swayimg.gallery.on_key("q", function()
  swayimg.exit()
end)

-- exit from application
swayimg.gallery.on_key("Escape", function()
  swayimg.exit()
end)

-- switch to viewer mode
swayimg.gallery.on_key("Return", function()
  swayimg.mode = "viewer"
end)
-- switch to slide show mode
swayimg.gallery.on_key("s", function()
  swayimg.mode = "slideshow"
end)

-- show/hide text overlay
swayimg.gallery.on_key("t", function()
  swayimg.text.visible = not swayimg.text.visible
end)

-- mark/unmark current image
swayimg.gallery.on_key("Insert", function()
  swayimg.gallery.mark_image()
end)

-- remove current image from the image list
swayimg.gallery.on_key("Delete", function()
  local img = swayimg.gallery.get_image()
  if img then
    swayimg.imagelist.remove(img.path)
  end
end)

-- toggle fullscreen
swayimg.gallery.on_key("f", function()
  swayimg.fullscreen = not swayimg.fullscreen
end)

-- toggle anti-aliasing
swayimg.gallery.on_key("a", function()
  swayimg.antialiasing = not swayimg.antialiasing
end)

-- thumbnail zoom in/out
swayimg.gallery.on_key("equal", function()
  swayimg.gallery.thumb_size = swayimg.gallery.thumb_size + 10
end)
swayimg.gallery.on_key("minus", function()
  swayimg.gallery.thumb_size = swayimg.gallery.thumb_size - 10
end)

-- select another thumbnail
swayimg.gallery.on_key("home", function()
  swayimg.gallery.select("first")
end)
swayimg.gallery.on_key("end", function()
  swayimg.gallery.select("last")
end)
swayimg.gallery.on_key("up", function()
  swayimg.gallery.select("up")
end)
swayimg.gallery.on_key("down", function()
  swayimg.gallery.select("down")
end)
swayimg.gallery.on_key("left", function()
  swayimg.gallery.select("left")
end)
swayimg.gallery.on_key("right", function()
  swayimg.gallery.select("right")
end)
swayimg.gallery.on_key("next", function()
  swayimg.gallery.select("pgdown")
end)
swayimg.gallery.on_key("prior", function()
  swayimg.gallery.select("pgup")
end)

-- select another thumbnail (mouse/touchpad)
swayimg.gallery.on_mouse("ScrollUp", function()
  swayimg.gallery.select("up")
end)
swayimg.gallery.on_mouse("ScrollDown", function()
  swayimg.gallery.select("down")
end)
swayimg.gallery.on_mouse("ScrollLeft", function()
  swayimg.gallery.select("left")
end)
swayimg.gallery.on_mouse("ScrollRight", function()
  swayimg.gallery.select("right")
end)

-- thumbnail zoom in/out (mouse/touchpad)
swayimg.gallery.on_mouse("Ctrl+ScrollUp", function()
  swayimg.gallery.thumb_size = swayimg.gallery.thumb_size + 10
end)
swayimg.gallery.on_mouse("Ctrl+ScrollDown", function()
  swayimg.gallery.thumb_size = swayimg.gallery.thumb_size - 10
end)
