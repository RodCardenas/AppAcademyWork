# String: Caesar cipher
#
# * Implement a Caesar cipher: http://en.wikipedia.org/wiki/Caesar_cipher
#
# Example:
#   `"hello".caesar(3) # => "khoor"`
#
# * Assume the text is all lower case letters.
# * You'll probably want to map letters to numbers (so you can shift
#   them). You could do this mapping yourself, but you will want to use
#   the [ASCII codes][wiki-ascii], which are accessible through
#   `String#ord` or `String#each_byte`. To convert back from an ASCII code
#   number to a character, use `Fixnum#chr`.
# * Important point: ASCII codes are all consecutive!
#     * In particular, `"b".ord - "a".ord == 1`.
# * Lastly, be careful of the letters at the end of the alphabet, like
#   `"z"`! Ex.: `caesar("zany", 2) # => "bcpa"`

# class String
#   def caesar(shift)
#       cipher = self.split("")
#       cipher.map! do |ch|
#           if (ch.ord + shift) > ('z'.ord)
#               ('a'.ord + shift - 1).chr
#           else
#               (ch.ord + shift).chr
#           end
#       end
#       cipher.join("")
#   end
# end

# Hash: Difference
#
# Write a method, `Hash#difference(other_hash)`. Your method should return
# a new hash containing only the keys that appear in one or the other of
# the hashes (but not both!) Thus:
#
# ```ruby
# hash_one = { a: "alpha", b: "beta" }
# hash_two = { b: "bravo", c: "charlie" }
# hash_one.difference(hash_two)
#  # => { a: "alpha", c: "charlie" }
# ```

class Hash
  def difference(other_hash)
      self_k = self.keys
      other_k = other_hash.keys

      dif = {}
      self.each do |key, value|
          dif[key] = value unless self_k.include?(key) && other_k.include?(key)
      end

      other_hash.each do |key, value|
          dif[key] = value unless self_k.include?(key) && other_k.include?(key) || dif.keys.include?(key)
      end

      dif
  end
end

# Stringify
#
# In this exercise, you will define a method `Fixnum#stringify(base)`,
# which will return a string representing the original integer in a
# different base (up to base 16). **Do not use the built-in
# `#to_s(base)`**.
#
# To refresh your memory, a few common base systems:
#
# |Base 10 (decimal)     |0   |1   |2   |3   |....|9   |10  |11  |12  |13  |14  |15  |
# |----------------------|----|----|----|----|----|----|----|----|----|----|----|----|
# |Base 2 (binary)       |0   |1   |10  |11  |....|1001|1010|1011|1100|1101|1110|1111|
# |Base 16 (hexadecimal) |0   |1   |2   |3   |....|9   |A   |B   |C   |D   |E   |F   |
#
# Examples of strings your method should produce:
#
# ```ruby
# 5.stringify(10) #=> "5"
# 5.stringify(2)  #=> "101"
# 5.stringify(16) #=> "5"
#
# 234.stringify(10) #=> "234"
# 234.stringify(2)  #=> "11101010"
# 234.stringify(16) #=> "EA"
# ```
#
# Here's a more concrete example of how your method might arrive at the
# conversions above:
#
# ```ruby
# 234.stringify(10) #=> "234"
# (234 / 1)   % 10  #=> 4
# (234 / 10)  % 10  #=> 3
# (234 / 100) % 10  #=> 2
#                       ^
#
# 234.stringify(2) #=> "11101010"
# (234 / 1)   % 2  #=> 0
# (234 / 2)   % 2  #=> 1
# (234 / 4)   % 2  #=> 0
# (234 / 8)   % 2  #=> 1
# (234 / 16)  % 2  #=> 0
# (234 / 32)  % 2  #=> 1
# (234 / 64)  % 2  #=> 1
# (234 / 128) % 2  #=> 1
#                      ^
# ```
#
# The general idea is to each time divide by a greater power of `base`
# and then mod the result by `base` to get the next digit. Continue until
# `num / (base ** pow) == 0`.
#
# You'll get each digit as a number; you need to turn it into a
# character. Make a `Hash` where the keys are digit numbers (up to and
# including 15) and the values are the characters to use (up to and
# including `F`).

class Fixnum

    @@dec_to_bin = {
        0 => "0",
        1 => "1",
    }

    @@dec_to_dec = {
        0 => "0",
        1 => "1",
        2 => "2",
        3 => "3",
        4 => "4",
        5 => "5",
        6 => "6",
        7 => "7",
        8 => "8",
        9 => "9",
    }

    @@dec_to_hex = {
        0 => "0",
        1 => "1",
        2 => "2",
        3 => "3",
        4 => "4",
        5 => "5",
        6 => "6",
        7 => "7",
        8 => "8",
        9 => "9",
        10 => "a",
        11 => "b",
        12 => "c",
        13 => "d",
        14 => "e",
        15 => "f",
    }

  def stringify(base)

      decimal = 10
      binary = 2
      hexadecimal = 16

      num = self
      result = ""
      pow = 0

      begin
          digit = num / (base ** pow) % base
          #puts " "
          #p "Base = #{base} num = #{num} digit = #{digit}"
          #p "Before assignment: #{result}"
          case base
          when decimal
              result = @@dec_to_dec[digit] + result
          when binary
              result = @@dec_to_bin[digit] + result
          when hexadecimal
              result = @@dec_to_hex[digit] + result
          end
          #p "After assignment: #{result}"
          pow += 1
          #p "digit = #{digit}, num = #{num}, result = #{result} condition = #{num / (base ** pow) == 0}"
      end until num / (base ** pow) == 0
      result

  end

end

# Bonus: Refactor your `String#caesar` method to work with strings containing
# both upper- and lowercase letters.
class String
  def caesar(shift)
      cipher = self.split("")

      upper = (65..90)
      lower = (97..122)

      cipher.map! do |ch|
          case ch.ord
          when upper
              if (ch.ord + shift) > ('Z'.ord)
                  ('A'.ord + shift - 1).chr
              else
                  (ch.ord + shift).chr
              end
          when lower
              if (ch.ord + shift) > ('z'.ord)
                  ('a'.ord + shift - 1).chr
              else
                  (ch.ord + shift).chr
              end
          end
      end
      cipher.join("")
  end
end

#a = "XYZ"
#puts a.caesar(1)
#b = "xyz"
#puts b.caesar(1)
