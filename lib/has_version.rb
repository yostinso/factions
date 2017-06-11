module HasVersion
  def self.included(base)
    def base.version_attr(*attrs)
      attrs.each do |attr|
        raise ArgumentError, "Invalid version attribute #{attr}" unless has_attribute?(attr)
        define_method(attr) do
          Gem::Version.new(read_attribute(attr))
        end
        define_method("#{attr}=") do |new_version|
          write_attribute(attr, new_version.to_s)
        end
      end
    end

    def base.sql_version_split(field)
      field = Arel::Nodes::Quoted.new(field) if field.is_a?(String)
      Arel::Nodes::NamedFunction.new("version_split", [ field ])
    end
  end


end
