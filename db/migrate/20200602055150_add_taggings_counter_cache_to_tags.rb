require 'acts-as-taggable-on'

class AddTaggingsCounterCacheToTags < SpreeExtension::Migration[4.2]
  def self.up
    add_column ActsAsTaggableOn.tags_table, :taggings_count, :integer, default: 0

    ActsAsTaggableOn::Tag.reset_column_information
    ActsAsTaggableOn::Tag.find_each do |tag|
      ActsAsTaggableOn::Tag.reset_counters(tag.id, ActsAsTaggableOn.taggings_table)
    end
  end

  def self.down
    remove_column ActsAsTaggableOn.tags_table, :taggings_count
  end
end
