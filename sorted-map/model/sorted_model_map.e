note
	description: "Summary description for {SORTED_MODEL_MAP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SORTED_MODEL_MAP [K -> COMPARABLE, V -> ANY]

inherit
	SORTED_MAP_ADT[K, V]

create
	make_empty,
	make_from_array,
	make_from_sorted_map

feature -- model

	model: FUN[K,V]
			-- abstraction function
		do
			Result := implementation
		end


feature{NONE} -- attrubutes

	implementation: FUN[K, V]
		--ii
		attribute
			create Result.make_empty
		end

feature{NONE} -- constructors

	make_empty
			-- creates a sorted map without any elements
		do

		end
	make_from_array (array: ARRAY [TUPLE [key: K; val: V]])
			-- creates a sorted map with the elements of the `array'
		do
			create implementation.make_from_array (array)
		end

	make_from_sorted_map (map: SORTED_MAP_ADT [K, V])
			-- creates a sorted map from `other'
		do
			create implementation.make_from_array (map.as_array)
		end

feature -- commands

	put (val: V; key: K) --(key: K; val: V)
			-- puts an element of `key' and `value' into map
			-- behaves like `extend' if `key' does not exist
			-- otherwise behaves like `replace'
			-- NOTE: This method follows the convention of `val'/`key'
		do
			if
				implementation.domain.has (key)
			then
				replace(key,val)
			else
				extend(key, val)
			end
		end

	extend (key: K; val: V)
			-- inserts an element of `key' and `value' into map
		do
			implementation.extend (create {PAIR[K,V]}.make(key,val))
		end

	remove (key: K)
			-- removes an element whose value is `key' from the map
		local
			p : PAIR[K,V]
		do
			implementation.subtract(create {PAIR[K,V]}.make(key,implementation[key]))
		end

	replace (key: K; val: V)
			-- replaces `value' for a given `key'
		do
			remove(key)
			extend(key, val)
		end

	replace_key (old_key, new_key: K)
			-- replaces `old_key' with `new_key' for an element
		do
			extend(new_key, implementation[old_key])
			remove(old_key)
		end

	wipe_out
			--makes an existing map empty
		do
			create implementation.make_empty
		end

feature -- queries

	item alias "[]" (key: K): V assign put
			--returns the value associated with `key'
		do
			Result := implementation[key]
		end

	as_array: ARRAY [TUPLE [key: K; value: V]]
			-- returns an array of tuples sorted by key
		do
			create Result.make_empty
			across sorted_keys as key
			loop
				Result.force([key.item, implementation[key.item]], Result.count + 1 )
			end
		end

	sorted_keys: ARRAY [K]
			-- returns a sorted array of keys
		local
			u: UTIL[K]
		do
			Result := u.merge_sort (implementation.domain.as_array)
		end

	values: ARRAY [V]
			--returns an array of values sorted by key
		do
			create Result.make_empty
			across sorted_keys as key
			loop
				Result.force(implementation[key.item], Result.count + 1)
			end
		end

	has (key: K): BOOLEAN
			-- returns whether `key' exists in the map
		do
			Result := implementation.domain.has (key)
		end

	has_value(val: V): BOOLEAN
			-- returns whether `val' exists in the map
		do
			Result := implementation.range.has (val)
		end

	element (key: K): detachable TUPLE [key: K; val:V]
			-- returns an element of the map (i.e. a tuple [`key', value])
			-- associated with `key'
		do
			if
				Current.has(key)
			then
				Result := [key, item(key)]
			end
		end

	count: INTEGER
			--returns number of elements in the map
		do
			Result := implementation.count
		end

	is_empty: BOOLEAN
			-- returns whether the map is empty
		do
			Result := implementation.is_empty
		end

	min: TUPLE [key: K; val: V]
			--returns the element with the smallest key in the map
		do
			Result := [sorted_keys [1], implementation[sorted_keys [1]]]
		end

	max: TUPLE [key: K; val: V]
			--returns the element with the largest key in the map
		do
			Result := [sorted_keys [implementation.count], implementation[sorted_keys [implementation.count]]]
		end

end
