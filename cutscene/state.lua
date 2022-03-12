function stateManager()
	local s = {}
	s.states = {}
	s.state_overlay = {}
	s.active_state = ""
	
	function s.active(name) -- function called when a scene starts
		s.active_state = name
		s.states[name].on_active()
	end
	
	function s.add(e,name)
		s.mgr = s
		s.states[name] = e
	end
	
	function s.pop() -- delete the first index from the table, as in Javascript "shift" function
		table.remove(s.state_overlay,1)
		if #s.state_overlay > 1 then
			s.state[1].on_active()
		end
	end
	
	function s.push(e) -- add an item to the first index of the table
		s.mgr = s
		table.insert(s.state_overlay,1,e)
		e.on_active()
	end
	
	function s.update(dt)
		for i=#s.state_overlay,1,-1 do
			s.state_overlay[i].update(dt)
		end
		s.states[s.active_state].update(dt)
	end
	
	function s.draw()
		s.states[s.active_state].draw()
		for i=#s.state_overlay,1,-1 do
			s.state_overlay[i].draw()
		end
	end
	return s
end