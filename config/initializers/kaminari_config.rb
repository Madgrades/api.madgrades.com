Kaminari.configure do |config|
  config.default_per_page = 25
  config.max_per_page = 100
end

module Kaminari
  module Helpers
    class Tag
      def page_url_for(page)
        @template.url_for params_for(page)
      end
    end

    module HelperMethods
      def url_to_next_page(scope, options = {})
        return unless scope.next_page

        options.merge! url_to_page_options(current_page: scope.current_page)

        Kaminari::Helpers::NextPage.new(self, options).url
      end

      def url_to_prev_page(scope, options = {})
        return unless scope.prev_page

        options.merge! url_to_page_options(current_page: scope.current_page)

        Kaminari::Helpers::PrevPage.new(self, options).url
      end

      def url_to_first_page(scope, options = {})
        return unless scope.total_pages.positive?

        options.merge! url_to_page_options

        Kaminari::Helpers::FirstPage.new(self, options).url
      end

      def url_to_last_page(scope, options = {})
        return unless scope.total_pages.positive?

        options.merge! url_to_page_options(total_pages: scope.total_pages)

        Kaminari::Helpers::LastPage.new(self, options).url
      end

      def url_to_current_page(scope, options = {})
        options.merge! url_to_page_options(page: scope.current_page)

        Kaminari::Helpers::Page.new(self, options).url
      end

      protected

      def url_to_page_options(options = {})
        options.merge(params: { only_path: false })
      end
    end
  end
end