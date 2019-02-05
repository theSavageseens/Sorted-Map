note
	description: "[
		This utility class contains a merge sort and
		concatenate of two arrays.
		You must complete the TO DO parts
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	UTIL [G -> COMPARABLE]

feature -- queries


	concatenate (a: ARRAY [G]; b: ARRAY [G]): ARRAY [G]
		require
			constraints_on_lower_indices:
				-- Do not modify this precondition.
				a.lower = 1 and b.lower = 1
		do
			create Result.make_empty
			-- TO DO
			across a.lower |..| a.count as a_index loop Result.force (a[a_index.item], Result.count + 1) end
			across b.lower |..| b.count as b_index loop Result.force (b[b_index.item], Result.count + 1) end
		ensure
			constraint_on_lower_index:
				-- Do not modify this postcondition.
				Result.lower = 1
			correct_size:
				-- TO DO: replace False with your postcondition.
				Result.count = a.count + b.count

			correct_contents:
				-- TO DO: replace False with your postcondition.
				-- The final result must be the concatenation of
				-- the two argument arrays.
				-- Hint: You may use `across' as a universal quantifier.
				across a.lower |..| a.count as a_index all Result[a_index.item] ~ a[a_index.item] end
					and across b.lower |..| b.count as b_index all Result[b_index.item + a.count] ~ b[b_index.item] end

		end

	merge (left, right: ARRAY[G]): ARRAY[G]
			-- Result is a sorted merge of `left' and `right'
		require
			left_sorted:
				-- TO DO: replace False with your precondition.
				across left.lower |..| (left.count - 1) as l_index all left[l_index.item] <= left[l_index.item + 1] end

			right_sorted:
				-- TO DO: replace False with your precondition.
				across right.lower |..| (right.count - 1) as r_index all right[r_index.item] <= right[r_index.item + 1] end
		local
			l, r: ARRAY[G]
		do
			-- TO DO
			-- Bacause left.lower and right.lower is always be 1, so I simply use 1 to instead of the lower
			from
				create Result.make_empty
				create l.make_from_array (left)
				create r.make_from_array (right)
			until
				l.is_empty or r.is_empty
			loop
				if
					l[l.lower] <= r[r.lower]
				then
					Result.force(l[l.lower], Result.count + 1)
					l.remove_head (1)
					l.rebase(1)
				else
					Result.force(r[r.lower], Result.count + 1)
					r.remove_head (1)
					r.rebase(1)
				end
			end
			across l.lower |..| l.count as left_index loop Result.force (l[left_index.item], Result.count + 1) end
			across r.lower |..| r.count as right_index loop Result.force (r[right_index.item], Result.count + 1) end

		ensure
			merge_count:
				-- TO DO: replace False with your postcondition.
				-- Hint: What is the size of Result?
				Result.count = (old left.deep_twin).count + (old right.deep_twin).count

			sorted_non_descending:
				-- TO DO: replace False with your postcondition.
				-- Hint: Result is sorted in a non-descending order.
				across 1 |..| (Result.count - 1) as index all Result[index.item] <= Result[index.item + 1] end

			merge_contains_left_and_right:
				-- TO DO: replace False with your postcondition.
				-- Hint: The result only contains elements from `left' and `right'.
				across 1 |..| Result.count as index all (old left.twin).has(Result[index.item])
					or (old right.twin).has(Result[index.item])end

		end


	merge_sort(a: ARRAY[G]): ARRAY[G]
			-- reteurn a sorted version of array `a'
		local
			low, mid, high: INTEGER
			a1, a2: ARRAY[G]
		do
			create Result.make_from_array (a)
			low := a.lower
			high := a.upper
			if low < high then
				check a.count > 1 end
				mid := (low + high) // 2
				a1 := a.subarray (low, mid)
				a2 := a.subarray (mid + 1, high)
				a2.rebase (1)
				a1 := merge_sort (a1)
				a2 := merge_sort (a2)
				Result := merge (a1, a2)
			end
		ensure
			same_count:
				-- TO DO: replace False with your postcondition.
				-- Hint: What is the size of Result?
				Result.count = (old a.deep_twin).count

			sorted_non_descending:
				-- TO DO: replace False with your postcondition.
				-- Hint: Result is sorted in a non-descending order.
				across 1 |..| (Result.count - 1) as index all Result[index.item] <= Result[index.item + 1] end

			permutation:
				-- TO DO: replace False with your postcondition.
				-- Hint: You may want to use {ARRAY}occurrences
				across 1 |..| Result.count as index all (old a.twin).has(Result[index.item])
					and (old a.twin).occurrences (Result[index.item]) = Result.occurrences (Result[index.item])  end

		end
end
