module JIRA
  class JQL

    def initialize
      @clause = ""
      @and_clauses = []
      @or_clauses = []
      @order_by = []
    end


    def self.create
      JQL.new
    end

    def where(clause)
      @clause = clause
      return self
    end

    def and_where(clause)
      @and_clauses << clause
      return self
    end

    def or_where(clause)
      @or_clauses << clause
      return self
    end

    def order_by(field_and_dir)
      @order_by = []
      @order_by << field_and_dir
      return self
    end


    def add_order_by(field_and_dir)
      @order_by << field_and_dir
      return self
    end


    def open
      where = @clause.empty? ? 'where' : 'and_where'
      send(where,'status not in (resolved,closed)')
      return self
    end

    def external_reporter(external_reporter)
      where = @clause.empty? ? 'where' : 'and_where'
      send(where,"'External Reporter' ~ '#{external_reporter}'")
      return self
    end

    def to_s
      jql = ""
      jql << @clause

      @and_clauses.each do |c|
        jql << " and (#{c})"
      end

      @or_clauses.each do |c|
        jql << " or (#{c})"
      end

      jql << " order by "+ @order_by.join(',') unless @order_by.empty?
      return jql
    end

  end
end