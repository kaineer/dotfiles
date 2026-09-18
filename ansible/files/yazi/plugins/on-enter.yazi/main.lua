--- @sync entry
return {
	entry = function()
		local h = cx.active.current.hovered

    if h then
		  if h.link_to then
		  	ya.emit("follow", {})
		  elseif h.cha.is_dir then
		  	ya.emit("enter", {})
		  else
		  	ya.emit("open", { hovered = true })
		  end
    end
	end,
}
