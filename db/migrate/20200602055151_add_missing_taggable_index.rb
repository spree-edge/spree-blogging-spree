require 'acts-as-taggable-on'

class AddMissingTaggableIndex < ActiveRecord::Migration[4.2]
  def self.up
    add_index ActsAsTaggableOn.taggings_table, [:taggable_id, :taggable_type, :context], name: 'taggings_taggable_context_idx'
  end

  def self.down
    remove_index ActsAsTaggableOn.taggings_table, name: 'taggings_taggable_context_idx'
  end
end
