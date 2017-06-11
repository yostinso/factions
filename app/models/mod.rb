class Mod < ApplicationRecord
  validates :name, :mod_releases, presence: true

  has_many :mod_releases, inverse_of: :mod, autosave: true, dependent: :destroy do
    def current_release
      newest.first
    end
  end

  def self.from_json(json)
    m = Mod.new(
      name: json[:name],
      title: json[:title],
      summary: json[:summary],
      description: json[:description],
      author: json[:owner],
    )

    if json.has_key?(:releases)
      json[:releases].each do |release|
        m.mod_releases << ModRelease.from_json(m, release)
      end
    elsif json.has_key?(:latest_release)
        m.mod_releases << ModRelease.from_json(m, json[:latest_release])
    end
    
    unless m.valid?
      raise ArgumentError, m.errors.full_messages.join(", ")
    end
    m
  end

  def supports_version?(game_version)
    self.mod_releases.supporting_version(game_version).exists?
  end
end
