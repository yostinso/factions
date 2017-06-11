class ModRelease < ApplicationRecord
  include HasVersion
  belongs_to :mod, inverse_of: :mod_releases
  version_attr :version, :min_game_version

  scope :supporting_version, lambda { |v|
    v = Gem::Version.new(v) unless v.is_a?(Gem::Version)
    where(
      sql_version_split(arel_table[:min_game_version]).gteq(sql_version_split(v.to_s))
    )
  }

  scope :newest, lambda { 
    order(sql_version_split(arel_table[:version]).desc).limit(1)
  }

  def self.from_json(mod, json)
    r = ModRelease.new(
      mod: mod,
      version: json[:version],
      game_version: json[:info_json][:factory_version],
      min_game_version: json[:game_version],
      download_url: json[:download_url],
      file_name: json[:file_name],
    )

    raise ArgumentError, r.errors.full_messages.join(", ") unless r.valid?
    r
  end
end
