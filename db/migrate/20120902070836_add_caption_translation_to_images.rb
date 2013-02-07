class AddCaptionTranslationToImages < ActiveRecord::Migration
  def up

    unless defined?(CarouselImage::Translation) && CarouselImage::Translation.table_exists?
      CarouselImage.create_translation_table!({:caption => :text}, {:migrate_data => true})
    end

    unless defined?(HomeImage::Translation) && HomeImage::Translation.table_exists?
      HomeImage.create_translation_table!({:caption => :text}, {:migrate_data => true})
    end

  end

  def down

    CarouselImage.drop_translation_table! :migrate_data => true
    HomeImage.drop_translation_table! :migrate_data => true
  end
end
