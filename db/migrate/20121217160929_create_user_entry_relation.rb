# -*- coding: utf-8 -*-
class CreateUserEntryRelation < ActiveRecord::Migration

  class Entry < ActiveRecord::Base
  end

  def up
    add_column :entries, :user_id, :integer, :after => :id

    user_map = { 'cwh' => 'Christopher Hofmann',
      'aplanas' => 'Alberto Planas Domínguez',
      'miska' => 'Michal Hrušecký',
      'cartman' => 'İsmail Dönmez',
      'coolo' => 'Stephan Kulow',
      'lnussel' => 'Ludwig Nussel',
      'maxlin' => 'Max Lin',
      'wstephenson' => 'Will Stephenson',
      'toscalix' => 'Agustin Benito Bethencourt',
      'jos' => 'Jos Poortvliet' }
    
    Entry.find_by_sql('SELECT DISTINCT user FROM entries').map do |record|
      puts record.user.inspect
      newid = User.find_or_create_by_name( user_map[record.user.strip.downcase] || record.user ).id
      execute "UPDATE entries SET user_id = #{newid} WHERE user = '#{record.user}';"
    end

    remove_column :entries, :user
  end

  def down
  end
end
