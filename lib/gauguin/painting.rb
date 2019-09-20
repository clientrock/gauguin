module Gauguin
  class Painting
    def initialize(path, image_repository = nil, colors_retriever = nil,
                   colors_limiter = nil, noise_reducer = nil,
                   colors_clusterer = nil, image_recolorer = nil)
      @image_repository = image_repository || Gauguin::ImageRepository.new
      @image = @image_repository.get(path)
      @colors_retriever = colors_retriever || Gauguin::ColorsRetriever.new(@image)
      @colors_limiter = colors_limiter || Gauguin::ColorsLimiter.new
      @noise_reducer = noise_reducer || Gauguin::NoiseReducer.new
      @colors_clusterer = colors_clusterer || Gauguin::ColorsClusterer.new
      @image_recolorer = image_recolorer || Gauguin::ImageRecolorer.new(@image)
    end

    def palette
      colors = @colors_retriever.colors
      colors = @colors_limiter.call(colors)
      colors_clusters = @colors_clusterer.clusters(colors)
      @noise_reducer.call(colors_clusters)
    end
  end
end

