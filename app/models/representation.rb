require 'ostruct'
class Representation < OpenStruct
  attr_reader :parent, :children
  
  def initialize(representation = {}, parent = nil)
    super(representation)
    
    @parent     = parent
    @children   = []

    @table      = {}
    @hash_table = {}

    bind_parent(parent)
    represent_children(representation)
    
    bind_parent(parent)
    represent_children(representation)
  end
  
  def represent(type, collection, parent=nil)
    collection = Array(collection)
    collection.map do |item|
      definition_class = definition_class_for_type(type)
      definition_class.new(item, parent)
    end
  end
  
  def definition_class_for_type(type)
    definition_class = convert_key_to_class_string(type)
    Object.const_get(definition_class)
  rescue NameError
    Object.const_set(definition_class, Representation)
  end
  
  private

  def bind_parent(parent)
    if parent
      parent.children.push self
    end
  end
  
  def represent_children(representation)
    return if not representation.is_a? Hash

    representation.each do |entity_type, value|
      add_to_table(entity_type, value)
      add_to_hash_table(entity_type, value)
      new_ostruct_member(entity_type)
    end
  end
  
  def add_to_hash_table(entity_type, value)
    @hash_table[entity_type.to_sym] = value
  end

  def add_to_table(entity_type, value)
    @table[entity_type.to_sym] = case value
    when Array, Hash
      Representer.new(type: entity_type, value: value, parent: self).represent
    else
      value
    end
  end
  
end

