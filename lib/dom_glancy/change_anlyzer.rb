module DomGlancy
  class ChangeAnalyzer
    attr_accessor :change_factors

    def initialize(change_factors = [])
      @change_factors = Array.new(change_factors)[0..4]

      @change_factors << 0   if @change_factors.length == 0
      @change_factors << 1   if @change_factors.length == 1
      @change_factors << 1.2 if @change_factors.length == 2
      @change_factors << 2   if @change_factors.length == 3
      @change_factors << 5  if @change_factors.length == 4
    end

    def compare(element1, element2)
      change_info = element1.change_info(element2)
      deltas = change_info.map { |changed| (element1.send(changed.to_sym) - element2.send(changed.to_sym)).abs }
      comparison_value = deltas.inject { |sum, n| n + n * deltas.count * @change_factors[deltas.count] }
      comparison_value
    end
  end
end
