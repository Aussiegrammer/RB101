ADJECTIVES = %w(quick lazy sleepy ugly)
NOUNS = %w(fox dog head leg)
VERBS = %w(jumps lifts bites licks)
ADVERBS = %w(easily lazily noisily excitedly)

def madlibs(file)
  File.open(file).each do |line|
    puts format(line, noun:      NOUNS.sample,
                      adjective: ADJECTIVES.sample,
                      verb:      VERBS.sample,
                      adverb:    ADVERBS.sample)
  end
end

p madlibs('sample2.txt')

def star(n)
  inner_gap = (n - 3) / 2
  outer_gap = 0
  (n / 2).times do
    puts " " * outer_gap + "*" +
         " " * inner_gap + "*" +
         " " * inner_gap + "*" +
         " " * outer_gap
    inner_gap -= 1
    outer_gap += 1
  end
  puts "*" * n
  (n / 2).times do
    inner_gap += 1
    outer_gap -= 1
    puts " " * outer_gap + "*" +
         " " * inner_gap + "*" +
         " " * inner_gap + "*" +
         " " * outer_gap

  end
end

# star(7)
# star(9)
star(11)

# LS Method

def print_row(grid_size, distance_from_center)
  number_of_spaces = distance_from_center - 1
  spaces = ' ' * number_of_spaces
  output = Array.new(3, '*').join(spaces)
  puts output.center(grid_size)
end

def star(grid_size)
  max_distance = (grid_size - 1) / 2
  max_distance.downto(1) { |distance| print_row(grid_size, distance) }
  puts '*' * grid_size
  1.upto(max_distance)   { |distance| print_row(grid_size, distance) }
end

# Write a method that takes a 3 x 3 matrix in Array of Arrays format and returns the transpose of the original matrix. Note that there is a Array#transpose method that does this
# -- you may not use it for this exercise. You also are not allowed to use the Matrix class from the standard library. Your task is to do this yourself.

def transpose(matrix)
  new_matrix = Array.new(3) {Array.new}
  matrix.each_with_index do |_, row|
    3.times do |column|
      new_matrix[row] << matrix[column][row]
     end
    end

  new_matrix
end

# LS Method, uses range (which was my first idea) instead, and uses map to assign to a new instead of creating a new empty array and filling it


# def transpose(matrix)
#   result = []
#   (0..2).each do |column_index|
#     new_row = (0..2).map { |row_index| matrix[row_index][column_index] }
#     result << new_row
#   end
#   result
# end

matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

new_matrix = transpose(matrix)

p new_matrix == [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
p matrix == [[1, 5, 8], [4, 7, 2], [3, 9, 6]]

puts

# Modify your transpose method from the previous exercise so it works with any matrix with at least 1 row and 1 column.

p transpose([[1, 2, 3, 4]]) == [[1], [2], [3], [4]]
p transpose([[1], [2], [3], [4]]) == [[1, 2, 3, 4]]
p transpose([[1, 2, 3, 4, 5], [4, 3, 2, 1, 0], [3, 7, 8, 6, 2]]) ==
  [[1, 4, 3], [2, 3, 7], [3, 2, 8], [4, 1, 6], [5, 0, 2]]
p transpose([[1]]) == [[1]]