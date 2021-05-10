class Workplace < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' }, 
    { id: 2, name: '職場1' },
    { id: 3, name: '職場2' },
    { id: 4, name: '職場3' },
    { id: 5, name: '職場4' },
    { id: 6, name: '職場5' }
  ]
 
   include ActiveHash::Associations
   has_many :items
  end