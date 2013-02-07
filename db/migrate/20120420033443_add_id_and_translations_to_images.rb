class AddIdAndTranslationsToImages < ActiveRecord::Migration

  def up
    add_column :site_images, :id, :primary_key

    SiteImage.reset_column_information
    unless defined?(SiteImage::Translation) && SiteImage::Translation.table_exists?
      SiteImage.create_translation_table!({:caption => :text}, {:migrate_data => true})
    end
  end

  def down
    SiteImage.reset_column_information

    SiteImage.drop_translation_table! :migrate_data => true

    remove_column :site_images, :id
  end

end
