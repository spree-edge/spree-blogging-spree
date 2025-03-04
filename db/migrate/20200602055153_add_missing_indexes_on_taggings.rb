require 'acts-as-taggable-on'

class AddMissingIndexesOnTaggings < ActiveRecord::Migration[4.2]
  def change
    add_index ActsAsTaggableOn.taggings_table, :tag_id unless index_exists? ActsAsTaggableOn.taggings_table, :tag_id
    add_index ActsAsTaggableOn.taggings_table, :taggable_id unless index_exists? ActsAsTaggableOn.taggings_table, :taggable_id
    add_index ActsAsTaggableOn.taggings_table, :taggable_type unless index_exists? ActsAsTaggableOn.taggings_table, :taggable_type
    add_index ActsAsTaggableOn.taggings_table, :tagger_id unless index_exists? ActsAsTaggableOn.taggings_table, :tagger_id
    add_index ActsAsTaggableOn.taggings_table, :context unless index_exists? ActsAsTaggableOn.taggings_table, :context

    unless index_exists? ActsAsTaggableOn.taggings_table, [:tagger_id, :tagger_type]
      add_index ActsAsTaggableOn.taggings_table, [:tagger_id, :tagger_type]
    end

    unless index_exists? ActsAsTaggableOn.taggings_table, [:taggable_id, :taggable_type, :tagger_id, :context], name: 'taggings_idy'
      add_index ActsAsTaggableOn.taggings_table, [:taggable_id, :taggable_type, :tagger_id, :context], name: 'taggings_idy'
    end
  end
end
