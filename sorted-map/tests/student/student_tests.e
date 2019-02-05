note
	description: "Summary description for {STUDENT_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TESTS
inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			add_boolean_case (agent t5)
			add_boolean_case (agent t6)
		end

feature
	t1: BOOLEAN
		local
			u: UTIL[INTEGER]
			left, right: ARRAY[INTEGER]
			concat, expected: ARRAY[INTEGER]
		do
			comment("t1: concat two INTEGER type arrays which not empty")
			create left.make_empty
			left.force (91, 1)
			left.force (95, 2)
			left.force (96, 3)
			left.force (99, 4)

			create right.make_empty
			right.force (90, 1)
			right.force (94, 2)
			right.force (97, 3)
			right.force (98, 4)

			concat := u.concatenate(left, right)

			create expected.make_empty
			expected.force (91, 1)
			expected.force (95, 2)
			expected.force (96, 3)
			expected.force (99, 4)
			expected.force (90, 5)
			expected.force (94, 6)
			expected.force (97, 7)
			expected.force (98, 8)
			Result := expected ~ concat
			check Result end
		end

	t2: BOOLEAN
		local
			u: UTIL[STRING]
			left, right: ARRAY[STRING]
			concat, expected: ARRAY[STRING]
		do
			comment("t2: concat two STRING type arrays which not empty")
			create left.make_empty
			left.force ("a", 1)
			left.force ("b", 2)
			left.force ("c", 3)
			left.force ("d", 4)

			create right.make_empty
			right.force ("e", 1)
			right.force ("f", 2)
			right.force ("g", 3)
			right.force ("h", 4)

			concat := u.concatenate(left, right)

			create expected.make_empty
			expected.force ("a", 1)
			expected.force ("b", 2)
			expected.force ("c", 3)
			expected.force ("d", 4)
			expected.force ("e", 5)
			expected.force ("f", 6)
			expected.force ("g", 7)
			expected.force ("h", 8)
			concat.compare_objects
			expected.compare_objects
			Result := expected ~ concat
			check Result end
		end

	t3: BOOLEAN
		local
			u: UTIL[STRING]
			left, right: ARRAY[STRING]
			concat, expected: ARRAY[STRING]
		do
			comment("t3: concat an empty array and and a non-empty STRING type array")
			create left.make_empty
			left.force ("a", 1)
			left.force ("b", 2)
			left.force ("c", 3)
			left.force ("d", 4)

			create right.make_empty

			concat := u.concatenate(left, right)

			create expected.make_empty
			expected.force ("a", 1)
			expected.force ("b", 2)
			expected.force ("c", 3)
			expected.force ("d", 4)

			concat.compare_objects
			expected.compare_objects
			Result := expected ~ concat
			check Result end
		end

	t4: BOOLEAN
		local
			u: UTIL[INTEGER]
			left, right: ARRAY[INTEGER]
			concat, expected: ARRAY[INTEGER]
		do
			comment("t4: concat an empty array and and a non-empty INTEGER type array")
			create left.make_empty
			left.force (91, 1)
			left.force (92, 2)
			left.force (93, 3)
			left.force (94, 4)

			create right.make_empty

			concat := u.concatenate(left, right)

			create expected.make_empty
			expected.force (91, 1)
			expected.force (92, 2)
			expected.force (93, 3)
			expected.force (94, 4)
			Result := expected ~ concat
			check Result end
		end

	t5: BOOLEAN
		local
			u: UTIL[INTEGER]
			left, right: ARRAY[INTEGER]
			merge, expected: ARRAY[INTEGER]
		do
			comment("t5: merge two arrays which not empty")
			create left.make_empty
			left.force (22, 1)
			left.force (33, 2)
			left.force (55, 3)
			left.force (66, 4)
			create right.make_empty
			right.force (11, 1)
			right.force (44, 2)
			right.force (77, 3)
			right.force (88, 4)

			merge := u.merge(left, right)

			create expected.make_empty
			expected.force (11, 1)
			expected.force (22, 2)
			expected.force (33, 3)
			expected.force (44, 4)
			expected.force (55, 5)
			expected.force (66, 6)
			expected.force (77, 7)
			expected.force (88, 8)
			Result := expected ~ merge
			check Result end
		end

	t6: BOOLEAN
		local
			u: UTIL[INTEGER]
			before, after, expected: ARRAY[INTEGER]
		do
			comment("t6: test the merge-sort fucntion for an unsorted array")
			create before.make_empty
			before.force (88, 1)
			before.force (77, 2)
			before.force (66, 3)
			before.force (55, 4)
			before.force (44, 5)
			before.force (33, 6)
			before.force (22, 7)
			before.force (11, 8)
			create after.make_empty
			after := u.merge_sort (before)

			create expected.make_empty
			expected.force (11, 1)
			expected.force (22, 2)
			expected.force (33, 3)
			expected.force (44, 4)
			expected.force (55, 5)
			expected.force (66, 6)
			expected.force (77, 7)
			expected.force (88, 8)
			Result := expected ~ after
			check Result end
		end
end
