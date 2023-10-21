function add(a, v, index)
	if a == nil then
		warning("add to nil")
		return
	elseif index == nil then
		table.insert(a, v)
	else
		table.insert(a, index, v)
	end
	return v
end

function del(a, dv)
	if a == nil then
		warning("del from nil")
		return
	end
	for i, v in ipairs(a) do
		if v == dv then
			table.remove(a, i)
			return dv
		end
	end
end

function all(a)
	if a == nil then
		return function() end
	end

	local i = 0
	local len = #a
	return function()
		len = len - 1
		i = #a - len
		while a[i] == nil and len > 0 do
			len = len - 1
			i = #a - len
		end
		return a[i]
	end
end

function bool_to_number(value)
    return value and 1 or 0
  end
  