class Occupation < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' }, 
    { id: 2, name: '社員' },
    { id: 3, name: '組長' },
    { id: 4, name: '職場長' },
    { id: 5, name: '課長' },
    { id: 6, name: '工具室' },
    { id: 7, name: '受入G' }
  ]
 
   include ActiveHash::Associations
   has_many :items
  end