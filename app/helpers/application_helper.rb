module ApplicationHelper
  def table_command_list(archive = nil, custom_commands = [])
    @commands = [
      { label: 'Show', path: ->(record) { record } },
      { label: 'Edit', path: ->(record) { [:edit, record] } }
    ]
    if admin?
      if archive == :archive
        @commands << {
          label: 'Archive',
          path: ->(record) { [:archive, record] },
          args: { method: :post, data: { confirm: 'Are you sure?' } }
        }
      elsif archive == :unarchive
        @commands << {
          label: 'Unarchive',
          path: ->(record) { [:unarchive, record] },
          args: { method: :delete, data: { confirm: 'Are you sure?' } }
        }
      end
    end

    @commands + custom_commands
  end
end
