module FilterByParams
  extend ActiveSupport::Concern


  #
  # filterable_params creates a parameter function `apply_filters` that
  # automatically filters activerecord results by params when applied
  # :param is required for each entry as is type (as defined below).
  # :field is required where the database field differs from the parameter
  # passed in the API call.
  #
  # valid `types` include:
  # :exact => search where the field is an exact match to the parameter
  # :text => where clause using ILIKE
  # :boolean => where if the value is true
  # :enum => where a value matches an enumeration map, or defaults
  #          requires :enum to be a hash, and :default to be a symbol
  # :callback => uses a lambda to determine how to move forward
  #              the passed function must be a lambda of signature:
  #                `lambda do |query, value, filters|`
  #              AND MUST RETURN AN ACTIVERECORD QUERY OBJECT
  #              Does not support joins or fields outside the calling model
  #

  included do
    def self.filterable_params(filterables)
      define_method(:apply_filters) do |to_filter|
        filters = {}
        list = filterables.reduce(to_filter) do |m, f|
          fieldname = f.fetch(:field, f[:param])

          if f[:type] == :geocoords && params[:lat].present? && params[:lon].present? && m.respond_to?(:near)
            filters[:lon] = params[:lon]
            filters[:lat] = params[:lat]
            m.near([params[:lat], params[:lon]], 100)
          elsif params[f[:param]].present?
            filters[f[:param]] = params[f[:param]]

            case f[:type]
            when :exact
              m.where(fieldname => filters[f[:param]])
            when :text
              cls = m.table.name.classify.constantize
              m.where(cls.arel_table[fieldname].matches("%#{filters[f[:param]]}%"))
            when :boolean
              m.where(fieldname => true)
            when :enum
              filters[f[:param]] =
                if f[:enum].include?(filters[f[:param]])
                  f[:enum][filters[f[:param]]]
                else
                  f[:default]
                end
              m.where(fieldname => filters[f[:param]])
            when :callback
              f[:fn].call(m, filters[f[:param]], filters)
            else
              m
            end
          else
            m
          end
        end

        list = list.limit(params[:limit].to_i) if params[:limit].to_i.positive?

        [list, filters]
      end
    end
  end
end
