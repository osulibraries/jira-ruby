module JIRA
  module Resource

    class SearchResults

      def initialize(client, options = {})

        @client = client

        @page = options[:page].to_i || 1
        @page_size = options[:page_size] || client.options[:max_results]

        start_at = (@page - 1) * @page_size
        max_results = @page_size

        jql = options[:jql] || ''
        fields = options[:fields] || client.options[:search_fields]
        expand = options[:expand] || ''

        response = @client.get(@client.options[:rest_base_path] + "/search?jql=" + CGI.escape(jql) + "&startAt=#{start_at}" + "&maxResults=#{max_results}" + "&fields=#{fields}" + "&expand=#{expand}")

        @query_results = Issue.parse_json(response.body)
        @issues = @query_results['issues'].map do |issue|
          client.Issue.build(issue)
        end
      end


      def previous_page
        @page == 1 ? @page : @page - 1
      end

      def next_page
        (@page == total_pages ? total_pages : @page + 1)
      end

      def current_page
        @page
      end

      def total_pages
        (@query_results['total'] / @page_size)+1
      end

      def each(&block)
        @issues.each(&block)
      end

      def empty?
        @issues.empty?
      end


      def method_missing(method_name, *args, &block)
        if @issues.respond_to? method_name
          @issues.send(method_name, *args, &block)
        else
          super(method_name, *args, &block)
        end
      end

    end
  end
end
