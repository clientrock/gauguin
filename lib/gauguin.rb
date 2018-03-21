require "gauguin/version"
require "gauguin/color"
require "gauguin/color_space"
require "gauguin/colors_retriever"
require "gauguin/colors_limiter"
require "gauguin/colors_clusterer"
require "gauguin/noise_reducer"
require "gauguin/painting"
require "gauguin/image"

module Gauguin
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new

    yield(configuration) if block_given?
  end

  class Configuration
    DEFAULT_MAX_COLORS_COUNT = 10
    DEFAULT_COLORS_LIMIT = 10000
    DEFAULT_MIN_PERCENTAGE_SUM = 0.981
    DEFAULT_MIN_COLOR_PERCENTAGE = 0.01
    DEFAULT_COLOR_SIMILARITY_THRESHOLD = 25
    DEFAULT_COLOR_SIMILARITY_METHOD = :lab

    attr_accessor :max_colors_count, :colors_limit,
      :min_percentage_sum, :min_color_percentage, :color_similarity_threshold,
      :color_similarity_method, :debug

    def initialize
      @max_colors_count = DEFAULT_MAX_COLORS_COUNT
      @colors_limit = DEFAULT_COLORS_LIMIT
      @min_percentage_sum = DEFAULT_MIN_PERCENTAGE_SUM
      @min_color_percentage = DEFAULT_MIN_COLOR_PERCENTAGE
      @color_similarity_threshold = DEFAULT_COLOR_SIMILARITY_THRESHOLD
      @color_similarity_method = DEFAULT_COLOR_SIMILARITY_METHOD
      @debug = false
    end
  end
end

Gauguin.configure

