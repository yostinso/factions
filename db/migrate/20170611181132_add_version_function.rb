class AddVersionFunction < ActiveRecord::Migration[5.1]
  def self.up
    execute "CREATE OR REPLACE FUNCTION version_split(varchar) RETURNS int[]
      AS $$
      SELECT(string_to_array($1, '.'))::int[]
      $$ IMMUTABLE STRICT LANGUAGE SQL;"
  end
  def self.down
    execute "DROP FUNCTION version_split(varchar)"
  end
end
