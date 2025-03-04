require 'acts-as-taggable-on'

class ChangeCollationForTagNames < ActiveRecord::Migration[4.2]
  def up
    if ActsAsTaggableOn::Utils.using_mysql?
      execute("ALTER TABLE #{ActsAsTaggableOn.tags_table} MODIFY name varchar(255) CHARACTER SET utf8 COLLATE utf8_bin;")
    end
  end
end
