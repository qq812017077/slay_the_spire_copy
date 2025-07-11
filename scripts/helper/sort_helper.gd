
class_name SortHelper
extends Object

static func custom_stable_sort(array: Array, comparator: Callable) -> Array:
    var indices := range(array.size())
    indices.sort_custom(
        func(a_i, b_i):
            var a = array[a_i]
            var b = array[b_i]
            if comparator.call(a, b):
                return true
            elif comparator.call(b, a):
                return false
            else:
                return a_i < b_i
    )
    return indices.map(func(i): return array[i])
