class AddGinIndex < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def up
    execute 'CREATE EXTENSION pg_trgm;'
    execute 'CREATE INDEX CONCURRENTLY index_hostnames_trigram ON dns_records USING gin(hostnames gin_trgm_ops);'
  end

  def down
    execute 'DROP INDEX IF EXISTS index_hostnames_trigram;'
    execute 'DROP EXTENSION IF EXISTS pg_trgm;'
  end
end
