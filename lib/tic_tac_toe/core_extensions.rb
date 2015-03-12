# lib/tic_tac_toe/core_extensions.rb
class Array

	def all_empty?
		self.all? {|elem| elem.to_s.empty?}
	end

	def any_empty?
		self.any? { |elem| elem.to_s.empty? }
	end

	def none_empty?
		!any_empty?
	end

end